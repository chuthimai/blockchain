import { configDotenv } from "dotenv";
import { ethers } from "ethers";
import { readFileSync } from "fs";
import { join } from "path";

configDotenv();

const jsonPath = join(
  process.cwd(),
  'artifacts/contracts/FileStorage.sol',
  'FileStorage.json',
);
const contractJson = JSON.parse(readFileSync(jsonPath, 'utf-8'));

// Deploy the contract
async function main() {
  const rpcUrl = `${process.env.RPC_URL}:${process.env.RPC_PORT}` as string;
  const provider = new ethers.JsonRpcProvider(rpcUrl);

  const privateKey = process.env.WALLET_PRIVATE_KEY as string;
  const wallet = new ethers.Wallet(privateKey, provider);

  const contractFactory = new ethers.ContractFactory(
    contractJson.abi,
    contractJson.bytecode,
    wallet,
  );

  const contract = (await contractFactory.deploy())
  await contract.waitForDeployment();

  const contractAddr = await contract.getAddress();
  console.log('Contract deployed at:', contractAddr);
}

(async () => {
  await main();
})();