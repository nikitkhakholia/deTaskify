// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "./User.sol";
import "./Board.sol";


contract TaskManager{
    mapping(uint => User) users;
    Board[] boards;
}