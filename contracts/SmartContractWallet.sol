//SPDX-License-Identifier: MIT

pragma solidity 0.8.15;

contract consumer {

    function balance () view public returns (uint){
        return address(this).balance;
    }

    function deposit () public payable{}
}

contract SampleWallet {

    address payable public owner;

    mapping(address => uint) public allowance;
    mapping(address => bool) public isAllowedToSend;

    mapping(address => bool) public guardian;
    address payable public nextOwner;
    mapping (address => mapping (address => bool)) nextOwnerGuaardianVoteBool;
    uint public guardiansResetCount;
    uint public constant confirmationsFromGuardiansForReset = 3;
    bool public nextOwnerGuardianVote;

    constructor() {
        owner = payable(msg.sender);
    }

    function setGuardian (address _guardian, bool _isGuardian) public {
        require(owner == msg.sender, "You can't set guradian, aborting");
        guardian[_guardian] = _isGuardian;
    }

    function proposeNewOwner(address payable newOwner) public {
        //nextOwnerGuardianVote = nextOwnerGuaardianVoteBool[newOwner][msg.sender];
        require(guardian[msg.sender], "You are no guardian, aborting");
        require(nextOwnerGuaardianVoteBool[newOwner][msg.sender] == false, "you have already voted, aborting");
        
        if(nextOwner != newOwner) {
            nextOwner = newOwner;
            guardiansResetCount = 0;
        }

        guardiansResetCount++;
        nextOwnerGuaardianVoteBool[newOwner][msg.sender] = true;
        nextOwnerGuardianVote = nextOwnerGuaardianVoteBool[newOwner][msg.sender];

        if(guardiansResetCount >= confirmationsFromGuardiansForReset) {
            owner = nextOwner;
            nextOwner = payable(address(0));
        }
    }

    function setAllowance(address _from, uint _amount) public {
        require(msg.sender == owner, "You are not the owner, aborting!");
        allowance[_from] = _amount;
        isAllowedToSend[_from] = true;
    }

    function denySending(address _from) public {
        require(msg.sender == owner, "You are not the owner, aborting!");
        isAllowedToSend[_from] = false;
    }

    function transfer(address payable _to, uint _amount, bytes memory payload) public returns (bytes memory) {
        require(_amount <= address(this).balance, "Can't send more than the contract owns, aborting.");
        if(msg.sender != owner) {
            require(isAllowedToSend[msg.sender], "You are not allowed to send any transactions, aborting");
            require(allowance[msg.sender] >= _amount, "You are trying to send more than you are allowed to, aborting");
            allowance[msg.sender] -= _amount;

        }

        (bool success, bytes memory returnData) = _to.call{value: _amount}(payload);
        require(success, "Transaction failed, aborting");
        return returnData;
    }

    receive() external payable {}
}

