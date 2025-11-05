// Build a digital currency that maintains a stable value. You'll learn how to keep the price steady using peg mechanisms, demonstrating stablecoin mechanics.
//  It's like a digital dollar, showing how to create stablecoins.



contract StableCoin {
    string public name = "Simple Stablecoin";
    string public symbol = "SSC";
    uint8 public decimals = 18;

    uint public totalSupply;
    address public owner;
    uint public pegValue = 1 ether;

    mapping(address => uint) public balanceOf;
    mapping(address => uint) public collateral;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner");
        _;
    }

    function depositCollateral() public payable {
        require(msg.value > 0, "Send some collateral");
        collateral[msg.sender] += msg.value;
        uint tokensToMint = msg.value;
        totalSupply += tokensToMint;
        balanceOf[msg.sender] += tokensToMint;
    }

    function redeem(uint _amount) public {
        require(balanceOf[msg.sender] >= _amount, "Insufficient balance");
        balanceOf[msg.sender] -= _amount;
        totalSupply -= _amount;
        uint collateralToReturn = _amount;
        require(collateral[msg.sender] >= collateralToReturn, "Not enough collateral");
        collateral[msg.sender] -= collateralToReturn;
        payable(msg.sender).transfer(collateralToReturn);
    }

    function transfer(address _to, uint _amount) public returns (bool) {
        require(balanceOf[msg.sender] >= _amount, "Not enough balance");
        balanceOf[msg.sender] -= _amount;
        balanceOf[_to] += _amount;
        return true;
    }

    function adjustPeg(uint newPeg) public onlyOwner {
        require(newPeg > 0, "Invalid peg value");
        pegValue = newPeg;
    }

    function getCollateral(address user) public view returns (uint) {
        return collateral[user];
    }

    function getTokenValueInCollateral(uint tokenAmount) public view returns (uint) {
        return (tokenAmount * pegValue) / 1 ether;
    }
}
