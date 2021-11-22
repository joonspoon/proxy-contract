const { ethers, upgrades } = require('hardhat');

async function main () {
  const contractFactory = await ethers.getContractFactory('Swap');
  console.log('Deploying Swap...');
  const contract = await upgrades.deployProxy(contractFactory);
  await contract.deployed();
  console.log('Swap contract deployed to:', contract.address);
}

main()
  .then(() => process.exit(0))
  .catch(error => {
    console.error(error);
    process.exit(1);
  });
