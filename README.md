# Degen-Token
 In this project, we have created the ERC20 Degen Token for Degen Gaming.

 ## Description
Minting new tokens: The platform should be able to create new tokens and distribute them to players as rewards. Only the owner can mint tokens.
Transferring tokens: Players should be able to transfer their tokens to others.
Redeeming tokens: Players should be able to redeem their tokens for items in the in-game store.
Checking token balance: Players should be able to check their token balance at any time.
Burning tokens: Anyone should be able to burn tokens, that they own, that are no longer needed.
Getting Started
For the execution of our code we will be using remixIDE , `https://remix.ethereum.org/#lang=en&optimize=false&runs=200&evmVersion=null&version=soljson-v0.8.25+commit.b61c2a91.js`, Snowtrace testnet.io : `https://testnet.snowtrace.io/` , and VS-Code for Deployment.

After opening the remix IDE create a new .sol file and start writing the project code.

Executing program
```
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract DegenToken is ERC20 {
    address public owner;

    string public constant REWARDS = "Revive Potion (1 DGN), Totem of Wrath (50 DGN), Book of Power (80 DGN)";

    mapping(address => string[]) private redeemedItems; // mapping between address to redeemed items
    mapping(address => uint) private redeemedItems_atAddress; // mapping between address and the items redeemed

    event Redeem(address indexed from, uint256 value, string reward);

    constructor() ERC20("Degen", "DGN") {
        _mint(msg.sender, 0);
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "This operation is restricted to the owner only");
        _;
    }

    // Mint Function for minting tokens 
    function mint(address _to, uint256 _value) public onlyOwner {
        _mint(_to, _value);
    }

    // Redeem Function for redeeming rewards  
    function redeem(uint8 _rewardIndex) public returns (uint) {
        uint cost;
        string memory reward;

        if (_rewardIndex == 1) {
            cost = 1;
            reward = "Revive Potion";
        } 
        else if (_rewardIndex == 2) {
            cost = 50;
            reward = "Totem of Wrath";
        } 
        else if (_rewardIndex == 3) {
            cost = 80;
            reward = "Book of Power";
        } 
        else {
            revert("Invalid reward index");
        }

        require(balanceOf(msg.sender) >= cost, "Insufficient balance");

        _burn(msg.sender, cost);
        redeemedItems[msg.sender].push(reward);
        redeemedItems_atAddress[msg.sender] += 1;

        emit Redeem(msg.sender, cost, reward);
        return redeemedItems_atAddress[msg.sender];
    }

    // getRedeemed Function for showcasing rewards available at address 
    function getRedeemedItems(address _user) public view returns (string[] memory) {
        return redeemedItems[_user];
    }
}
```

Set Environment in remixIDE to Injected Provider Metamask,

After writing the code and setting up environment it's time to compile it. So, press Ctrl + S to compile your code or click on Solidity comipler and then click on Compile project.sol . Now it's time to deploy click on deploy and run transction just below Solidity compiler and deploy . After deployment we can test mint and burn function to check if the code is working properly.

Also put deployed Address in testnet snowtrace.io and transactions will be reflected.

For Better Understanding you can refer to Video Explaination.
I hope you Understand the program Code and functioning well.
