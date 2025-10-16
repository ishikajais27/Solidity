// Create a basic auction! Users can bid on an item, and the highest bidder wins when time runs out. You'll use 'if/else' to decide who wins based
// on the highest bid and track time using the blockchain's clock (`block.timestamp`). This is like a simple version of eBay on the blockchain,
// showing how to control logic based on conditions and time.
// # Concepts You'll Master
// 1. if/else statements
// 2. Time (block.timestamp)
// 3. Basic bidding

contract Auction{
    struct Bid {
    string name;
    uint amount;
}

mapping(address => Bid) public bids;
    uint public auctionEndTime;
     address[] public bidderAddresses;
    function startAuction(uint duration) public {
        auctionEndTime = block.timestamp + duration;
    }

function addBids(string memory n,uint a) public payable{
    require(block.timestamp < auctionEndTime, "Auction ended");
    require(a>bids[msg.sender].amount,"Current amount must be greater than previous bid");
    bids[msg.sender] = Bid({
        name: n,
        amount:a
    });

  bool exist = false;
  for(uint i = 0;i<bidderAddresses.length;i++){
   if( bidderAddresses[i] == msg.sender){
       exist = true;
       break;
   }
  }
    if(!exist){
     bidderAddresses.push(msg.sender);   
    }
}

    function getHighestBid() public view returns(address win, string memory name, uint amount){
        uint highestAmount = 0;
        address highestBidder;
        string memory Name;

        for(uint i = 0; i < bidderAddresses.length; i++){
            address bidder = bidderAddresses[i];
            uint bidAmount = bids[bidder].amount;

            if(bidAmount > highestAmount){
                highestAmount = bidAmount;
                highestBidder = bidder;
                  Name = bids[bidder].name;
            }
        }

        return (highestBidder, Name, highestAmount);
    }


}