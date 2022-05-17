# Pre-requisites
- Node.js v12+
```
git clone https://github.com/joonspoon/proxy-contract
cd proxy-contract
npm install
// Create secrets.json in the root directory, containing "privateKey" and "alchemyApiKey".
```

# To make changes to the existing contract
```
cd Documents/proxy-contract
npx hardhat run --network goerli scripts/upgrade.js
```

## To deploy the contract to a local blockchain
```
cd Documents/proxy-contract && npx hardhat node  # in a separate terminal window
cd Documents/proxy-contract && npx hardhat run --network localhost scripts/deploy.js
```

## To interact with the contract running on the local node using the command line
```
npx hardhat run --network localhost scripts/upgrade.js
npx hardhat console --network localhost
const factory = await ethers.getContractFactory('Swap');
const contract = await factory.attach('0x7a689cdF61a0975605C143A7427d4611eAe2479B');
await contract.swap(...);
await contract.doFee(100);
const thing = await contract.getBalanceInEther();
const thing = await contract.getContractAddress();
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
npx hardhat run --network goerli scripts/deploy.js
npx hardhat run --network goerli scripts/upgrade.js
```

https://stackoverflow.com/questions/64526925/how-to-swap-tokens-on-uniswap-using-web3-js
https://github.com/yuyasugano/dai-rinkeby-demo
http://techflare.blog/how-to-send-a-transaction-of-smart-contract-in-ethereum/
https://web3js.readthedocs.io/en/v1.2.11/web3-eth.html#sendsignedtransaction
https://github.com/EdgeApp/edge-exchange-plugins/blob/2518be1152b4277764c120643e9efe53e6859d56/src/swap/totle.js
https://github.com/EdgeApp/edge-exchange-plugins/blob/5cef0f113933f54e0e3de45e11f628a397e7b611/src/swap/exolix.js
https://github.com/EdgeApp/edge-exchange-plugins/blob/d207dcd349055782b6512c1d33826f4c55556ae2/src/swap/transfer.js
https://ethereumdev.io/waiting-for-a-transaction-to-be-mined-on-ethereum-with-js/
