//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.4;

contract WhitelistContract {

    // A contract that stores whitelisted addresse

    mapping(address => bool) internal WhitelistedAddresses;
    address owner;

    constructor() {
        owner = msg.sender;
    }

    modifier paymentRequired {
        require(msg.value == 1000);
        _;
    }

    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }


    function isWhiteslited(address _address) external view returns(bool) {
        return WhitelistedAddresses[_address];
    }

    function Whitelist(address _address) external paymentRequired payable {
        WhitelistedAddresses[_address] = true;
    }

    function blackList(address _address) external onlyOwner {
        WhitelistedAddresses[_address] = false;
    }

}