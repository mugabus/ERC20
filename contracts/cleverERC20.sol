// SPDX-License-Identifier: MIT
pragma solidity ^0.7.3;

contract ERC20 {
    // State variables to store token details
    string public name; // Token name
    string public symbol; // Token symbol
    uint8 public decimals; // Token decimals
    uint256 public totalSupply; // Total token supply

    // Mapping to keep track of balances and allowances
    mapping(address => uint256) private _balances; // Balances of token holders
    mapping(address => mapping(address => uint256)) private _allowances; // Allowances for token spending

    // Events to track transfers and approvals
    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    event Approval(address indexed _owner, address indexed _spender, uint256 _value);

    // Constructor to initialize token details and assign total supply to the contract deployer
    constructor(string memory _name, string memory _symbol, uint8 _decimals, uint256 _totalSupply) public {
        name = _name;
        symbol = _symbol;
        decimals = _decimals;
        totalSupply = _totalSupply;
        _balances[msg.sender] = _totalSupply; // Assign total supply to contract deployer
    }

    // Function to retrieve balance of a given address
    function balanceOf(address _owner) public view returns (uint256) {
        require(_owner != address(0), "Zero address"); // Ensure address is valid
        return _balances[_owner]; // Return balance of the address
    }

    // Function to transfer tokens from the sender's address to another address
    function transfer(address _to, uint256 _value) public returns (bool) {
        require(_balances[msg.sender] >= _value && _value > 0, "Insufficient balance"); // Check sender's balance
        _balances[msg.sender] -= _value; // Deduct tokens from sender
        _balances[_to] += _value; // Add tokens to recipient
        emit Transfer(msg.sender, _to, _value); // Emit transfer event
        return true;
    }

    // Function to transfer tokens from one address to another, given approval
    function transferFrom(address _from, address _to, uint256 _value) public returns (bool) {
        require(_allowances[_from][msg.sender] >= _value, "Allowance exceeded"); // Check allowance
        require(_balances[_from] >= _value && _value > 0, "Insufficient balance"); // Check sender's balance
        _balances[_from] -= _value; // Deduct tokens from sender
        _balances[_to] += _value; // Add tokens to recipient
        _allowances[_from][msg.sender] -= _value; // Update allowance
        emit Transfer(_from, _to, _value); // Emit transfer event
        return true;
    }

    // Function to approve another address to spend tokens on behalf of the sender
    function approve(address _spender, uint256 _value) public returns (bool) {
        _allowances[msg.sender][_spender] = _value; // Set allowance
        emit Approval(msg.sender, _spender, _value); // Emit approval event
        return true;
    }

    // Function to retrieve the allowance of one address to spend on behalf of another
    function allowance(address _owner, address _spender) public view returns (uint256) {
        return _allowances[_owner][_spender]; // Return allowance
    }
}
