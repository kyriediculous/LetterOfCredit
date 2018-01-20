pragma solidity ^0.4.0;

import 'DougEnabled.sol';
import 'ContractProvider.sol';

contract Enablers is DougEnabled {
    modifier isManagerEnabled {
        if (DOUG != 0x0 && msg.sender != ContractProvider(DOUG).contracts("manager")) throw;
        _;
    }

    modifier isDougEnabled(bytes32 _name) {
        if(DOUG != 0x0 && msg.sender != ContractProvider(DOUG).contracts(_name)) throw;
        _;
    }
}

//Using throw to consume gas to penalize potential malicious function calls that try to abuse permissions.
