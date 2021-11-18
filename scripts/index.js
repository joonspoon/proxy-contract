/* Exploratory functions that interact with the local node */
const address = '0x5FbDB2315678afecb367f032d93F642f64180aa3';

async function main() {
  const Box = await ethers.getContractFactory('Box');
  const box = await Box.attach(address);

  await box.store(23);
  const value = await box.retrieve();
  console.log('Box value is', value.toString());

  await box.withdrawFeesCollected();
  const value = await box.retrieve();
  console.log('After withdrawal, box value is', value.toString());
}

async function retrieveAccounts() {
  const accounts = await ethers.provider.listAccounts();
  console.log(accounts);
}

async function estimateGas() {
  const fs = require('fs');
  const contract = JSON.parse(fs.readFileSync('./artifacts/contracts/Box.sol/Box.json', 'utf8'));
  const provider = ethers.getDefaultProvider();
  const erc20 = new ethers.Contract(address, contract.abi, provider);
  const gasEstimate = await erc20.estimateGas.store(23);
  console.log('Gas estimate for this transaction is', gasEstimate.toString());
  return gasEstimate;
}

main()
  .then(() => process.exit(0))
  .catch(error => {
    console.error(error);
    process.exit(1);
  });
