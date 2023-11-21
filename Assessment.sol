// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

contract Assessment {
    address payable public owner;
    uint256 public balance;

    event Deposit(uint256 amount);
    event Withdraw(uint256 amount);
    event GachaResult(address indexed player, string item); // Change the event parameter type to string

    constructor(uint initBalance) payable {
        owner = payable(msg.sender);
        balance = initBalance;
    }

    function getBalance() public view returns(uint256){
        return balance;
    }

    function deposit(uint256 _amount) public payable {
        uint _previousBalance = balance;

        require(msg.sender == owner, "You are not the owner of this account");

        balance += _amount;

        assert(balance == _previousBalance + _amount);

        emit Deposit(_amount);
    }

    error InsufficientBalance(uint256 balance, uint256 withdrawAmount);

    function withdraw(uint256 _withdrawAmount) public {
        require(msg.sender == owner, "You are not the owner of this account");
        uint _previousBalance = balance;
        if (balance < _withdrawAmount) {
            revert InsufficientBalance({
                balance: balance,
                withdrawAmount: _withdrawAmount
            });
        }

        balance -= _withdrawAmount;

        assert(balance == (_previousBalance - _withdrawAmount));

        emit Withdraw(_withdrawAmount);
    }

    function spinGacha() public returns (string memory) { // Change the return type to string
        require(balance >= 10, "Insufficient balance to spin the gacha");
        uint _previousBalance = balance;
        // Spend 10 tokens to spin the gacha
        balance -= 10;

        // Generate a random number between 1 and 100
        uint randomNumber = uint(keccak256(abi.encodePacked(block.difficulty, block.timestamp, balance))) % 100 + 1;

        // Determine the item based on the random number
        string memory item;
        if (randomNumber <= 2) {
            item = "VR Headset";  // 2% chance
        } else if (randomNumber <= 12) {
            item = "Guitar";  // 10% chance
        } else if (randomNumber <= 50) {
            item = "Powerbank";  // 38% chance
        } else {
            item = "Cable";  // 50% chance
        }

        // Emit the gacha result event
        emit GachaResult(msg.sender, item);

        assert(balance == (_previousBalance - 10));

        // Return the obtained item
        return item;
    }
}
