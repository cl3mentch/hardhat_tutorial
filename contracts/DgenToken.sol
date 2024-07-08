// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";

contract DgenToken is ERC20, AccessControl {
    constructor(
        string memory name_,
        string memory symbol_,
        uint8 decimals_,
        uint256 totalSupply_
    ) ERC20(name_, symbol_) {
        // Initialize ERC20 details
        uint256 initialSupply = 100 * (10 ** uint256(decimals_));
        uint256 totalSupply = totalSupply_ * (10 ** uint256(decimals_)); // Example total supply

        _mint(msg.sender, initialSupply);
        _mint(address(this), totalSupply - initialSupply);

        // Grant the deployer the admin role
        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
    }

    // Modifier to check if the caller has the admin role
    modifier onlyAdmin() {
        require(
            hasRole(DEFAULT_ADMIN_ROLE, msg.sender),
            "DgenToken: must have admin role to execute this function"
        );
        _;
    }

    // Custom mint function accessible only by admin
    function mint(address to, uint256 amount) public onlyAdmin {
        _mint(to, amount);
    }

    // Override transferFrom to restrict access to admin
    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) public override onlyAdmin returns (bool) {
        return super.transferFrom(sender, recipient, amount);
    }
}
