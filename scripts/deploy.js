
const { ethers, upgrades } = require("hardhat");

async function main() {

  const Medium = await ethers.getContractFactory("Medium");
  console.log("Deploying UpgradableContract...");
  const medium = await upgrades.deployProxy(Medium,  { initializer: "initialize" });

  await medium.deployed();

  console.log("Address of Medium contract",medium.address);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});




