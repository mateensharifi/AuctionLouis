pragma solidity  >=0.8.9;

contract Acount {
    string private username;
    string private userID;
    address private creator;
    
    constructor () {
        creator = msg.sender;
    }
}