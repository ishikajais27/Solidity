// Build a secure digital vault where users can deposit and withdraw tokenized gold (or any valuable asset), ensuring it's protected from reentrancy
//  attacks. Imagine you're creating a decentralized version of Fort Knox — users lock up tokenized gold, and can later withdraw it. But just like a real 
//  vault, this contract must prevent attackers from repeatedly triggering the withdrawal logic before the balance updates. You'll implement the `nonReentrant`
//   modifier to block reentry attempts, and follow Solidity security best practices to lock down your contract. This project shows how a seemingly simple
//    withdrawal function can become a vulnerability — and how to defend it properly.

// # Concepts you will master
// 1. Reentrancy attacks
// 2. nonReentrant modifier
// 3. security best practices


contract GoldVault {
    mapping(address => uint) public balances;
    bool private locked;

    modifier nonReentrant() {
        require(!locked, "Reentrancy blocked");
        locked = true;
        _;
        locked = false;
    }

    function deposit() public payable {
        balances[msg.sender] += msg.value;
    }

    function withdraw(uint _amount) public nonReentrant {
        require(balances[msg.sender] >= _amount, "Not enough balance");
        balances[msg.sender] -= _amount;
        (bool sent, ) = msg.sender.call{value: _amount}("");
        require(sent, "Withdraw failed");
    }

    function checkBalance() public view returns (uint) {
        return balances[msg.sender];
    }
}