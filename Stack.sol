// SPDX-License-Identifier: GPL-3.0
pragma solidity  >=0.8.9;
contract Stack {
    bytes[] stack;

    function push(bytes data memory) public {
        stack.push(data);
    }

    function pop() public returns (bytes data memory) {
        data = stack[stack.length - 1];

        stack.length -= 1;
    }
}