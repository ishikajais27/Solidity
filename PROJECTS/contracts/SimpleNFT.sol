// Create your own digital collectibles (NFTs)! You'll learn how to make unique digital items by implementing the ERC721 standard and storing metadata.
//  It's like creating digital trading cards, demonstrating NFT creation.

// # Concepts you will master
// 1. ERC721 basics
// 2. minting NFTs
// 3. metadata storage



contract MyCollectibles {
    string public name = "MyCollectible";
    string public symbol = "MYC";

    uint public nextId;
    mapping(uint => address) public ownerOf;
    mapping(address => uint) public balanceOf;
    mapping(uint => string) public tokenURI;

    event Transfer(address indexed from, address indexed to, uint indexed tokenId);

    function mint(string memory _tokenURI) public {
        uint tokenId = nextId;
        ownerOf[tokenId] = msg.sender;
        balanceOf[msg.sender] += 1;
        tokenURI[tokenId] = _tokenURI;
        emit Transfer(address(0), msg.sender, tokenId);
        nextId++;
    }

    function transfer(address _to, uint _tokenId) public {
        require(ownerOf[_tokenId] == msg.sender, "Not owner");
        ownerOf[_tokenId] = _to;
        balanceOf[msg.sender] -= 1;
        balanceOf[_to] += 1;
        emit Transfer(msg.sender, _to, _tokenId);
    }

    function tokenMetadata(uint _tokenId) public view returns (string memory) {
        return tokenURI[_tokenId];
    }
}






