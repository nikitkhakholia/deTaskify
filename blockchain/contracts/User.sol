// SPDX-License-Identifier: MIT
pragma solidity ^0.8.6;

contract UserContract{

    uint userCount=0;

    struct User {
        address userAddress;
        string name;
        uint id;
    }
    mapping(uint=> User) users;

    modifier userExist{
        for(uint i = 1; i<=userCount; i++)
        {
            if(users[i].userAddress==msg.sender){
                _;
            }
        }
    }

    function newUser(string calldata _name) public returns (uint){
        userCount++;
        users[userCount]=User(msg.sender, _name, userCount);
        return userCount;
    }

    function getUserAddress(uint _userId) internal view returns (address){
        return users[_userId].userAddress;
    }
    
}