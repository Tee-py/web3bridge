//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.4;

import "./IWhitelist.sol";


contract Calculator {

    IWhitelist WhitelistContractInstance;

    constructor(address WhitelistContractAddr) {
        WhitelistContractInstance = IWhitelist(WhitelistContractAddr);
    }

    function add(uint256 firstVal, uint256 secondVal) external view returns(bool status, uint256 result) {

        bool isWhiteslited = callIsWhitelisted(msg.sender);
        if(!isWhiteslited) return (false, 0);

        return (true, firstVal + secondVal);     

    }

    function subtract(uint256 firstVal, uint256 secondVal) external view returns(bool status, uint256 result) {

        bool isWhiteslited = callIsWhitelisted(msg.sender);

        if(!isWhiteslited) return (false, 0);

        return (true, firstVal - secondVal);       

    }

    function callWhitelist(address thePerson) public payable {
        WhitelistContractInstance.Whitelist{value: msg.value}(thePerson);
    }

    function callIsWhitelisted(address addr) internal view returns(bool status) {
        status = WhitelistContractInstance.isWhiteslited(addr);
    }

    function checkBal() external view returns(uint256) {
        return address(this).balance;
    }
}