// SPDX-License-Identifier: MIT
pragma solidity ^0.8.6;

import "./User.sol";

contract TaskContract is UserContract {
    struct Task {
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
    }
    uint256 taskCount = 0;
    mapping(uint256 => Task) tasks;

    modifier isCreator(uint256 _taskId) {
        require(msg.sender == getUserAddress(tasks[_taskId].createdBy), "Failed! Task not created by you.");
        _;
    }

    function setName(string calldata _name, uint256 _taskId)
        public
        isCreator(_taskId)
    {
        tasks[_taskId].name = _name;
    }

    function setDescription(string calldata _description, uint256 _taskId)
        public
        isCreator(_taskId)
    {
        tasks[_taskId].description = _description;
    }

    function setLabels(string[] calldata _labels, uint256 _taskId) public {
        tasks[_taskId].labels = _labels;
    }
}
