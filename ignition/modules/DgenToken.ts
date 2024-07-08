import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";

const DgenToken = buildModule("DgenTokenModule", (m) => {
  const tokenContract = m.contract("DgenToken", ['DgenToken', 'DGT', 18, 21000000]);

  return { tokenContract };
});

export default DgenToken;
