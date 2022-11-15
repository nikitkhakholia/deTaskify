// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "./Task.sol";

contract BoardContract is TaskContract{
    uint id;
    uint name;
    string icon;
    int[] threads;
    int[] collaborators;

    
}