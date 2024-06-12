// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract DegenToken {
    string public Name = "Degen";
    string public Symbol = "DGN";
    uint public Decimals = 0;
    uint public TotalSupply = 5000 * (10 ** Decimals);
    address public Owner;

    mapping(address => uint256) public balance;

    event Mint(address indexed to, uint256 value);
    event Burn(address indexed from, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Redeem(address indexed from, uint256 value);

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

    function redeem(uint256 _value) public {
        require(balance[msg.sender] >= _value, "Insufficient balance");
        balance[msg.sender] -= _value;
        TotalSupply -= _value;
        emit Redeem(msg.sender, _value);
        emit Transfer(msg.sender, address(0), _value);
    }

    function burn(uint256 _value) public {
        require(balance[msg.sender] >= _value, "Insufficient balance");
        TotalSupply -= _value;
        balance[msg.sender] -= _value;
        emit Burn(msg.sender, _value);
        emit Transfer(msg.sender, address(0), _value);
    }
}
