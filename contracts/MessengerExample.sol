//SPDX-License-Identifier: MIT

pragma solidity 0.8.14;

contract MessengerExample {

    address public myAddress;
    address public guestAddress;
    string public myString = "You are the best";
    uint public msgUpdate;

    constructor () {
        myAddress = msg.sender;
    }

    function writeString (string memory _newString) public {
        if (myAddress == guestAddress){
            msgUpdate++;
             myString = _newString;
        }
       
    }

    function getGuestAddress (address _guestAddress) public {
        guestAddress = _guestAddress;
    }




    

}