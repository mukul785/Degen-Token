# Degen-Token
 In this project, we have created the ERC20 Degen Token for Degen Gaming.

 ## Description
 In this project we created ERC20 DGN Token for players of Degen gaming and added functionalities like mint, burn, check balance, transfer, reedem for in-game rewards so that players can:
 1. Players can check their balance anytime.
 2. Players can reedem token for in-game rewards.
 3. Players can transfer tokens to other players in game.
 4. Owner can mint tokens to give them to players as rewards.

 ## How to use
 1. Clone the repository
 2. Run `npm init -y`
 3. Run `npm install --save-dev hardhat`
 4. Run `npx hardhat init` and choose javascript
 5. Use avalanche fuji faucet to avail test tokens in avalanche fuji network
 6. Change private key of your wallet account with test tokens in `hardhat.confige.js` in accounts line.
 7. Deploy contract using `npx hardhat run scripts/deploy.js --network fuji`
 8. Copy the contract address on which it is deplpoyed.
 9. Copy and paste code of  `DegenToken.sol` in remix and deploy it using 'AtAddress' providing the contract address and using Injected Provider-Metamask.
 10. Test it by mint, burn, balance and finally reedem for in-game rewards providing the parameters.
 11. Check for reedemed rewards for players. It will show all purchased rewards of the players.
 12. Open snowtrace.io and search your contract address and verify all transactions are visible on snow trace.
