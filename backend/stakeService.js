const { ethers } = require("ethers");
require("dotenv").config();

const provider = new ethers.JsonRpcProvider(process.env.RPC_URL);
const wallet = new ethers.Wallet(process.env.PRIVATE_KEY, provider);

const abi = [
  "function stake(uint256 _amount) public",
  "function calculateReward(address _user) public view returns (uint256)"
];

const contract = new ethers.Contract(
  process.env.STAKING_ADDRESS,
  abi,
  wallet
);

async function stakeTokens(amount) {
  const tx = await contract.stake(amount);
  await tx.wait();
  console.log("Staked:", amount);
}

module.exports = { stakeTokens };
