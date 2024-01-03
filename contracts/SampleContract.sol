//SPDX-License-Identifier: MIT

pragma solidity 0.8.14;

contract SampleContract {

    string public myString = "Hello World";
    uint public contractBalance;

    function updateString (string memory _myString) public payable {
        if (msg.value == 1 ether) {
            myString = _myString;
            contractBalance = address(this).balance + contractBalance;
        } else {
            // contractBalance = address(this).balance;
            payable (msg.sender).transfer(msg.value);
            contractBalance = address(this).balance;
            
        }
    }
}