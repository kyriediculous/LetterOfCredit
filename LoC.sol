pragma solidity ^0.4.0;

import 'LoCWorkflow.sol';

contract LoC is Enablers {
    function addCompany(address _companyAddress, string _companyName, address _userBank) isManagerEnabled {
        address _LoCDB = ContractProvider(DOUG).contracts("LoCDB");
        LoCDB(_LoCDB).addCompany(_companyAddress, _companyName, _userBank);
    }

    function createLoC(address _buyer, address _seller, uint _amount, bytes _purchaseRequest) isManagerEnabled returns (address) {
        address _LoCDB = ContractProvider(DOUG).contracts("LoCDB");
        LoCWorkflow _currentContract = new LoCWorkflow(_buyer, _seller, _amount, _purchaseRequest);
        LoCDB(_LoCDB).createLoC(_buyer, _seller, _amount, _purchaseRequest, _currentContract);
        return _currentContract;
    }

    function approvePurchase(address _contractAddress, address _sender) isManagerEnabled {
        LoCWorkflow(_contractAddress).approvePurchase(_sender);
    }

    function grantCredit(address _contractAddress, address _sender) payable isManagerEnabled {
        LoCWorkflow(_contractAddress).grantCredit.value(msg.value)(_sender);
    }

    function addDocuments(address _contractAddress, address _sender, bytes _bol, bytes _invoice) isManagerEnabled {
        LoCWorkflow(_contractAddress).addDocuments(_sender, _bol, _invoice);
    }

    function approveDocuments(address _contractAddress, address _sender) isManagerEnabled {
        LoCWorkflow(_contractAddress).approveDocuments(_sender);
    }

    function approveAndPay(address _contractAddress, address _sender) payable isManagerEnabled {
        LoCWorkflow(_contractAddress).approveAndPay.value(msg.value)(_sender);
    }

    function payDebts(address _contractAddress, address _sender) payable isManagerEnabled {
      LoCWorkflow(_contractAddress).payDebts.value(msg.value)(_sender);
    }

    function endContractWhenFinished(address _contractAddress, address _sender) isManagerEnabled {
        LoCWorkflow(_contractAddress).kill(_sender);
    }
}
