// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "./User.sol";
import "./Task.sol";

contract Thread{
    uint id;
    uint name;
    string icon;
    Task[] tasks;
    uint board;
    bool archived;
    bool deleted;

    
}