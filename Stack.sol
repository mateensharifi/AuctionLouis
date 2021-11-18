// SPDX-License-Identifier: GPL-3.0
pragma solidity  >=0.8.9;
contract Stack {
    bytes[] stack;

    function push(uint256 data) public {
        stack.push(data);
    }

    function peek() public returns (uint256 data) {
       return stack[0];
    }
}