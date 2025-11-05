// Build a marketplace for buying and selling NFTs. You'll learn how to manage listings and royalties, demonstrating NFT trading. It's like a digital store 
// for collectibles, showing how to create NFT marketplaces.

// # Concepts you will master
// 1. NFT marketplace
// 2. listing/buying/selling
// 3. royalties




interface INFT {
    function transferFrom(address from, address to, uint tokenId) external;
    function ownerOf(uint tokenId) external view returns (address);
}

contract NFTMarketplace {
    struct Listing {
        address seller;
        address nft;
        uint tokenId;
        uint price;
        address creator;
        uint royaltyPercent;
        bool active;
    }

    mapping(uint => Listing) public listings;
    uint public nextId;

    function listNFT(address _nft, uint _tokenId, uint _price, uint _royaltyPercent) public {
        require(_price > 0, "Invalid price");
        listings[nextId] = Listing(msg.sender, _nft, _tokenId, _price, msg.sender, _royaltyPercent, true);
        nextId++;
    }

    function buyNFT(uint _id) public payable {
        Listing storage item = listings[_id];
        require(item.active, "Not active");
        require(msg.value == item.price, "Incorrect price");

        uint royalty = (msg.value * item.royaltyPercent) / 100;
        uint sellerAmount = msg.value - royalty;

        payable(item.creator).transfer(royalty);
        payable(item.seller).transfer(sellerAmount);

        INFT(item.nft).transferFrom(item.seller, msg.sender, item.tokenId);
        item.active = false;
    }

    function cancelListing(uint _id) public {
        Listing storage item = listings[_id];
        require(msg.sender == item.seller, "Not seller");
        item.active = false;
    }

    function getListing(uint _id) public view returns (address, uint, uint, bool) {
        Listing memory item = listings[_id];
        return (item.nft, item.tokenId, item.price, item.active);
    }
}
