

// pragma solidity 0.8.14;

// contract WillThrow {
//     function aFunction() public pure  {
//         require(false, "Error error");
//     }

// }
//SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

contract ErrorHandling {
    event ErrorLogging(string reason);
    error ThisIsACustomError(string, string);
    function catchError() public {
        WillThrow will = new WillThrow();
        try will.aFunction() {
            revert ThisIsACustomError("Text 1", "text message 2");
            //here we could do something if it works
        }  catch Error(string memory reason) {
            emit ErrorLogging(reason);
        }
    }
}

contract WillThrow {   
    error ThisIsACustomError(string, string);
    function aFunction() public pure {
        require(true, "Error error");
        //revert ThisIsACustomError("Text 1", "text message 2");
       
    }
}