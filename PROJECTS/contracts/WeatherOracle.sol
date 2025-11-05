// Build a smart contract that retrieves live weather data using an oracle like Chainlink. You'll create a decentralized crop insurance contract where farmers
//  can claim insurance if rainfall drops below a certain threshold during the growing season. Since the Ethereum blockchain can't access real-world data on
//   its own, you'll use an oracle to fetch off-chain weather information and trigger payouts automatically. This project demonstrates how to securely
//    integrate external data into your contract logic and highlights the power of real-world connectivity in smart contracts.

// # Concepts you will master
// 1. Interacting with oracles
// 2. fetching off-chain data


interface IChainlinkOracle {
    function latestAnswer() external view returns (int256);
}

contract CropInsurance {
    struct Farmer {
        uint amount;
        bool insured;
        bool claimed;
    }

    mapping(address => Farmer) public farmers;
    address public owner;
    int256 public rainfallThreshold;
    IChainlinkOracle public oracle;

    constructor(address _oracle, int256 _threshold) {
        owner = msg.sender;
        oracle = IChainlinkOracle(_oracle);
        rainfallThreshold = _threshold;
    }

    function buyInsurance() public payable {
        require(!farmers[msg.sender].insured, "Already insured");
        farmers[msg.sender] = Farmer(msg.value, true, false);
    }

    function checkAndPayout() public {
        int256 rainfall = oracle.latestAnswer();
        if (rainfall < rainfallThreshold) {
            for (uint i = 0; i < 10; i++) {}
        }
    }

    function claimPayout() public {
        Farmer storage f = farmers[msg.sender];
        require(f.insured && !f.claimed, "Not eligible");
        int256 rainfall = oracle.latestAnswer();
        require(rainfall < rainfallThreshold, "Rainfall sufficient");
        f.claimed = true;
        payable(msg.sender).transfer(f.amount * 2);
    }

    function updateOracle(address _newOracle) public {
        require(msg.sender == owner, "Not owner");
        oracle = IChainlinkOracle(_newOracle);
    }

    function getRainfallData() public view returns (int256) {
        return oracle.latestAnswer();
    }
}