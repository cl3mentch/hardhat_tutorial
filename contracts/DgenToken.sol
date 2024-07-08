// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract DgenToken is ERC20 {
    string private _name;
    string private _symbol;
    uint8 private _decimals;

    constructor(
        string memory name_,
        string memory symbol_,
        uint8 decimals_,
        uint256 initialSupply_
    ) ERC20(name_, symbol_) {
        _name = name_;
        _symbol = symbol_;
        _decimals = decimals_;
        _mint(msg.sender, initialSupply_ * (10 ** uint256(decimals_)));
    }
}
