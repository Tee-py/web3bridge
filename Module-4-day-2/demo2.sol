// SPDX-License-Identifier: UNLICENCSE
pragma solidity ^0.8.4;
import "./IDemo.sol";

contract Demo2 {

    function createProfileInDemoContract(address demoAddress, address creator, string memory name) public {
        IDemo demo = IDemo(demoAddress);
        demo.createProfile(creator, name);
    }

}
