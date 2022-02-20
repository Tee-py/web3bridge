//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.4;

abstract contract IWura {


    function isWhiteslited(address _address) external virtual view returns(bool);

    function Whitelist(address _address) external virtual payable;

}