import MetaMaskSDK from '@metamask/sdk'
import React, { useEffect, useState } from 'react'
import { abi, contract } from '../utils/utils'

const AccountContext = React.createContext()
const Web3 = require('web3')
const web3 = new Web3('ws://localhost:8545')
export function AccountProvider({ children }) {
  
  var TaskContract = new web3.eth.Contract(abi, contract)

  const [account, setAccount] = useState('')

  const MMSDK = new MetaMaskSDK({
    dappMetadata: { name: 'deTaskify', url: 'http://localhost:3000' },
    checkInstallationImmediately: true,
  })
  const ethereum = MMSDK.getProvider() // You can also access via window.ethereum
  ethereum.request({ method: 'eth_requestAccounts', params: [] }).then((x) => {
    setAccount(x)
  })
  useEffect(() => {
    console.log('Requesting account...')
    if (typeof web3 !== 'undefined') {
      console.log('Found')
      TaskContract.methods.getTasksByCreator().call((e, d)=>{
        console.log("xx");
        console.log(e);
        console.log(d);
      })
      
    } else {
      console.log('No web3 provider found..')
    }
  }, [])

  return (
    <AccountContext.Provider value={{ account, Chain:TaskContract.methods }}>
      {
        <div>
          <div>{children}</div>
        </div>
      }
    </AccountContext.Provider>
  )
}

export default AccountContext
