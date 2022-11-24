import alarmIcon from '../assets/alarm.svg'

import labelIcon from '../assets/label.svg'

import priorityIcon from '../assets/priority.svg'

import calendarIcon from '../assets/calendar.svg'
import { useContext } from 'react'
import AccountContext from '../Contexts/AccountContext'
const AddTask = () => {

  const {Chain} = useContext(AccountContext);

  return (
    <div
      className="
      bg-black rounded-md p-4 m-1
      shadow-white drop-shadow         
      border-2 border-neutral-900

      "
    >
      <div>
        <input
          className="
        bg-black border-b-2 border-neutral-900 
        focus:border-white focus:outline-none
        placeholder-white p-2
        "
          placeholder="Name"
        />
      </div>
      <div>
        <input
          className="
        bg-black border-b-2 border-neutral-900 
        focus:border-white focus:outline-none
        placeholder-white p-2 mt-2
        "
          placeholder="Description"
          onBlur={e=>{
            Chain.getTasksByCreator().call((e, d)=>{
              console.log(d);
            })
          }}
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
      <div className='
      p-2 w-100 mt-4 rounded text-center
      bg-black
      border-2 border-neutral-900

      '
      onClick={e=>{
        Chain.getTasksByCreator().call((e, d)=>{
          console.log(d);
      })}}>Save</div>
    </div>
  )
}

export default AddTask
