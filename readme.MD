# Pre-requisites
- Node.js v12+
```
git clone https://github.com/joonspoon/proxy-contract
cd proxy-contract
npm install
// Create secrets.json containing "seedPhrase" and "alchemyApiKey".
```

# To make changes to the existing contract
```
npx hardhat run --network rinkeby scripts/upgrade.js
```

## To deploy the contract to a local blockchain
```
cd Documents/proxy-contract && npx hardhat node  # in a separate terminal window
npx hardhat run --network localhost scripts/deploy.js
```

## To interact with the contract running on the local node using the command line
```
npx hardhat run --network localhost scripts/upgrade.js
npx hardhat console --network localhost
const factory = await ethers.getContractFactory('Swap');
const contract = await factory.attach('0x9fE46736679d2D9a65F0992F2272dE9f3c7fa6e0');
await contract.swap(...);
```

## To interact with the contract running on the local node using JavaScript
```
npx hardhat run --network localhost ./scripts/index.js
```

## To run the unit tests
```
npx hardhat test
```

## To deploy the contract running on the Rinkeby test network
```
npx hardhat run --network rinkeby scripts/deploy.js
npx hardhat run --network rinkeby scripts/upgrade.js
```
