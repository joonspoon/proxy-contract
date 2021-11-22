const { ethers, upgrades } = require('hardhat');
const rinkebyContractAddress = "0x4e127a4E9b1Fec0D6c4b27402Fdd3313E4833fFD";
const localContractAddress = "0xCf7Ed3AccA5a467e9e704C703E8D87F634fB0Fc9";
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
