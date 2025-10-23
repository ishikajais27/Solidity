// Build a secure Vault contract that only the owner (master key holder) can control. You'll split your logic into two parts: a reusable 'Ownable' base 
// contract and a 'VaultMaster' contract that inherits from it. Only the owner can withdraw funds or transfer ownership. This shows how to use Solidity's
// inheritance model to write clean, reusable access control patterns — just like in real-world production contracts. It's like building a secure digital
//  safe where only the master key holder can access or delegate control.

//  # Concepts you will master
//  1. Ownable pattern
//  2. inheritance
//  3. robust access control

contract Ownable{
address public  owner;

constructor() {
    owner = msg.sender;
}
modifier onlyOwner(){
    require(owner == msg.sender,"Not Owner");
    _;
}

}

contract VaultMaster is Ownable{
   function withdraw(uint amount) public onlyOwner {
    require(address(this).balance >= amount, "Current balance should be greater than the withdraw amount");
    payable(msg.sender).transfer(amount);
}
  function deposit() public payable {
    require(msg.value > 0, "Must send some Ether");
}
function transferOwnership(address addr)public onlyOwner {
    owner= addr;
}

}