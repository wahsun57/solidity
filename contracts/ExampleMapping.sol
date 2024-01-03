// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

contract SampleMapping {

    mapping(uint => bool) public myBool;
    mapping(uint => mapping(uint => bool)) public uintUintMapping;
    mapping(address => bool) public addressMapping;

    function setMyBool (uint _key, bool _value) public {
        myBool[_key] = _value;
    }

    function setMyUintUintBool (uint _key1, uint _key2, bool _value) public {
        uintUintMapping[_key1][_key2] = _value;
    }

    function setAddressMapping (address _address, bool _value) public {
        addressMapping[_address] = _value;
    }

}
       