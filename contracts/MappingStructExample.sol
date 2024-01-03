//SPDX-License-Identifier: MIT

pragma solidity ^0.8.14;

contract MappingsStructExample {

    uint256 public bal;

    struct Transaction {
        uint amount;
        uint timestamp;
    }

    struct Balance {
        uint totalBalance;
        uint numOfDep;
        mapping (uint => Transaction) deposits;
        uint numOfWithdraw;
        mapping (uint => Transaction) withdrawals;
    }

    mapping (address => Balance) public balanceReceived;

    function getBalance ()  public payable  {
        bal = msg.value;
    }

    function getWithdrawalBalance (address _from, uint _withdraw)  view public returns (Transaction memory) {
       
        return balanceReceived[_from].withdrawals[_withdraw];
    }
    function getDepBalance (address _from, uint _dep) view public returns (Transaction memory) {
        return balanceReceived[_from].deposits[_dep];
    }

    function depositMoney () public payable {

        balanceReceived[msg.sender].totalBalance += msg.value;
        Transaction memory deposit = Transaction (msg.value, block.timestamp);
        balanceReceived[msg.sender].deposits[balanceReceived[msg.sender].numOfDep] = deposit;
        balanceReceived[msg.sender].numOfDep++;

    }

     function withdrawMoney (address payable _to, uint _amount) public payable {

        balanceReceived[msg.sender].totalBalance -= _amount;
        Transaction memory withdraw = Transaction (_amount, block.timestamp);
        balanceReceived[msg.sender].withdrawals[balanceReceived[msg.sender].numOfWithdraw] = withdraw;
        balanceReceived[msg.sender].numOfWithdraw++;
        _to.transfer(_amount);
       
    }

}
