# Pre-requisites
- Node.js v12+
```
git clone https://github.com/joonspoon/proxy-contract
cd proxy-contract
npm install
// Create secrets.json containing "seedPhrase" and "alchemyApiKey".
```

# To compile
```
npx hardhat compile
```

# To deploy the contract to a local blockchain
```
npx hardhat node  # in a separate terminal window
npx hardhat run --network localhost scripts/deploy.js
```

# To interact with the contract running on the local node
```
npx hardhat run --network localhost ./scripts/index.js
```

# To run the unit tests
```
npx hardhat test
```

# To deploy the contract running on the Rinkeby test network
```
npx hardhat run --network localhost scripts/deploy.js
```
