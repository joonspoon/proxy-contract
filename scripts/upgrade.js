const { ethers, upgrades } = require('hardhat');
const goerliContractAddress = "0x22166b4D8605A3a0425B81A66c56A50bFcD02b8b";
const localContractAddress = "0x7a689cdF61a0975605C143A7427d4611eAe2479B";
const localOrGoerli = "Goerli";

async function main () {
  const SwapV2 = await ethers.getContractFactory('Swap');
  console.log('Upgrading contract...');
  if(localOrGoerli == "local")
    await upgrades.upgradeProxy(localContractAddress, SwapV2);
  else
    await upgrades.upgradeProxy(goerliContractAddress, SwapV2);
  console.log('Contract upgraded on ' + localOrGoerli);
}

main()
  .then(() => process.exit(0))
  .catch(error => {
    console.error(error);
    process.exit(1);
  });
