//Contract-Managing-Contract Entry Point

pragma solidity ^0.4.0;

import 'Ownable.sol';
import 'DougEnabled.sol';

contract Doug is Ownable {
     mapping (bytes32 => address) contracts;

     function addContract(bytes32 _name, address _address) onlyOwner {
         //If this contract isn't the set Doug this will throw
         DougEnabled _DougEnabled = DougEnabled(_address);
         if (!_DougEnabled.setDougAddress(address(this))) throw;
         contracts[_name] = _address;
     }

     function removeContract(bytes32 _name) onlyOwner returns (bool success) {
         if (contracts[_name] == 0x0) return false;
         contracts[_name] = 0x0;
         return true;
     }

     function getContract(bytes32 _name) constant returns (address) {
         return contracts[_name];
     }

     function kill() onlyOwner {
       DougEnabled(contracts["manager"]).kill();
       DougEnabled(contracts["LoC"]).kill();
       DougEnabled(contracts["LoCDB"]).kill();
       selfdestruct(owner);
     }
}
