// Build a contract to sell your tokens for Ether. You'll learn how to set a price and manage sales, demonstrating token economics. It's like a pre-sale
//  for your digital currency, showing how to sell tokens for Ether.

// # Concepts you will master
// 1. Selling tokens for Ether
// 2. rate calculations
// 3. token economics

// Buyer -> sends ETH -> Sale contract
// Sale contract -> calculates tokens = ETH sent / token price
// Sale contract -> transfers tokens to buyer
// ETH stays in contract -> owner withdraws later


//Ether = cash in your wallet, tokens = arcade tickets, reward points, or gift cards you can spend only in specific places.1 token = 0.01 ETH (like 1 rupee)
contract SellToken{
    uint256 public tokenPrice = 0.01 ether; 
    uint256 public avilableToke;
    address public owner;
    constructor(uint256 bal){
       avilableToke = bal;
       owner = msg.sender;
    }
   function sendETH()public payable{
    uint256 tokenstoSent = msg.value / tokenPrice;
    require(tokenstoSent<=avilableToke,"Insufficient balance");
    avilableToke -= tokenstoSent;
   }
   function withdrawETH() public {
        require(msg.sender == owner, "Only owner can withdraw");
        payable(owner).transfer(address(this).balance);
    }

}