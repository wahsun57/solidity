//SPDX-License-Identifier: MIT

pragma solidity 0.8.14;

contract ExampleBoolean {
    bool public myBool;

    function updateBool (bool _updateBool) public {
        myBool = _updateBool;
    }

}