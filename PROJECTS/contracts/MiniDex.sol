// Build a simple exchange for trading tokens. You'll learn how to create a digital marketplace using token swaps and liquidity pools. It's like a mini
//  version of a stock exchange, demonstrating how to create decentralized exchanges.

// # Concepts you will master
// 1. Minimal decentralized exchange
// 2. token swaps
// 3. liquidity pool


interface IERC20 {
    function transfer(address to, uint amount) external returns (bool);
    function transferFrom(address from, address to, uint amount) external returns (bool);
    function balanceOf(address account) external view returns (uint);
}

contract SimpleDEX {
    IERC20 public tokenA;
    IERC20 public tokenB;
    uint public reserveA;
    uint public reserveB;
    address public owner;

    constructor(address _tokenA, address _tokenB) {
        tokenA = IERC20(_tokenA);
        tokenB = IERC20(_tokenB);
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner");
        _;
    }

    function addLiquidity(uint amountA, uint amountB) public {
        tokenA.transferFrom(msg.sender, address(this), amountA);
        tokenB.transferFrom(msg.sender, address(this), amountB);
        reserveA += amountA;
        reserveB += amountB;
    }

    function getPriceAtoB(uint amountA) public view returns (uint) {
        require(reserveA > 0 && reserveB > 0, "No liquidity");
        return (amountA * reserveB) / reserveA;
    }

    function swapAtoB(uint amountA) public {
        uint amountB = getPriceAtoB(amountA);
        require(tokenA.transferFrom(msg.sender, address(this), amountA), "Transfer failed");
        require(tokenB.balanceOf(address(this)) >= amountB, "Insufficient liquidity");
        tokenB.transfer(msg.sender, amountB);
        reserveA += amountA;
        reserveB -= amountB;
    }

    function getReserves() public view returns (uint, uint) {
        return (reserveA, reserveB);
    }

    function withdrawLiquidity(uint amountA, uint amountB) public onlyOwner {
        require(reserveA >= amountA && reserveB >= amountB, "Not enough reserves");
        reserveA -= amountA;
        reserveB -= amountB;
        tokenA.transfer(msg.sender, amountA);
        tokenB.transfer(msg.sender, amountB);
    }
}
```
