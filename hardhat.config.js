require('@nomiclabs/hardhat-ethers');
require('@openzeppelin/hardhat-upgrades');

const { alchemyApiKey, privateKey } = require('./secrets.json');

module.exports = {
   solidity: "0.8.4",

   networks: {
     goerli: {
       url: `https://eth-goerli.alchemyapi.io/v2/${alchemyApiKey}`,
       accounts: [ privateKey ]
     },
     rinkeby: {
       url: `https://eth-rinkeby.alchemyapi.io/v2/${alchemyApiKey}`,
       accounts: [ privateKey ]
     },
   },
};
