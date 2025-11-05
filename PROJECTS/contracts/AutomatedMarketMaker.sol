// Build a system for trading tokens automatically. You'll learn how to create liquidity pools and implement the constant product formula, demonstrating AMM 
// logic. It's like a digital exchange for tokens, showing how to create automated markets.

// # Concepts you will master
// 1. AMM logic
// 2. constant product formula
// 3. liquidity pools


contract SimpleAMM {
    uint public reserveTokenA;
    uint public reserveTokenB;
    mapping(address => uint) public liquidity;

    function addLiquidity(uint _amountA, uint _amountB) public payable {
        require(_amountA > 0 && _amountB > 0, "Invalid amounts");
        reserveTokenA += _amountA;
        reserveTokenB += _amountB;
        liquidity[msg.sender] += _amountA;
    }

    function getPrice(uint _inputAmount, bool _isAToB) public view returns (uint) {
        if (_isAToB) {
            uint output = (reserveTokenB * _inputAmount) / (reserveTokenA + _inputAmount);
            return output;
        } else {
            uint output = (reserveTokenA * _inputAmount) / (reserveTokenB + _inputAmount);
            return output;
        }
    }

    function swapAtoB(uint _amountA) public {
        require(_amountA > 0, "Invalid amount");
        uint amountB = getPrice(_amountA, true);
        reserveTokenA += _amountA;
        reserveTokenB -= amountB;
        payable(msg.sender).transfer(amountB);
    }

    function swapBtoA(uint _amountB) public {
        require(_amountB > 0, "Invalid amount");
        uint amountA = getPrice(_amountB, false);
        reserveTokenB += _amountB;
        reserveTokenA -= amountA;
        payable(msg.sender).transfer(amountA);
    }

    function getReserves() public view returns (uint, uint) {
        return (reserveTokenA, reserveTokenB);
    }
}
```
