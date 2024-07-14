// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/utils/cryptography/ECDSA.sol";

contract DgenBank {
    mapping(bytes => bool) public invalidSignature;

    // Address of the allowed ERC-20 token
    address public dgtToken = 0xf83911ba0c71F8a9720AC831F1c53677a06bF02E;
    address private backendSigner = 0x9693CD9713496b0712f52E5F0c7b8948abdA824D;

    // Event to log ERC-20 token deposits
    event TokenDeposit(
        address indexed account,
        uint256 amount,
        uint256 timestamp
    );

    // Event to log ERC-20 token withdrawals
    event TokenWithdrawal(
        address indexed account,
        uint256 amount,
        uint256 timestamp
    );

    error SignatureAlreadyClaimed(bytes signature);
    error InvalidSignature(bytes32 hashedMessage, bytes signature);

    // Function to deposit ERC-20 tokens into the contract
    function depositToken(uint256 amount) public {
        require(amount > 0, "Deposit amount must be greater than zero");
        IERC20(dgtToken).transferFrom(msg.sender, address(this), amount);
        emit TokenDeposit(msg.sender, amount, block.timestamp);
    }

    // Function to withdraw ERC-20 tokens from the contract
    function withdrawToken(
        bytes calldata signature,
        uint256 amount,
        uint256 timestamp
    ) public {
        require(!invalidSignature[signature], "Invalid Signature");
        require(
            amount <= IERC20(dgtToken).balanceOf(address(this)),
            "Insufficient token balance"
        );
        _validateSignature(_getHashedMessage(amount, timestamp), signature);

        // Mark the signature as used
        invalidSignature[signature] = true;

        IERC20(dgtToken).transfer(msg.sender, amount);
        emit TokenWithdrawal(msg.sender, amount, block.timestamp);
    }

    // ====================================
    // Claim Reward Signature Helper tools
    // ====================================

    function _validateSignature(
        bytes32 hashedMessage,
        bytes memory signature
    ) internal view {
        // check if signature has already been used
        if (invalidSignature[signature])
            revert SignatureAlreadyClaimed(signature);

        // check if signature matches the signer's address
        if (ECDSA.recover(hashedMessage, signature) != backendSigner)
            revert InvalidSignature(hashedMessage, signature);
    }

    function _getHashedMessage(
        uint256 amount,
        uint256 timestamp
    ) internal view returns (bytes32 hashedMessage) {
        string memory message = string(
            abi.encodePacked(
                Strings.toHexString(tx.origin),
                "_",
                Strings.toString(amount),
                "_",
                Strings.toString(timestamp)
            )
        );

        hashedMessage = keccak256(
            abi.encodePacked(
                "\x19Ethereum Signed Message:\n",
                Strings.toString(bytes(message).length),
                message
            )
        ); // format: address_timestamp_type_quantity
    }
}
