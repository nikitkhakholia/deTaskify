// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "./Thread.sol";

contract Board{
    uint id;
    uint name;
    string icon;
    int[] threads;
    int[] collaborators;
}