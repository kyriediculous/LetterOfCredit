pragma solidity ^0.4.0;

contract Ownable {
    address public owner;

    function Ownable() public {
        owner = msg.sender;
    }

    modifier onlyOwner {
        if(msg.sender != owner) throw;
        _;
    }
}
