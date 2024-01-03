//SPDX-License-Identifier: MIT

pragma solidity 0.8.14;

contract ExerciseOne {

    address public owner;
    uint public contractBalance;
    address public myAddress;

    constructor () {
        owner = msg.sender;
    }

    function Deposit () public payable {
        contractBalance = address(this).balance;
        myAddress = address(this);
    }

    function withdraw (address _to, uint _amount) public payable {
        payable(_to).transfer(_amount);
        contractBalance = address(this).balance;
    }
}