pragma solidity ^0.4.0;

import 'LoCDB.sol';

contract LoCWorkflow is Enablers {
    address buyer;
    address seller;
    address buyerBank;
    address sellerBank;
    bytes purchaseRequest;
    bytes billOfLading;
    bytes invoice;
    uint amount;
    uint owed;

    bool _approvedPurchase;
    bool _creditGranted;
    bool _documentsAdded;
    bool _approvedDocuments;

    event PurchaseConfirmed(address _contractAddress, address _buyer, address _seller, bytes _purchaseRequest, address _buyerBank);
    event creditGranted(address _contractAddress, address _buyer, address _seller, bytes _purchaseRequest, uint _amount);
    event documentsAdded(address _contractAddress, address _buyer, address _seller, bytes _purchaseRequest, bytes _bol, bytes _invoice, address _sellerBank);
    event approvedDocuments(address _contractAddress, address _buyer, address _seller, bytes _purchaseRequest, bytes _bol, bytes _invoice, address _buyerBank);

    function LoCWorkflow(address _buyer, address _seller, uint _amount, bytes _purchaseRequest) isManagerEnabled {
        address _LoCDB = ContractProvider(DOUG).contracts("LoCDB");
        buyer = _buyer;
        seller = _seller;
        buyerBank = LoCDB(_LoCDB).getBank(_buyer);
        sellerBank = LoCDB(_LoCDB).getBank(_seller);
        purchaseRequest = _purchaseRequest;
        amount = _amount;

    }

    function approvePurchase(address sender) isDougEnabled("LoC") {
        if (sender != seller) throw;
        _approvedPurchase = true;
        PurchaseConfirmed(address(this), buyer, seller, purchaseRequest, buyerBank);
    }

    function grantCredit(address sender) payable isDougEnabled("LoC") {
        if (sender != buyerBank) throw;
        if (!_approvedPurchase) throw;
        if (msg.value != amount) throw;
        _creditGranted = true;
        creditGranted(address(this), buyer, seller, purchaseRequest, amount);
    }

    function addDocuments(address sender, bytes _bol, bytes _invoice) isDougEnabled("LoC") {
        if (sender != seller) throw;
        if (!_creditGranted) throw;
        billOfLading = _bol;
        invoice = _invoice;
        _documentsAdded = true;
        documentsAdded(address(this), buyer, seller, purchaseRequest, billOfLading, invoice, sellerBank);
    }

    function approveDocuments(address sender) isDougEnabled("LoC") {
        if (sender != buyerBank) throw;
        if (!_documentsAdded) throw;
        _approvedDocuments = true;
        approvedDocuments(address(this), buyer, seller, purchaseRequest, billOfLading, invoice, buyerBank);
    }

    function approveAndPay(address sender) payable isDougEnabled("LoC") {
        if (sender != buyerBank) throw;
        if(!_approvedDocuments) throw;
        owed = msg.value;
        if (!seller.send(msg.value)) throw;
    }

    function payDebts(address sender) payable isDougEnabled("LoC") {
      if (sender != buyer) throw;
      if (!_approvedDocuments && owed == 0) throw;
      owed += msg.value;
      if(!buyerBank.send(msg.value)) throw;
    }

    function() {
        throw;
    }

    function kill(address sender) isDougEnabled("LoC") {
        if (sender != buyerBank) throw;
        if (owed != 0) throw;
        selfdestruct(buyerBank);
    }
}
