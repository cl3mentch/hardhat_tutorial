// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IERC20 {
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);
    function transfer(address recipient, uint256 amount) external returns (bool);
    function balanceOf(address account) external view returns (uint256);
}

contract DeezBank {
    // Mapping to keep track of ERC-20 token balances
    mapping(address => mapping(address => uint256)) private tokenBalances;

    // Address of the allowed ERC-20 token
    address public allowedToken;

    // Event to log ERC-20 token deposits
    event TokenDeposit(address indexed account, address indexed token, uint256 amount);

    // Event to log ERC-20 token withdrawals
    event TokenWithdrawal(address indexed account, address indexed token, uint256 amount);

    // Constructor to set the allowed token address
    constructor(address _allowedToken) {
        allowedToken = _allowedToken;
    }

    // Function to deposit ERC-20 tokens into the contract
    function depositToken(address token, uint256 amount) public {
        require(token == allowedToken, "Only the DgenToken can be deposited");
        require(amount > 0, "Deposit amount must be greater than zero");
        require(IERC20(token).transferFrom(msg.sender, address(this), amount), "Token transfer failed");

        tokenBalances[token][msg.sender] += amount;

        emit TokenDeposit(msg.sender, token, amount);
    }

    // Function to withdraw ERC-20 tokens from the contract
    function withdrawToken(address token, uint256 amount) public {
        require(token == allowedToken, "Only the specified token can be withdrawn");
        require(amount <= tokenBalances[token][msg.sender], "Insufficient token balance");
        tokenBalances[token][msg.sender] -= amount;
        require(IERC20(token).transfer(msg.sender, amount), "Token transfer failed");
        emit TokenWithdrawal(msg.sender, token, amount);
    }

    // Function to check the ERC-20 token balance of the caller
    function getTokenBalance(address token) public view returns (uint256) {
        return tokenBalances[token][msg.sender];
    }
}
