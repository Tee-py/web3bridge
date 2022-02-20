// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.4;

contract ATM {

    // authentication
    // check balace
    // withdraw
    // transfer
    // buy airtime
    // internet sub
    // address admin;

    address payable admin;

    constructor() {
        admin = payable(msg.sender);
    }

    // mapping(address => uint256) public balances;

    modifier onlyAdmin {
        require(msg.sender == admin, "Only admin is allowed to call this function");
        _;
    }

    // import the interface

    // function checkBalance() public returns()

    receive() external payable {}
    fallback() external payable {}


    function atmBalance() public view returns(uint256) {
        return address(this).balance;
    }

    function withdraw(uint _amount) public onlyAdmin {
        (bool sent,) = msg.sender.call{value: _amount * 10**18}("");
        require(sent, "unable to send");
    }

    function tranfer(address to, uint256 amount) public payable returns(bool){
        require(msg.value == amount, "check the amount you are");
        payable(to).transfer(amount);
        return true;
    }
}