//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.4;
import "./Wura.sol";
contract WuraExtended is WuraContract {
    uint firstNumber;
    constructor(address owner) WuraContract(owner)  {
        firstNumber = 2;
    }
    function Whitelist(address _address) external override paymentRequired payable {
        WhitelistedAddresses[_address] = true;
    }
}