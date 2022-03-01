const { ethers, upgrades } = require('hardhat');
const rinkebyContractAddress = "0xAd14652864994d93FeDb1B7f59337372C453E6BD";
const localContractAddress = "0x7a689cdF61a0975605C143A7427d4611eAe2479B";
const localOrRinkeby = "rinkeby";

async function main () {
  const SwapV2 = await ethers.getContractFactory('Swap');
  console.log('Upgrading contract...');
  if(localOrRinkeby == "local")
    await upgrades.upgradeProxy(localContractAddress, SwapV2);
  else
    await upgrades.upgradeProxy(rinkebyContractAddress, SwapV2);
  console.log('Contract upgraded on ' + localOrRinkeby);
}

main()
  .then(() => process.exit(0))
  .catch(error => {
    console.error(error);
    process.exit(1);
  });
