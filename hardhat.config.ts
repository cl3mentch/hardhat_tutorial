import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
import "@nomicfoundation/hardhat-verify";
import Secret from "./secret.json";

const config: HardhatUserConfig = {
  solidity: "0.8.26",
  networks: {
    bscTestnet: {
      url: Secret.NETWORK_RPC_URL,
      accounts: [`0x${Secret.PRIVATE_KEY}`],
    },
  },
  etherscan: {
    apiKey: Secret.ETHERSCAN_API_KEY,
  },
  sourcify: {
    enabled: true,
  },
};

export default config;
