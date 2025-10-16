// Build a simple IOU contract for a private group of friends. Each user can deposit ETH, track personal balances, log who owes who, and settle debts 
//all on-chain. You’ll learn how to accept real Ether using `payable`, transfer funds between addresses, and use nested mappings to represent relationships
// like 'Alice owes Bob'. This contract mirrors real-world borrowing and lending, and teaches you how to model those interactions in Solidity.
// # Concepts You'll Master
// 1. address
// 2. token transfer
// 3. payable for gas
// 4. validation (require)

contract PrivateIOU{
   address[] public users;
    mapping(address=>uint256) balance;
    mapping(address=> mapping(address => uint256)) debt;
   function deposit() public payable{
    require(msg.value>0,"Amount should be greater than zero");
    balance[msg.sender]+=msg.value;
      bool exists = false;
        for (uint i = 0; i < users.length; i++) {
            if (users[i] == msg.sender) {
                exists = true;
                break;
            }
        }
        if (!exists) {
            users.push(msg.sender);
        }
   }
   function BorrowMoney(address payable borrower,address payable sender,uint256 amount)public payable{
    require(balance[sender]>amount,"Amount must be less than the sender have");
    require(amount>0,"Amount must be greater the 0");
    debt[borrower][sender]+=amount;
    balance[borrower]+=amount;
    balance[sender]-=amount;
   }
   function RepayDebt(address payable borrower,address payable receiver,uint256 amount)public payable{
   require(amount>0,"Amount must be greater the 0");
   require(balance[borrower] >= amount, "Borrower does not have enough balance");
   require(debt[borrower][receiver] >= amount, "Repay amount exceeds debt");
    debt[borrower][receiver]-=amount;
    balance[borrower]-=amount;
    balance[receiver]+=amount;

}
}