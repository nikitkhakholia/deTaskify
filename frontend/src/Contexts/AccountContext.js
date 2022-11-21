import MetaMaskSDK from '@metamask/sdk'
import React, { useState } from 'react'

const AccountContext = React.createContext()

export function AccountProvider({ children }) {
  
  const [account, setAccount] = useState('')

  const MMSDK = new MetaMaskSDK({
    dappMetadata: { name: 'deTaskify', url: 'http://localhost:3000' },
    checkInstallationImmediately: true,
  })
  const ethereum = MMSDK.getProvider() // You can also access via window.ethereum
  ethereum.request({ method: 'eth_requestAccounts', params: [] }).then((x) => {
    setAccount(x)
  })

  return (
    <AccountContext.Provider value={{ account }}>
      {
        <div>
          <div>{children}</div>
        </div>
      }
    </AccountContext.Provider>
  )
}

export default AccountContext
