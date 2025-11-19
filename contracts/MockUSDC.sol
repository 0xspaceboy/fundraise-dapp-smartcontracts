// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MockUSDC is ERC20 {
    constructor() ERC20("Mock USDC", "USDC") {
        _mint(msg.sender, 1000000000 * 10 ** decimals()); // 1 miliardo di USDC iniziali
    }

    function decimals() public pure override returns (uint8) {
        return 6; // USDC ha 6 decimali
    }
}
