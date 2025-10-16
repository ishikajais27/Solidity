// Build a multi-currency digital tip jar! Users can send Ether directly or simulate tips in foreign currencies like USD or EUR. You'll learn how to manage
// currency conversion, handle Ether payments using `payable` and `msg.value`, and keep track of individual contributions. Think of it like an advanced
// version of a 'Buy Me a Coffee' button — but smarter, more global, and Solidity-powered.
// # Concepts You'll Master
// 1. conversion
// 2. denominations
// 3. payable


contract TipJar {
    address public owner;
    mapping(address => mapping(string => uint256)) public contributions;
    mapping(string => uint256) public totalTips;
    uint256 public usdToEth;
    uint256 public eurToEth;

    constructor(uint256 _usd, uint256 _eur) {
        owner = msg.sender;
        usdToEth = _usd;
        eurToEth = _eur;
    }

    function tipETH() public payable {
        require(msg.value > 0, "Tip must be more than 0");
        contributions[msg.sender]["ETH"] += msg.value;
        totalTips["ETH"] += msg.value;
    }

    function tipUSD(uint256 amount) public {
        require(amount > 0, "Tip must be more than 0");
        contributions[msg.sender]["USD"] += amount;
        totalTips["USD"] += amount;
        totalTips["ETH"] += amount * usdToEth;
    }

    function tipEUR(uint256 amount) public {
        require(amount > 0, "Tip must be more than 0");
        contributions[msg.sender]["EUR"] += amount;
        totalTips["EUR"] += amount;
        totalTips["ETH"] += amount * eurToEth;
    }

    function withdrawETH(uint256 amount) public {
        require(msg.sender == owner, "Only owner");
        require(amount <= address(this).balance, "Not enough ETH");
        payable(owner).transfer(amount);
    }

    function setRates(uint256 usdRate, uint256 eurRate) public {
        require(msg.sender == owner, "Only owner");
        usdToEth = usdRate;
        eurToEth = eurRate;
    }

    function getUserTip(address user, string memory currency) public view returns (uint256) {
        return contributions[user][currency];
    }

}