pragma solidity ^0.4.0;

import 'Ownable.sol';
import 'LoC.sol';

contract Manager is Ownable, Enablers {

    function() public {
        throw;
    }

    function addCompany(string _companyName, address _userBank) {
        if (msg.value > 0) throw; //Don't want Ether, only registration.
        address _LoC = ContractProvider(DOUG).contracts("LoC");
        LoC(_LoC).addCompany(msg.sender, _companyName, _userBank);
    }

    function createLoC(address _seller, uint _amount, bytes _purchaseRequest) {
         if (msg.value > 0) throw; //Don't want Ether, only registration of contract
         address _LoC = ContractProvider(DOUG).contracts("LoC");
         LoC(_LoC).createLoC(msg.sender, _seller, _amount, _purchaseRequest);
    }

    function approvePurchase(address _contractAddress) {
        address _LoC = ContractProvider(DOUG).contracts("LoC");
        LoC(_LoC).approvePurchase(_contractAddress, msg.sender);
    }

    function grantCredit(address _contractAddress) payable {
        address _LoC = ContractProvider(DOUG).contracts("LoC");
        LoC(_LoC).grantCredit.value(msg.value)(_contractAddress, msg.sender);
    }

    function addDocuments(address _contractAddress, bytes _bol, bytes _invoice) {
        address _LoC = ContractProvider(DOUG).contracts("LoC");
        LoC(_LoC).addDocuments(_contractAddress, msg.sender, _bol, _invoice);
    }

    function approveDocuments(address _contractAddress) {
        address _LoC = ContractProvider(DOUG).contracts("LoC");
        LoC(_LoC).approveDocuments(_contractAddress, msg.sender);
    }

    function approveAndPay(address _contractAddress) payable {
        address _LoC = ContractProvider(DOUG).contracts("LoC");
        LoC(_LoC).approveAndPay.value(msg.value)(_contractAddress, msg.sender);
    }

    function payDebts(address _contractAddress) payable {
      address _LoC = ContractProvider(DOUG).contracts("LoC");
      LoC(_LoC).payDebts.value(msg.value)(_contractAddress, msg.sender);
    }

    function endContractWhenFinished(address _contractAddress) {
        address _LoC = ContractProvider(DOUG).contracts("LoC");
        LoC(_LoC).endContractWhenFinished(_contractAddress, msg.sender);
    }

    function kill() onlyOwner {
        selfdestruct(owner);
    }
}
