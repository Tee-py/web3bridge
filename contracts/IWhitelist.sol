//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.4;

interface IWhitelist {

    function isWhiteslited(address _address) external view returns(bool);
    function Whitelist(address _address) external payable;

}