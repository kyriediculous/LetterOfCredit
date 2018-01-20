pragma solidity ^0.4.0;

contract DougEnabled {
    address DOUG;

    function setDougAddress(address _dougAddress) returns (bool success) {
        if(DOUG!= 0x0 && msg.sender != DOUG) return false;
        DOUG = _dougAddress;
        return true;
    }

    function kill() {
        if(msg.sender != DOUG) throw;
        selfdestruct(DOUG);
    }
}
