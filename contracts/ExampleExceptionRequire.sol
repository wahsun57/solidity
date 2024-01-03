//SPDX-License-Identifier: MIT

pragma solidity ^0.8.14;

contract ExampleExceptionRequire {
    mapping(address => uint256) amountReceived;

    function deposit() public payable {
        amountReceived[msg.sender] = msg.value;
    }

    function withdraw(address payable _to, uint256 _amount) public {
        require (amountReceived[msg.sender] >= _amount, "Insufficient Funds, Aborting.");
        amountReceived[msg.sender] -= _amount;
        _to.transfer(_amount);
    }
}
