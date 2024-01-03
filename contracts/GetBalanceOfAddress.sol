// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

contract AccountBalanceChecker {
    // Function to get the balance of the contract
    function getContractBalance() external view returns (uint256) {
        return address(this).balance;
    }

    function deposit ()  payable external {

    }
    // Function to get the balance of a specific address
    function getBalanceOfAddress(address account) external view returns (uint256) {
        return account.balance;
    }
}
