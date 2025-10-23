// Build a contract that uses another contract to do calculations. You'll learn how contracts can talk to each other by calling functions of other 
//contracts (using `address casting`). It's like having one app ask another app to do some math, showing how to interact with other contracts.
// # Concepts You'll Master
// 1. Calling functions of another contract
// 2. address casting
// 3. imports


contract A{
    enum operations{
        add,
        sub,
        multiply,
        divide
    }
    address calcaddr;
      constructor(address addr_){
        calcaddr = addr_;
      }

    function doOperations(uint a,uint b,operations op)public returns(uint){
        require(b != 0, "Cannot divide by zero");
        require(calcaddr != address(0), "Calculator address not set");
        require(uint(op) <= 3, "Invalid operation");
    Calculator calc = Calculator(calcaddr);
    if(op == operations.add){
return calc.add(a, b);
    }
    else if(op == operations.divide){
return calc.divide(a, b);
    }
    else if(op == operations.multiply){
return calc.multiply(a, b);
    }
    else if(op == operations.sub){
return calc.sub(a, b);
    }
    }
}


contract B{
    function add(uint a, uint b) public pure returns (uint) {
        return a + b;
    }

    function sub(uint a, uint b) public pure returns (uint) {
        return a - b;
    }

    function multiply(uint a, uint b) public pure returns (uint) {
        return a * b;
    }

    function divide(uint a, uint b) public pure returns (uint) {
        return a / b;  
    }
}