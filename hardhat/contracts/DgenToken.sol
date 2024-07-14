// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract DgenToken is ERC20 {
	address public constant TEST_WALLET =
		0x9693CD9713496b0712f52E5F0c7b8948abdA824D;

	constructor() ERC20("DgenToken", "DGT") {
		uint256 initialSupply = 1000000000 * (10 ** decimals());
		_mint(TEST_WALLET, initialSupply);
	}

	function decimals() public view virtual override returns (uint8) {
		return 18;
	}

	function mint(address to, uint256 amount) external {
		_mint(to, amount);
	}
}