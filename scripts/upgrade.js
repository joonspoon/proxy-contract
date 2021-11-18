const { ethers, upgrades } = require('hardhat');
const rinkebyContractAddress = "0x303871bE5640fbDA8DEba71c3B6261011CA1dF61";
const localContractAddress = "";
const localOrRinkeby = "Rinkeby";

async function main () {
  const BoxV2 = await ethers.getContractFactory('Box');
  console.log('Upgrading contract...');
  if(localOrRinkeby == "local")
    await upgrades.upgradeProxy(localContractAddress, BoxV2);
  else
    await upgrades.upgradeProxy(rinkebyContractAddress, BoxV2);
  console.log('Contract upgraded on ' + localOrRinkeby);
}

main()
  .then(() => process.exit(0))
  .catch(error => {
    console.error(error);
    process.exit(1);
  });
