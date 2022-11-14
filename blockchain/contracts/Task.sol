// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract Task {
    uint256 id;
    uint256 createdBy;
    uint256 assignedTo;
    uint8 priority;
    bool completed;
    bool pinned;
    string name;
    string description;
    Task[] subTask;
    string[] labels;
    uint256 dueOn;
    uint256 remindOn;

    function setName(string calldata _name) public {
        name = _name;
    }

    function setDescription(string calldata _description) public {
        description = _description;
    }

    function setLabels(string[] calldata _labels)public{
        labels=_labels;
    }
}
