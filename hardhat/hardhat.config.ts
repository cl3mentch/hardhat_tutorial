import type { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox-viem";
import Secret from "./secret.json";

const config: HardhatUserConfig = {
  solidity: "0.8.26",
  networks: {
    bscTestnet: {
      url: Secret.NETWORK_RPC_URL,
      accounts: [`0x${Secret.PRIVATE_KEY}`],
      gas: 2100000,
      gasPrice: 8000000000,
    },
  },
  etherscan: {
    apiKey: Secret.ETHERSCAN_API_KEY,
  },
  sourcify: {
    enabled: true,
  },
  ignition: {
    requiredConfirmations: 1,
  },
};

export default config;
