# Fundraise DApp – Smart Contracts

This repository contains the Solidity smart contracts used for a fundraising module based on a fixed-price token sale.  
The system uses USDC as the payment asset and an ERC20 token as the distributed asset.

## Contracts
- **Fundraise.sol** — Contract handling the token sale logic  
- **OmniRentToken.sol** — ERC20 token contract  
- **MockUSDC.sol** — Mock USDC token used for local/testnet development  

## Overview
The fundraising contract allows users to purchase tokens at a predefined price, manages supply checks, handles USDC transfers, and performs token distribution.  
The structure is modular and can be extended with features such as vesting, limits, phases, or other fundraising mechanics.

## Structure
The repository includes:
- core smart contracts  
- mock assets for testing  
- standard Solidity patterns  
