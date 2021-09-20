// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

contract BlockshipToken {
    string public name;
    string public symbol;
    uint8 public decimals;
    uint256 public totalSupply;

    mapping(address => uint256) public balance;

    // owner => recipient => remaining
    mapping(address => mapping(address => uint256)) public allowances;

    event Transfer(address indexed from, address indexed to, uint256 value);

    event Approval(address indexed from, address indexed to, uint256 value);

    constructor() {
        name = "Blockship";
        symbol = "BLC";
        decimals = 8;
        totalSupply = 20000000;
    }

    function balanceOf(address _owner) public view returns (uint256 userBalance) {
        userBalance = balance[_owner];
    }

    function approve(address _spender, uint256 _value) public returns (uint256 allowance) {
        require(_spender != address(0), "Blockship:: Invalid recipient");
        allowance = allowances[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);
    }

    function transfer(address _to, uint256 value) public {
        require(balance[msg.sender] >= value, "Blockship:: Insufficient balance");
        balance[msg.sender] -= value;
        balance[_to] += value;
        emit Transfer(msg.sender, _to, value);
    }

    function transferFrom(
        address _to,
        address _from,
        uint256 value
    ) public {
        require(balance[_from] >= value, "Blockship:: Insufficient balance");
        balance[_from] -= value;
        balance[_to] += value;
        emit Transfer(_from, _to, value);
    }
}
