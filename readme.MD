# Pre-requisites
- Node.js v12+
- npm
- An [Alchemy](https://www.alchemy.com/) key for interacting with the Ethereum blockchain
- An Ethereum wallet mnemonic (12 words) 
- The wallet address (starting with 0x)
- To deploy the contract on **Mainnet** - 0.1 ETH in that wallet needed for gas
- To deploy the contract on the **Rinkeby testnet** - test ETH from the [Chainlink faucet](https://faucets.chain.link/rinkeby)

# To use this code
```
git clone https://github.com/joonspoon/proxy-contract
cd proxy-contract
npm install
```
Create a file "secrets.json" in the source directory containing the wallet mnemonic and alchemy key:
```
{
  "seedPhrase": "xxxxxxx",
  "alchemyApiKey": "xxxx"
}
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
