import { useEffect } from 'react'
import { contract, abi } from '../utils/utils'

const Web3 = require('web3')

const TaskManager = ()=>{
    var web3 = new Web3(
        new Web3.providers.WebsocketProvider('ws://127.0.0.1:8545/'),
      )
    var TaskContract = new web3.eth.Contract(abi, contract)
    useEffect(() => {
        console.log('Requesting account...')
        if (typeof web3 !== 'undefined') {
          console.log('Found')
        } else {
          console.log('No web3 provider found..')
        }
      }, [])

}

export default TaskManager