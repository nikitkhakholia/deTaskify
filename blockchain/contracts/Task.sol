// SPDX-License-Identifier: MIT
pragma solidity ^0.8.6;

import "./User.sol";

/// @title A contract for creating Task
/// @author Nikit Khakholia 😎
/// @notice This contract has a Task data structure which is kept in a mapping and a taskCount variable to store the no tasks present in the mapping.
contract TaskContract is UserContract {
    struct SubTask {
        bool completed;
        string name;
        string description;
        uint256 assignedTo;
    }
    struct Task {
        uint256 id;
        address createdBy;
        address assignedTo;
        uint8 priority;
        bool completed;
        bool pinned;
        string name;
        string description;
        SubTask[] subTasks;
        string[] labels;
        uint256 dueOn;
        uint256 remindOn;
    }
    uint256 taskCount = 0;
    mapping(uint256 => Task) tasks;

    /// @notice Checks if Task is created by the sender
    /// @param _taskId Id of Task to be checked
    /// @dev Checks msg.sender to the task's createdBy
    modifier isCreator(uint256 _taskId) {
        require(
            msg.sender == tasks[_taskId].createdBy,
            "Failed! Task not created by you."
        );
        _;
    }

    /// @notice Updates name of an existing Task
    /// @param _name New name to be updated
    /// @param _taskId Id of Task to be updated
    /// @dev Updates task's name with given _name
    function setName(string calldata _name, uint256 _taskId)
        public
        isCreator(_taskId)
    {
        tasks[_taskId].name = _name;
    }

    /// @notice Updates description of an existing Task
    /// @param _description New description to be updated
    /// @param _taskId Id of Task to be updated
    /// @dev Updates task's description with given _description
    function setDescription(string calldata _description, uint256 _taskId)
        public
        isCreator(_taskId)
    {
        tasks[_taskId].description = _description;
    }

    /// @notice Updates labels of an existing Task
    /// @param _labels Array of labels to be updated
    /// @param _taskId Id of Task to be updated
    /// @dev Updates task's labels with given _labels
    function setLabels(string[] calldata _labels, uint256 _taskId)
        public
        userExist
    {
        tasks[_taskId].labels = _labels;
    }

    /// @notice Creates a task
    /// @param _createdBy Creator of task
    /// @param _assignedTo Assignee of Task
    /// @param _priority Priority of Task
    /// @param _completed Completion Status of Task
    /// @param _pinned Pinned Status of Task
    /// @param _name Name of Task
    /// @param _description Description of Task
    /// @param _labels Labels of Task
    /// @param _dueOn Due Time of Task
    /// @param _remindOn Reminder Time of Task
    /// @dev Creates a new task with a id generated internally
    function _createTask(
        address _createdBy,
        address _assignedTo,
        uint8 _priority,
        bool _completed,
        bool _pinned,
        uint256 _dueOn,
        uint256 _remindOn,
        string[] calldata _labels,
        string memory _name,
        string memory _description
    ) internal userExist returns (uint256 _taskId) {
        taskCount++;
        tasks[taskCount] = Task(
            taskCount,
            _createdBy,
            _assignedTo,
            _priority,
            _completed,
            _pinned,
            _name,
            _description,
            new SubTask[](0),
            _labels,
            _dueOn,
            _remindOn
        );
        _taskId = taskCount;
    }
 
    /// @notice Creates a task    
    /// @param _name Name of Task
    /// @param _description Description of Task
    /// @param _dueOn Due Time of Task
    /// @param _remindOn Reminder Time of Task
    /// @param _priority Priority of Task
    /// @param _labels Labels of Task
    /// @dev Creates a new task with msg.sender as the creator and assignee, completed and pinned as false and 0 sub tasks where id is generated internally
    function createTask(
        string memory _name,
        string memory _description,
        uint256 _dueOn,
        uint256 _remindOn,
        uint8 _priority,
        string[] calldata _labels
    ) public userExist returns (uint256 _taskId) {
        require(
            _dueOn > block.timestamp || _dueOn == 0,
            "Failed! Please select a future due date."
        );
        require(
            _remindOn > block.timestamp || _remindOn == 0,
            "Failed! Please select a future remind date."
        );

        _taskId = _createTask(
            msg.sender,
            msg.sender,
            _priority,
            false,
            false,
            _dueOn,
            _remindOn,
            _labels,
            _name,
            _description            
        );
    }

    function getTasksByCreator()public view returns(Task[] memory){
        uint createdCount=0;
        for(uint i=0; i<taskCount; i++){
            if(tasks[i].createdBy==msg.sender){
                createdCount++;
            }
        }
        Task[] memory _tasks = new Task[](createdCount);
        uint count=0;
        for(uint i=0; i<taskCount; i++){
            if(tasks[i].createdBy==msg.sender){
                _tasks[count]=tasks[i];
                count++;
            }
        }
        return _tasks;

    }
}
