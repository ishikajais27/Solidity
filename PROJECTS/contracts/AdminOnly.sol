// Build a contract that simulates a treasure chest controlled by an owner. The owner can add treasure, approve withdrawals for specific users, and even
// withdraw treasure themselves. Other users can attempt to withdraw, but only if the owner has given them an allowance and they haven't withdrawn before. 
//The owner can also reset withdrawal statuses and transfer ownership of the treasure chest. This demonstrates how to create a contract with restricted 
//access using a 'modifier' and `msg.sender`, similar to how only an admin can perform certain actions in a game or application.
// # Concepts You'll Master
// 1. modifier
// 2. msg.sender for ownership
// 3. Basic access control



contract AdminOnly{
    address owner;
    address[] users;
    uint chestBalance;
    mapping(address => bool) public approve;
    mapping(address => bool) public hasWithdrawn;
    constructor() {
    owner = msg.sender;
}

    modifier onlyOwner() {
    require(msg.sender == owner, "Not the owner");
    _;
}
function addTreasure(uint amount) public onlyOwner {
    require(amount > 0, "Amount must be greater than 0");
    chestBalance += amount; 
}
function allowHimself(uint withdrawAmount) public payable onlyOwner{
     require(withdrawAmount < chestBalance, "Needed Amount must be less than avilable balance");
     require(withdrawAmount > 0, "Amount must be greater than 0");
     chestBalance-=withdrawAmount;
     payable(msg.sender).transfer(withdrawAmount);

}
function updateOwnership(address newOwner) public onlyOwner(){
    owner = newOwner;

}
function allowUsers(address a) public onlyOwner{
for(uint i = 0;i<users.length;i++){
   if(users[i]== a){
     approvedUsers[a] = true
     hasWithdrawn[a] = false
   }
}
}
    function withdraw(uint amount) public payable {
        require(approve[msg.sender], "Not approved by owner");
        require(!hasWithdrawn[msg.sender], "Already withdrawn");
        require(amount <= chestBalance, "Not enough balance");

        chestBalance -= amount;
        hasWithdrawn[msg.sender] = true;
        payable(msg.sender).transfer(amount);
    }
    function addUser(address a) public onlyOwner {
        users.push(a);
    }



}