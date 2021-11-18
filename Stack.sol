// SPDX-License-Identifier: GPL-3.0
pragma solidity  >=0.8.9;
contract Stack {
    bytes[] stack;

    function push(bytes memory data) public {
        stack.push(data);
    }

    function peek() public returns (bytes memory data) {
       return stack[0];
    }
}