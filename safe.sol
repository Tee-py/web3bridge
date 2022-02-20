// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.12;

contract Safe {

    mapping(address => uint256) public balance;

    uint public totalBalance;

    function save() public payable returns(bool) {
        require(msg.value != 0, "you cannot deposit 0 amount");
        balance[msg.sender] += msg.value;
        totalBalance += msg.value;
        return true;
    }

    function withdraw(uint amount) public returns(bool) {
        require(balance[msg.sender] >= 10 ether);
        require(balance[msg.sender] >= amount);
        balance[msg.sender] -= amount;
        totalBalance -= amount;
        payable(msg.sender).transfer(amount);
        return true;
    }

    function forceWithdraw() public returns(bool) {
        uint balanceOfUser = balance[msg.sender];
        uint penalty = balanceOfUser * 5/100;
        balance[msg.sender] = 0;
        totalBalance -= balanceOfUser;

        payable(address(this)).transfer(penalty);
        payable(msg.sender).transfer(balanceOfUser - penalty);
        return true;
    }

    function contractEtherBal() public view returns (uint) {
        return address(this).balance;
    }

    receive() external payable {}

}