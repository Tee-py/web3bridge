//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.4;

import "./IWura.sol";
abstract contract WuraContract is IWura {
    // A contract that stores whitelisted addresse

    mapping(address => bool) internal WhitelistedAddresses;
    address public owner;

    constructor(address _owner) {
        owner = _owner;
    }

    modifier paymentRequired {
        require(msg.value == 1000);
        _;
    }

    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }


    function isWhiteslited(address _address) external override virtual view returns(bool) {
        return WhitelistedAddresses[_address];
    }

    function blackList(address _address) external onlyOwner {
        WhitelistedAddresses[_address] = false;
    }
}