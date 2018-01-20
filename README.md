# LetterOfCredit

By Nico Vergauwen

#Approach:

Implemented a CMC and bookkeeping system.

The CMC (Manager.sol) directs a controller LoC.sol 

The controller LoC.sol directs calls to
LoCDB.sol : Storage of user accounts
LoCWorkflow.sol : the workflow the initiator of the purchase can instantiate

LoCDB contains a mapping of the user addresses to a struct of the companyName and 20-byte address of the user’s bank. 

Once registered the user can create a new letter of credit given the seller is registered in the system.

Creating a letter of credit can be done as the importer, this will create an instance of LoCWorkflow.sol on it’s own address. This is also where the escrow will be stored (credit given by the bank).

** NOTE : Since happy flow was allowed I have not implemented a procedure for the bank to decline the documents provided by the exporter and thus return the credit back to the buyerBank.

Once the LoC is created the seller can approve the purchase

** NOTE : since happy flow was allowed I’ve not implemented the contract to selfdestruct on disapproval or allow modification to be sent back to importer etc. 

Once the LoC is approved there is a true purchase agreement, the importer bank will be notified to review the credit approval. 

** NOTE : happy flow … 

Once the credit has been granted the exporter has the ability to upload a bill of lading and invoice which can then be checked by the buyerBank

** NOTE : skipped review by sellerBank (happy flow)

When the documents are approved the escrow will be released upon which the contract will set an owed amount which the buyer has to pay in full

Once the buyer has payed his debts to his bank the buyerBank can end the contract. 

For the epm.yaml file I have ran into deadline problems due to the more complex structure of the contract. The current file will deploy the contracts, add them to the doug and execute the contract. No assertions are in place such as checking owed=0 at the end. 
