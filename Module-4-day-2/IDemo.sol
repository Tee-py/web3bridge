// SPDX-License-Identifier: UNLICENCSE
pragma solidity ^0.8.4;

interface IDemo {
    struct Profile {
        uint id;
        string name;
    }

    function createProfile(address creator, string memory _name) external;

    function getProfile(address userAddress) external view returns(Profile memory);
}