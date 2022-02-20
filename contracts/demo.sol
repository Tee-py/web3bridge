//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.4;


contract Another {
    
    function pureFunction() public pure returns(string memory) {
        return "hello world";
    }
}

contract FactoryContract {

    address deployed;

    Another another;
    
    function callAnotherPureFunction() public returns(string memory) {
        another = new Another();
        return another.pureFunction();
    }

    function getAnotherAddr() public view returns(address) {
        return address(another);
    }
}