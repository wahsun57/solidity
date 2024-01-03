// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

contract WithdrawHalf {
    address public owner;
    uint256 public balance;
    uint256 public contractBalance;

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function deposit() external payable {
        balance += msg.value;
        contractBalance = address(this).balance;
    }

    function withdrawHalf() external onlyOwner {
        require(balance > 0, "No balance to withdraw");

        // Calculate half of the balance
        uint256 amountToWithdraw = balance / 2;

        // Transfer half of the balance to the owner
        payable(owner).transfer(amountToWithdraw);

        // Update the balance after withdrawal
        balance -= amountToWithdraw;
        contractBalance = address(this).balance;
    }

    function getContractBalance() external view returns (uint256) {
        return balance;
    }
}
