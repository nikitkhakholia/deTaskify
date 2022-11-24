import MetaMaskSDK from '@metamask/sdk'
import React, { useEffect, useRef, useState } from 'react'
import { abi, contract } from '../utils/utils'
const Web3 = require('web3')

const AccountContext = React.createContext()

export function AccountProvider({ children }) {
  const web3 = new Web3('ws://localhost:8545')
  const [account, setAccount] = useState({ address: '', name: '', sync: false })

  var TaskContract = new web3.eth.Contract(abi, contract)

  useEffect(() => {
    console.log('Requesting account...')
    if (typeof web3 !== 'undefined') {
      console.log('Found')
      const MMSDK = new MetaMaskSDK({
        dappMetadata: { name: 'deTaskify', url: 'http://localhost:3000' },
        checkInstallationImmediately: true,
      })
      const ethereum = MMSDK.getProvider() // You can also access via window.ethereum
      ethereum
        .request({ method: 'eth_requestAccounts', params: [] })
        .then((x) => {
          setAccount({ ...account, address: x[0] })
        })
    } else {
      console.log('No web3 provider found..')
    }
  }, [])

  return (
    <AccountContext.Provider value={{ account, Chain: TaskContract.methods }}>
      {
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
            {account.sync && <div>{account.name[0]}</div>}
          </div>
          {!account.sync ? (
            <div
              className="
        absolute inset-0 bg-black bg-opacity-50
        flex justify-center items-center
        "
            >
              <div className="">
                <div className="max-w-xs text-center">
                  <h1 className="text-3xl ">Welcome</h1>
                  <p className="mt-2">
                    We will store your name against your public address in our
                    smart contracts.
                  </p>
                  <input
                    placeholder="Enter your name"
                    onChange={(e) => {
                      setAccount({ ...account, name: e.target.value })
                    }}
                    type="text"
                    className="
              p-2 mt-2 text-lg italic bg-black border-b-2
              focus:outline-none focus:border-white
              "
                  />
                  <div
                    className="
              p-2 mt-4 text-center bg-neutral-900 rounded-md cursor-pointer
              "
                    onClick={(e) => {
                      TaskContract.methods
                        .newUser(account.name)
                        .send({ from: account.address }, (err, hash) => {
                          if (hash) {
                            setAccount({ ...account, sync: true })
                          }
                        })
                    }}
                  >
                    Confirm
                  </div>
                </div>
              </div>
            </div>
          ) : (
            <div>{children}</div>
          )}
        </div>
      }
    </AccountContext.Provider>
  )
}

export default AccountContext
