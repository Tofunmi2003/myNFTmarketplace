
require('dotenv').config();
const HDWalletProvider = require('@truffle/hdwallet-provider');
module.exports = {
  networks: {
    sepolia: {
      provider: () => new HDWalletProvider(MNEMONIC, `https://eth-sepolia.g.alchemy.com/v2/<1b9SLyHWL6CZAEN8VykEL4BPah07frT9>`),
      network_id: 11155111,
      confirmations: 2,
      timeoutBlocks: 200,
      skipDryRun: true
    }
  }
};