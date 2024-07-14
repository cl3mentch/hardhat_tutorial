import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";

const DgenToken = buildModule("DgenBankModule", (m) => {
  const tokenContract = m.contract("DgenBank", []);

  return { tokenContract };
});

export default DgenToken;
