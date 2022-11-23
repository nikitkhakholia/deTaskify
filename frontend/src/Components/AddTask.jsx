import alarmIcon from '../assets/alarm.svg'

import labelIcon from '../assets/label.svg'

import priorityIcon from '../assets/priority.svg'

import calendarIcon from '../assets/calendar.svg'
const AddTask = () => {
  
  return (
    <div
      className="
      bg-neutral-900 rounded-md p-4 m-1
      shadow-white drop-shadow
      "
    >
      <div>
        <input
          className="
        bg-neutral-900 border-b-2 border-neutral-900 
        focus:border-white focus:outline-none
        placeholder-white
        "
          placeholder="Name"
        />
      </div>
      <div>
        <input
          className="
        bg-neutral-900 border-b-2 border-neutral-900 
        focus:border-white focus:outline-none
        placeholder-white
        "
          placeholder="Description"
        />
      </div>
      <div className="flex justify-center items-center pt-4">
        <div className="">
          <img
            className="ml-3 transition-all cursor-pointer"
            src={calendarIcon}
            alt="calendar"
            onClick={(e) => {}}
          />
        </div>
        <div className="">
          <img
            className="ml-3 transition-all cursor-pointer"
            src={alarmIcon}
            alt="alarm"
            onClick={(e) => {}}
          />
        </div>
        <div className="">
          <img
            className="ml-3 transition-all cursor-pointer"
            src={priorityIcon}
            alt="priority"
            onClick={(e) => {}}
          />
        </div>
        <div className="">
          <img
            className="ml-3 transition-all cursor-pointer"
            src={labelIcon}
            alt="label"
            onClick={(e) => {}}
          />
        </div>
      </div>
    </div>
  )
}

export default AddTask
