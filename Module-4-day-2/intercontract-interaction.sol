// SPDX-License-Identifier: UNLICENCSE
pragma solidity ^0.8.4;

contract A {

    string name;
    // for setting the state variable "name"
    function setName(string memory _name) external {
        name = _name;
    }

    // for getting the state variable "name"
    function getName() external payable returns(string memory) {
        return name;
    }

    fallback() external payable {}
    receive() external payable {}
}

contract B {
    address contractA;
    constructor(address _contractA) {
        contractA = _contractA;
    }

    // for calling function setName of contract A
    function AsetName(string memory a) external returns(bool status) {
        (status,) = contractA.call(abi.encodeWithSignature("setName(string)", a));
        require(status, "calling setName failed");
        return status;
    }

    // calling function getName of contract A
    function AGetName() external returns(bytes memory) {
        (bool status, bytes memory data) = contractA.call{value: 100}(abi.encodeWithSignature("getName()"));
        require(status, "failed");
        return data;
    }


    // another method using encodeWithSelector
    function AGetName2() external returns(bytes memory) {
        (bool status, bytes memory data) = contractA.call(abi.encodeWithSelector(A.getName.selector));
        require(status, "failed");
        return data;
    }

    function returnSumthing() public pure returns(uint num) {
        num = 2;
    }

    fallback() external payable {}
    receive() external payable {}
}