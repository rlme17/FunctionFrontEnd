# Assessment Smart Contract

## Overview

This Solidity smart contract, named `Assessment`, is designed for assessing basic functionalities, including depositing, withdrawing, and spinning a gacha to obtain random items. The contract is written in Solidity version ^0.8.9.

## Features

### Deposit

Users can deposit additional funds into the contract by calling the `deposit` function. Only the owner of the contract (specified during contract deployment) can perform deposits.

### Withdraw

The owner of the contract can withdraw funds by calling the `withdraw` function. An error will be raised if the withdrawal amount exceeds the current balance.

### Spin Gacha

Users can spin the gacha by calling the `spinGacha` function, which costs 10 tokens. The function generates a random number to determine the obtained item. The gacha result is emitted as an event (`GachaResult`), providing the player's address and the obtained item.

## Contract Initialization

The contract is initialized during deployment with an initial balance specified by the deployer. The deployer becomes the owner of the contract.

## Usage

1. **Deposit Funds:**
   - Only the owner can deposit funds.
   - Call the `deposit` function with the desired deposit amount.

2. **Withdraw Funds:**
   - Only the owner can withdraw funds.
   - Call the `withdraw` function with the desired withdrawal amount.

3. **Spin Gacha:**
   - Call the `spinGacha` function to try your luck.
   - The cost is 10 tokens.

## Events

### Deposit
Emitted when a deposit is made.
```solidity
event Deposit(uint256 amount);
```

### Withdraw
Emitted when a withdrawal is made.
```solidity
event Withdraw(uint256 amount);
```

### GachaResult
Emitted when a player spins the gacha.
```solidity
event GachaResult(address indexed player, string item);
```
