import alarmIcon from '../assets/alarm.svg'

import labelIcon from '../assets/label.svg'

import priorityIcon from '../assets/priority.svg'

import calendarIcon from '../assets/calendar.svg'
import { useContext } from 'react'
import AccountContext from '../Contexts/AccountContext'

const Task = ({ task }) => {

  const {Chain} = useContext(AccountContext);


  return (
    <div
      className="
        bg-neutral-900 rounded-md p-4
        "
    >
      <h3 className="font-bold">{task.name}</h3>
      <p>{task.description}</p>
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
export default Task
