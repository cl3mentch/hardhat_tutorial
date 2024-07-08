import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
import Secret from './secret.json'

const config: HardhatUserConfig = {
  solidity: "0.8.26",
  networks: {
    bscTestnet: {
      url: Secret.NETWORK_RPC_URL,
      accounts: [`0x${Secret.PRIVATE_KEY}`]
    },
  },
};

export default config;
