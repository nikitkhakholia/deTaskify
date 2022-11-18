// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "./User.sol";

/// @title A contract for creating Task
/// @author Nikit Khakholia 😎
/// @notice This contract has a Task data structure which is kept in a mapping and a taskCount variable to store the no tasks present in the mapping.
contract TaskContract is UserContract {
    struct Label{
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

    /// @notice Updates name of an existing Task
    /// @param _priority New label by the user to be updated
    /// @param _taskId Id of Task to be updated
    /// @dev Updates task's name with given _name
    function updatePriority(uint8 _priority, uint256 _taskId)
        public
        isAssignee(_taskId)
    {
           
    }
    /// @notice Updates name of an existing Task
    /// @param _name name of sub task
    /// @param _description description of subtask
    /// @param _assignedTo task assigned to
    /// @param _taskId Id of Task to be updated
    /// @dev Updates task's name with given _name
    function addSubtask(
        string calldata _name,
        string calldata _description,
        address _assignedTo,
        uint256 _taskId
    ) public isAssignee(_taskId) {
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

    /// @notice Updates name of an existing Task
    /// @param _name name of sub task
    /// @param _description description of subtask
    /// @param _assignedTo task assigned to
    /// @param _taskId Id of Task to be updated
    /// @dev Updates task's name with given _name
    function updateSubtask(
        uint8 _subTaskId,
        bool _completed,
        string calldata _name,
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
                tasks[_taskId].subTasks[x].name = _name;
                tasks[_taskId].subTasks[x].description = _description;
                tasks[_taskId].subTasks[x].assignedTo = _assignedTo;
                tasks[_taskId].subTasks[x].completed = _completed;
            }
        }
    }

    /// @notice Updates name of an existing Task
    /// @param _name New label by the user to be updated
    /// @param _taskId Id of Task to be updated
    /// @dev Updates task's name with given _name
    function addLabels(string calldata _name, uint256 _taskId)
        public
        isAssignee(_taskId)
    {
        tasks[_taskId].labels.push(Label(msg.sender, _name));
    }
    /*
    /// @notice Updates name of an existing Task
    /// @param _index index of label to be removed
    /// @param _taskId Id of Task to be updated
    /// @dev Updates task's name with given _name
    function removeLabels(uint _index, uint256 _taskId)
        public
        isAssignee(_taskId)
    {
        Label[] storage labels = new Label[](10);
        for(uint x = 0; x<tasks[_taskId].labels.length; x++){
            if(tasks[_taskId].labels[x].userAddress==msg.sender && x!= _index){
                labels.push(tasks[_taskId].labels[x]);
            }

        }
    }
    */
    /// @notice Updates name of an existing Task
    /// @param _dueOn New due time to be updated
    /// @param _taskId Id of Task to be updated
    /// @dev Updates task's name with given _name
    function updateDueOn(uint256 _dueOn, uint256 _taskId)
        public
        isAssignee(_taskId)
    {
        tasks[_taskId].dueOn = _dueOn;
    }

    /// @notice Updates name of an existing Task
    /// @param _remindOn New remiander time to be updated
    /// @param _taskId Id of Task to be updated
    /// @dev Updates task's name with given _name
    function updateRemindOn(uint256 _remindOn, uint256 _taskId)
        public
        isAssignee(_taskId)
    {
        tasks[_taskId].remindOn = _remindOn;
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

    /*
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
    ) public userExist returns (uint256 _taskId) {
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
abi.decode(data, (string, string))
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
*/

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
}
