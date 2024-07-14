import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";

const DgenToken = buildModule("DgenTokenModule", (m) => {
  const tokenContract = m.contract("DgenToken", []);

  return { tokenContract };
});

export default DgenToken;
