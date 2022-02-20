// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.4;

contract MultiSig {
    mapping(address => bool) ownersMapping;
    mapping(uint => mapping(address => bool)) public transactionIsApprovedBy;

    uint minimumApprovalRequired;

    struct TransactionData {
        uint id;
        address toAddress;
        uint256 amount;
        address requestedBy;
        uint256 timeStamp;
        uint numberOfApproval;
        bool status;
    }

    TransactionData[] public transactionsArray;

    constructor(address[] memory _owners, uint _minimumApprovalRequired) {
        require(_minimumApprovalRequired <= _owners.length);
        minimumApprovalRequired = _minimumApprovalRequired;
        for(uint i; i < _owners.length; i++) {
            address _owner = _owners[i];
            require(ownersMapping[_owner] == false, "Admin duplicate");
            ownersMapping[_owner] = true;
        }
    }

    modifier onlyOnwers {
        require(ownersMapping[msg.sender] == true, "only the owners can call this this function");
        _;
    }


    function requestTransaction(uint _amount, address _to) external onlyOnwers returns(uint) {
        uint _id = transactionsArray.length;
        transactionIsApprovedBy[_id][msg.sender] = true;
        TransactionData memory transact = TransactionData(_id, _to, _amount, msg.sender, block.timestamp, 1, false);
        transactionsArray.push(transact);
        return _id;
    }

    function approveTransaction(uint _transactionId) external onlyOnwers returns(uint) {
        require(transactionIsApprovedBy[_transactionId][msg.sender] == false, "You have already approved this transction");
        transactionIsApprovedBy[_transactionId][msg.sender] = true;
        return ++transactionsArray[_transactionId].numberOfApproval;
    }

    function checkTransactionApprovalCount(uint _transactionId) external view returns(uint) {
        return transactionsArray[_transactionId].numberOfApproval;
    }
    

    function sendATransaction(uint _txID) onlyOnwers external returns(bool){
        TransactionData memory transactionToBeSent = transactionsArray[_txID];
        require(transactionToBeSent.numberOfApproval >= minimumApprovalRequired, "mininum approval not reached yet");
        require(transactionToBeSent.status == false, "This transaction has been fulfilled");
        transactionsArray[_txID].status = true;
        uint amountToSend = transactionToBeSent.amount;
        address addressTo = transactionToBeSent.toAddress;
        payable(addressTo).transfer(amountToSend);
        return true;
    }

    receive() external payable {}

}