// Let's make a digital piggy bank! Users can deposit and withdraw Ether (the cryptocurrency). You'll learn how to manage balances (using `address` 
//to identify users) and track who sent Ether (using `msg.sender`). It's like a simple bank account on the blockchain, demonstrating how to handle Ether 
//and user addresses.
// # Concepts You'll Master
// 1. msg.sender
// 2. address
// 3. Ether balance
// 4. Deposits and withdrawals
contract DigiPigi{
    // address user;
    // uint256 balance;
    mapping(address => uint256) public balances;
    function sendEther(address payable receiver, uint256 amount) public payable{
        require(balance>amount,"Sending amount must be less than avilable balance");
        receiver.transfer(amount);
        balances[receiver]-=amount;
    }
    function receiveEther() public payable {
        require(msg.value>0,"Sending amount must be greater than 0");
         balances[msg.sender] += msg.value;
    }
     function getBalance() public view returns (uint256) {
        return balances[msg.sender];
    }

}