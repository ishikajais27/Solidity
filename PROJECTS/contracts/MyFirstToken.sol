// Let's make your own digital currency! You'll create a basic token that can be transferred between users, implementing the ERC20 standard. It's like 
// creating your own in-game money, demonstrating how to create and manage tokens.

// # Concepts you will master
// 1. ERC20 interface
// 2. totalSupply
// 3. balanceOf
// 4. transfer
// 5. token basics

// ERC-20 is a standard interface for fungible tokens on the Ethereum blockchain.
// Fungible means each token is identical and interchangeable (like 1 USDT = 1 USDT).
// ERC-20 defines a set of functions and events that all tokens should implement, making them compatible with wallets, exchanges, and other smart contracts.
// Key ERC-20 Functions
// totalSupply() – returns the total number of tokens.
// balanceOf(address account) – returns the token balance of a user.
// transfer(address to, uint256 amount) – transfers tokens to another address.
// transferFrom(address from, address to, uint256 amount) – allows a spender to transfer tokens on behalf of someone else.
// approve(address spender, uint256 amount) – gives permission to another address to spend tokens on your behalf.
// allowance(address owner, address spender) – shows how many tokens a spender can spend from an owner.
//Properties of tokens - name,symbol, decimals How divisible the token is (usually 18 for ERC-20),Total Supply: How many tokens exist initially


contract FirstToken {
    string public tokenName;
    string public symbol;
    uint public decimal;
    uint256 public totalSupply;

    mapping(address => uint256) public balance;

    event Transfer(address indexed from, address indexed to, uint256 amount);

    constructor(string memory _name, string memory _symbol, uint _decimal, uint256 _totalSupply) {
        tokenName = _name;
        symbol = _symbol;
        decimal = _decimal;
        totalSupply = _totalSupply;
        balance[msg.sender] = _totalSupply; 
    }

    function transferMoney(address receiver, uint256 amount) public {
        require(balance[msg.sender] >= amount, "Insufficient balance");
        balance[msg.sender] -= amount;
        balance[receiver] += amount;
        emit Transfer(msg.sender, receiver, amount);
    }

    function balanceOf(address account) public view returns (uint256) {
        return balance[account];
    }
}
