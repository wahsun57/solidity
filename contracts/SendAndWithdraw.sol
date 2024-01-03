//SPDX-License-Identifier: MIT

pragma solidity 0.8.16;

contract SendWithdrawMoney {

    uint public balanceReceived;
    uint public acctBal;
    function deposit() public payable {
        balanceReceived += msg.value;
        acctBal = address(this).balance;
    }

    function getContractBalance() public view returns(uint) {
        return address(this).balance;
    }

    function withdrawAll() public {
        address payable to = payable(msg.sender);
        to.transfer(getContractBalance());
    }

    function withdrawToAddress(address payable to) public {
        to.transfer(getContractBalance());
    }
}