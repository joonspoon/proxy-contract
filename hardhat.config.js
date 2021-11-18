require('@nomiclabs/hardhat-ethers');
require('@openzeppelin/hardhat-upgrades');

const { alchemyApiKey, seedPhrase } = require('./secrets.json');

module.exports = {
   solidity: "0.8.4",

   networks: {
     rinkeby: {
       url: `https://eth-rinkeby.alchemyapi.io/v2/${alchemyApiKey}`,
       accounts: { mnemonic: seedPhrase },
     },
   },
};
