// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

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

    // Burn Function to burn unwanted Tokens
    function burn(uint256 _value) public {
        _burn(msg.sender, _value);
    }

    // Transfer Function to transfer tokens
    function transfer(address recipient, uint256 amount) public override returns (bool) {
        _transfer(_msgSender(), recipient, amount);
        return true;
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

        //Burn function calling
        burn(cost);
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
