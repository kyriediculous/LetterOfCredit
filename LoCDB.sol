pragma solidity ^0.4.0;

import 'Enablers.sol';

contract LoCDB is Enablers {

    event PurchaseCreated(address _buyer, address _seller, uint _amount, bytes _purchaseReqest, address contractAddress);

    struct company {
        string companyName;
        address userBank;
        address currentFlow;
    }

    mapping ( address => company) public Companies;

    function addCompany(address _companyAddress, string _companyName, address _userBank) isDougEnabled("LoC") {
        Companies[_companyAddress].companyName = _companyName;
        Companies[_companyAddress].userBank = _userBank;
        int balance = 0;
    }

    function createLoC(address _buyer, address _seller, uint _amount, bytes _purchaseRequest, address _currentContract) isDougEnabled("LoC") {
       Companies[_buyer].currentFlow = _currentContract;
       Companies[_seller].currentFlow = Companies[_buyer].currentFlow;
       PurchaseCreated(msg.sender, _seller, _amount, _purchaseRequest, Companies[_buyer].currentFlow);
    }

    function getBank(address _user) external returns (address bank) {
        if(msg.sender != Companies[_user].currentFlow) throw;
        return Companies[_user].userBank;
    }
}
