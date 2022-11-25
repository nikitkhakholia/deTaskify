// SPDX-License-Identifier: MIT
pragma solidity ^0.8.6;

import "./User.sol";

/// @title A contract for creating Task
/// @author Nikit Khakholia 😎
/// @notice This contract has a Task data structure which is kept in a mapping and a taskCount variable to store the no tasks present in the mapping.
contract TaskContract is UserContract {
    struct Label {
        address userAddress;
        string name;
    }
    struct SubTask {
        uint id;
        bool completed;
        string name;
        string description;
        address assignedTo;
    }
    struct Task {
        uint256 id;
        address createdBy;
        address assignedTo;
        bool completed;
        bool pinned;
        string name;
        string description;
        uint8 priority;
        uint8 subTasksCount;
        SubTask[] subTasks;
        Label[] labels;
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

    /// @notice Checks if Task is created by the sender
    /// @param _taskId Id of Task to be checked
    /// @dev Checks msg.sender to the task's createdBy
    modifier isAssignee(uint256 _taskId) {
        require(
            msg.sender == tasks[_taskId].assignedTo ||
                msg.sender == tasks[_taskId].createdBy,
            "Failed! Task not assigned to you."
        );
        _;
    }

    /// @notice Updates assignedTo of an existing Task
    /// @param _assignee New assignee of the task
    /// @param _taskId Id of Task to be updated
    /// @dev Updates task's assignee with given address
    function updateAssignee(address _assignee, uint256 _taskId)
        public
        isAssignee(_taskId)
    {
        tasks[_taskId].assignedTo = _assignee;
    }

    /// @notice Updates completion status of an existing Task
    /// @param _completed Completion status of the task
    /// @param _taskId Id of Task to be updated
    /// @dev Updates task's completion with given value
    function updateCompleted(bool _completed, uint256 _taskId)
        public
        isAssignee(_taskId)
    {
        tasks[_taskId].completed = _completed;
    }

    /// @notice Updates pinned status of an existing Task
    /// @param _pinned New label by the user to be updated
    /// @param _taskId Id of Task to be updated
    /// @dev Updates task's pinned with given value
    function updatePinned(bool _pinned, uint256 _taskId)
        public
        isAssignee(_taskId)
    {
        tasks[_taskId].pinned = _pinned;
    }

    /// @notice Updates name of an existing Task
    /// @param _name New name to be updated
    /// @param _taskId Id of Task to be updated
    /// @dev Updates task's name with given _name
    function updateName(string calldata _name, uint256 _taskId)
        public
        isCreator(_taskId)
    {
        tasks[_taskId].name = _name;
    }

    /// @notice Updates description of an existing Task
    /// @param _description New description to be updated
    /// @param _taskId Id of Task to be updated
    /// @dev Updates task's description with given _description
    function updateDescription(string calldata _description, uint256 _taskId)
        public
        isCreator(_taskId)
    {
        tasks[_taskId].description = _description;
    }

    /// @notice Updates priority of an existing Task
    /// @param _priority New priority level to be updated
    /// @param _taskId Id of Task to be updated
    /// @dev Updates task's priority with given value
    function updatePriority(uint8 _priority, uint256 _taskId)
        public
        isAssignee(_taskId)
    {
        tasks[_taskId].priority = _priority;
    }

    /// @notice Adds sub task to an existing task
    /// @param _name name of sub task
    /// @param _description description of sub task
    /// @param _assignedTo sub task task assigned to
    /// @param _taskId Id of Task to be updated
    /// @dev Updates task's name with given _name
    function addSubtask(
        string calldata _name,
        string calldata _description,
        address _assignedTo,
        uint256 _taskId
    ) public isCreator(_taskId) {
        require(
            chekUserExist(_assignedTo),
            "Please ask the user to register first."
        );
        tasks[_taskId].subTasksCount++;
        tasks[_taskId].subTasks.push(
            SubTask({
                id: tasks[_taskId].subTasksCount,
                completed: false,
                name: _name,
                description: _description,
                assignedTo: _assignedTo
            })
        );
    }

    /// @notice Updates sub task of an existing Task
    /// @param _description description of sub task
    /// @param _assignedTo sub task assigned to
    /// @param _taskId Id of Task to be updated
    /// @dev Updates existing subtask with the given values
    function updateSubTask(
        uint8 _subTaskId,
        bool _completed,
        string calldata _description,
        address _assignedTo,
        uint256 _taskId
    ) public isAssignee(_taskId) {
        require(
            chekUserExist(_assignedTo),
            "Please ask the user to register first."
        );
        for (uint x = 0; x < tasks[_taskId].subTasksCount; x++) {
            if (tasks[_taskId].subTasks[x].id == _subTaskId) {
                tasks[_taskId].subTasks[x].description = _description;
                tasks[_taskId].subTasks[x].assignedTo = _assignedTo;
                tasks[_taskId].subTasks[x].completed = _completed;
            }
        }
    }

    /// @notice Adds labels of an existing Task
    /// @param _name New label by the user to be updated
    /// @param _taskId Id of Task to be updated
    /// @dev Adds labels to existing task
    function addLabels(string calldata _name, uint256 _taskId)
        public
        isAssignee(_taskId)
    {
        tasks[_taskId].labels.push(Label(msg.sender, _name));
    }

    /// @notice Updates name of an existing Task
    /// @param _index index of label to be removed
    /// @param _taskId Id of Task to be updated
    /// @dev Updates task's name with given _name
    function removeLabels(uint _index, uint256 _taskId)
        public
        isAssignee(_taskId)
    {
        Label[] memory _labels = tasks[_taskId].labels;
        tasks[_taskId].labels=new Label[](0);
        for(uint x = 0; x<10; x++){
            if(x!=_index){
                tasks[_taskId].labels.push(_labels[x]);
            }
        }

    }
    

    /// @notice Updates due time of an existing Task
    /// @param _dueOn New due time to be updated
    /// @param _taskId Id of Task to be updated
    /// @dev Updates task's due time with given value
    function updateDueOn(uint256 _dueOn, uint256 _taskId)
        public
        isCreator(_taskId)
    {
        tasks[_taskId].dueOn = _dueOn;
    }

    /// @notice Updates remind time of an existing Task
    /// @param _remindOn New remiander time to be updated
    /// @param _taskId Id of Task to be updated
    /// @dev Updates task's remind time with given value
    function updateRemindOn(uint256 _remindOn, uint256 _taskId)
        public
        isAssignee(_taskId)
    {
        tasks[_taskId].remindOn = _remindOn;
    }

    /// @notice Returns all the tasks created by msg.sender
    function getTasksByCreator() public view returns (Task[] memory) {
        uint createdCount = 0;
        for (uint i = 0; i < taskCount; i++) {
            if (tasks[i].createdBy == msg.sender) {
                createdCount++;
            }
        }
        Task[] memory _tasks = new Task[](createdCount);
        uint count = 0;
        for (uint i = 0; i < taskCount; i++) {
            if (tasks[i].createdBy == msg.sender) {
                _tasks[count] = tasks[i];
                count++;
            }
        }
        return _tasks;
    }

    /// @notice Returns all the tasks assigned to msg.sender
    function getTasksByAssignee() public view returns (Task[] memory) {
        uint assignedCount = 0;
        for (uint i = 0; i < taskCount; i++) {
            if (tasks[i].assignedTo == msg.sender) {
                assignedCount++;
            }
        }
        Task[] memory _tasks = new Task[](assignedCount);
        uint count = 0;
        for (uint i = 0; i < taskCount; i++) {
            if (tasks[i].assignedTo == msg.sender) {
                _tasks[count] = tasks[i];
                count++;
            }
        }
        return _tasks;
    }
}
