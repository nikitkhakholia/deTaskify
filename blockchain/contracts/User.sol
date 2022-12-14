// SPDX-License-Identifier: MIT
pragma solidity ^0.8.6;

contract UserContract {
    uint public userCount = 0;

    struct User {
        address userAddress;
        string name;
        uint id;
    }
    mapping(uint => User) users;

    modifier userExist() {
        for (uint i = 1; i <= userCount; i++) {
            if (users[i].userAddress == msg.sender) {
                _;
            }
        }
    }

    function newUser(string calldata _name) public returns (uint _userId) {
        bool _exist = false;
        for (uint i = 1; i <= userCount; i++) {
            if (users[i].userAddress == msg.sender) {
                _exist = true;
                _userId = i;
                break;
            }
        }

        if (!_exist) {
            userCount++;
            users[userCount] = User(msg.sender, _name, userCount);
            _userId = userCount;
        }
    }

    // function getUserAddress(uint _userId) internal view returns (address) {
    //     return users[_userId].userAddress;
    // }

    function chekUserExist(address _userAddress)
        internal
        view
        returns (bool _exist)
    {
        _exist = false;
        for (uint i = 1; i <= userCount; i++) {
            if (users[i].userAddress == _userAddress) {
                _exist = true;
                break;
            }
        }
    }
}
