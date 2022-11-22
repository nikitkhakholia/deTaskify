import { useEffect } from 'react'
import { contract, abi } from '../utils/utils'
import './TaskManager.css'
import addIcon from '../assets/add.svg'
import { useState } from 'react'
import Task from './Task'
import AddTask from './AddTask'
const Web3 = require('web3')
const web3 = new Web3('ws://localhost:8545')

const TaskManager = () => {
  var TaskContract = new web3.eth.Contract(abi, contract)
  const [tasks, setTasks] = useState([])
  useEffect(() => {
    console.log('Requesting account...')
    if (typeof web3 !== 'undefined') {
      console.log('Found')
      TaskContract.methods.getTasksByAssignee().call((err, result) => {
        if (!err) {
          setTasks(result)
        } else {
          console.log(err)
        }
      })
    } else {
      console.log('No web3 provider found..')
    }
  }, [])

  return (
    <div
      className="
      min-h-screen
      bg-black text-white
      "
    >
      <div
        className="
        p-2 px-4
        font-bold text-3xl text-center
        border-b-2 border-neutral-900
        flex justify-between items-center
        "
      >
        <div className="tw-mx-4 tw-my-3">
          <div
            className="hamburger"
            id="hamburger-1"
            onClick={(e) => {
              document
                .getElementById('hamburger-1')
                .classList.toggle('is-active')
            }}
          >
            <span className="line"></span>
            <span className="line"></span>
            <span className="line"></span>
          </div>
        </div>
        <h1>
          <span className="italic">de</span>Taskify
        </h1>
        <div>B</div>
      </div>
      <div
        className="
      flex h-screen
      "
      >
        <div className="basis-1/6 p-2 px-4 border-neutral-900 border-r-2">
          1
        </div>
        <div className="basis-4/6 p-2 px-4 flex flex-col">
          <div className="basis-10/12 flex flex-col">
            <div className="flex justify-between items-center">
              <h2 className="text-xl font-bold">Today</h2>
              <div className="">
                <img
                  className="ml-3 transition-all cursor-pointer"
                  src={addIcon}
                  alt="add"
                  onClick={(e) => {
                    e.target.classList.toggle('rotate-45')
                    document
                      .getElementById('addTask')
                      .classList.toggle('hidden')
                  }}
                />
              </div>
            </div>
            <div id="addTask" className="self-end absolute mt-6 hidden">
              <AddTask />
            </div>

            <div className="grow overscroll-auto">
              {!tasks ? (
                <p className="italic">No tasks scheduled for today.</p>
              ) : (
                <div
                  className="
                  p-2
                  grid grid-cols-3 gap-4
                "
                >
                  <Task
                    task={{ name: 'Mustard Oil', description: '200ml * 5' }}
                  />
                  <Task
                    task={{ name: 'Mustard Oil', description: '200ml * 5' }}
                  />
                  <Task
                    task={{ name: 'Mustard Oil', description: '200ml * 5' }}
                  />
                  <Task
                    task={{ name: 'Mustard Oil', description: '200ml * 5' }}
                  />
                  <Task
                    task={{ name: 'Mustard Oil', description: '200ml * 5' }}
                  />
                </div>
              )}
            </div>
          </div>

          <div className="basis-1/12">
            <div className="flex justify-between items-center">
              <h2 className="text-xl font-bold">Up Comming</h2>
            </div>
          </div>
          <div className="basis-1/12">
            <div className="flex justify-between items-center">
              <h2 className="text-xl font-bold">Past</h2>
            </div>
          </div>
        </div>
        <div className="basis-1/6 p-2 px-4 border-neutral-900 border-l-2">
          3
        </div>
      </div>
    </div>
  )
}

export default TaskManager
