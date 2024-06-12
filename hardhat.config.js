require("@nomicfoundation/hardhat-toolbox");
require('dotenv').config();

const FORK_FUJI = true;
const FORK_MAINNET = false;
let forkingData = undefined;

if (FORK_MAINNET) {
  forkingData = {
    url: "https://api.avax.network/ext/bc/C/rpcc",
  };
}
if (FORK_FUJI) {
  forkingData = {
    url: "https://api.avax-test.network/ext/bc/C/rpc",
  };
}

// /** @type import('hardhat/config').HardhatUserConfig */
// import('hardhat/config').HardhatUserConfig
module.exports = {
  solidity: "0.8.18",
  networks: {
    hardhat: {
      gasPrice: 225000000000,
      chainId: !forkingData ? 43112 : undefined, //Only specify a chainId if we are not forking
      forking: forkingData,
    },
    fuji: {
      url: "https://api.avax-test.network/ext/bc/C/rpc",
      gasPrice: 225000000000,
      chainId: 43113,
      accounts: ['5432c50c6a9df32cb99e1f0995b8b72890e1ea074ac484a100643ccf10ed8174'], // we use a .env file to hide our wallets private key
    },
    mainnet: {
      url: "https://api.avax.network/ext/bc/C/rpc",
      gasPrice: 225000000000,
      chainId: 43114,
      accounts: ['5432c50c6a9df32cb99e1f0995b8b72890e1ea074ac484a100643ccf10ed8174'],
    },
  },
  etherscan: {
    apiKey: [process.env.SNOW_API_KEY], // we use an .env file to hide our Snowtrace API KEY
  },
};
