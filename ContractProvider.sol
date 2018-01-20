pragma solidity ^0.4.0;

contract ContractProvider {
    function contracts(bytes32 _name) returns (address addr);
    //This will refer to the contracts mapping in Doug.sol since contracts is public
}
