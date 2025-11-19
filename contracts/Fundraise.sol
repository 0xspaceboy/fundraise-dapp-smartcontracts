// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract Fundraise is Ownable {
    IERC20 public token;
    IERC20 public usdc;

    uint256 public constant PRICE_PER_TOKEN = 1400; // Prezzo corretto senza moltiplicazione

    uint256 public totalTokensSold;
    bool public isFundraiseActive = true;

    constructor(address _tokenAddress, address _usdcAddress, address _ownerAddress) Ownable(_ownerAddress) {
        token = IERC20(_tokenAddress);
        usdc = IERC20(_usdcAddress);
    }

    function buyTokens(uint256 usdcAmount) public {
        require(isFundraiseActive, "Fundraise is not active");

        // Calcolo dei token da acquistare
        uint256 tokensToBuy = (usdcAmount * 10**18) / PRICE_PER_TOKEN;

        require(tokensToBuy > 0, "Amount too small");
        require(token.balanceOf(address(this)) >= tokensToBuy, "Not enough tokens available");

        // Trasferisci USDC al contratto
        bool success = usdc.transferFrom(msg.sender, address(this), usdcAmount);
        require(success, "USDC transfer failed");

        // Trasferisci token all'acquirente
        require(token.transfer(msg.sender, tokensToBuy), "Token transfer failed");

        // Aggiorna i token venduti
        totalTokensSold += tokensToBuy;
    }

    function usdcBalance() public view returns (uint256) {
        return usdc.balanceOf(address(this));
    }

    function withdrawFunds(address to, uint256 amount) public onlyOwner {
        require(to != address(0), "Cannot withdraw to the zero address");
        require(usdc.balanceOf(address(this)) >= amount, "Insufficient USDC balance");
        bool success = usdc.transfer(to, amount);
        require(success, "Withdrawal failed");
    }

    function endFundraise() public onlyOwner {
        require(isFundraiseActive, "Fundraise is already ended");
        isFundraiseActive = false;

        // Trasferisci i token rimanenti all'owner
        uint256 remainingTokens = token.balanceOf(address(this));
        require(token.transfer(owner(), remainingTokens), "Failed to transfer remaining tokens");
    }
}
