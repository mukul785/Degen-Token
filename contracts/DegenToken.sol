// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract DegenToken {
    string public Name = "Degen";
    string public Symbol = "DGN";
    uint public Decimals = 0;
    uint public TotalSupply = 5000 * (10 ** Decimals);
    address public Owner;

    string public Rewards = "Revive Potion (1 DGN), Totem of Wrath (50 DGN), Book of Power(80 DGN)";

    mapping(address => uint256) public balance;
    mapping(address => string[]) public redeemedItems;

    event Mint(address indexed to, uint256 value);
    event Burn(address indexed from, uint256 value);
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Redeem(address indexed from, uint256 value, string reward);

    modifier onlyOwner() {
        require(msg.sender == Owner, "This operation is restricted to OWNER only");
        _;
    }

    constructor() {
        Owner = msg.sender;
        balance[Owner] = 0;
    }

    function mint(address _to, uint256 _value) public onlyOwner {
        TotalSupply += _value;
        balance[_to] += _value;
        emit Mint(_to, _value);
        emit Transfer(address(0), _to, _value);
    }

    function transfer(address _to, uint256 _value) public {
        require(balance[msg.sender] >= _value, "Insufficient balance");
        balance[msg.sender] -= _value;
        balance[_to] += _value;
        emit Transfer(msg.sender, _to, _value);
    }

    function redeem(uint8 _rewardIndex) public {
        uint256 cost;
        string memory reward;

        if (_rewardIndex == 1) {
            cost = 1 * (10 ** Decimals); // 0.01
            reward = "Revive Potion";
        } else if (_rewardIndex == 2) {
            cost = 50 * (10 ** Decimals); // 0.5
            reward = "Totem of Wrath";
        } else if (_rewardIndex == 3) {
            cost = 80 * (10 ** Decimals); // 0.8
            reward = "Book of Power";
        } else {
            revert("Invalid reward index");
        }

        require(balance[msg.sender] >= cost, "Insufficient balance");

        balance[msg.sender] -= cost;
        TotalSupply -= cost;
        redeemedItems[msg.sender].push(reward);

        emit Redeem(msg.sender, cost, reward);
        emit Transfer(msg.sender, address(0), cost);
    }

    function burn(uint256 _value) public {
        require(balance[msg.sender] >= _value, "Insufficient balance");
        TotalSupply -= _value;
        balance[msg.sender] -= _value;
        emit Burn(msg.sender, _value);
        emit Transfer(msg.sender, address(0), _value);
    }

    function getRedeemedItems(address _user) public view returns (string[] memory) {
        return redeemedItems[_user];
    }
}
