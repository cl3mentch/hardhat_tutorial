import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
require('dotenv').config({path:__dirname+'./.env'})

const config: HardhatUserConfig = {
  solidity: "0.8.26",
  networks: {
    bscTestnet: {
      url: process.env.NETWORK_RPC_URL,
      accounts: [`0x${process.env.PRIVATE_KEY}`]
    },
  },
};

export default config;
