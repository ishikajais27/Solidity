// Build a system for lending and borrowing digital assets. You'll learn how to calculate interest and manage collateral, demonstrating core DeFi concepts. 
// It's like a digital bank for crypto, showing how to create lending and borrowing platforms.

// # Concepts you will master
// 1. Lending/borrowing
// 2. interest calculations
// 3. collateral

contract DeFiBank {
    struct User {
        uint deposited;
        uint borrowed;
        uint lastBorrowTime;
        uint collateral;
    }

    mapping(address => User) public users;
    uint public interestRate = 5; // 5% simple interest

    function deposit() public payable {
        users[msg.sender].deposited += msg.value;
    }

    function provideCollateral() public payable {
        users[msg.sender].collateral += msg.value;
    }

    function borrow(uint _amount) public {
        User storage u = users[msg.sender];
        require(u.collateral >= _amount / 2, "Not enough collateral");
        u.borrowed += _amount;
        u.lastBorrowTime = block.timestamp;
        payable(msg.sender).transfer(_amount);
    }

    function calculateInterest(address _user) public view returns (uint) {
        User memory u = users[_user];
        if (u.borrowed == 0) return 0;
        uint timePassed = (block.timestamp - u.lastBorrowTime) / 60; // minutes
        uint interest = (u.borrowed * interestRate * timePassed) / (100 * 60 * 24);
        return interest;
    }

    function repay() public payable {
        User storage u = users[msg.sender];
        uint interest = calculateInterest(msg.sender);
        uint totalDue = u.borrowed + interest;
        require(msg.value >= totalDue, "Insufficient amount");
        u.borrowed = 0;
        u.lastBorrowTime = 0;
    }

    function withdraw(uint _amount) public {
        User storage u = users[msg.sender];
        require(u.deposited >= _amount, "Not enough balance");
        u.deposited -= _amount;
        payable(msg.sender).transfer(_amount);
    }

    function getUserData(address _user) public view returns (uint, uint, uint, uint) {
        User memory u = users[_user];
        return (u.deposited, u.borrowed, u.collateral, calculateInterest(_user));
    }
}