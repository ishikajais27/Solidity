// Build a fair and random lottery! You'll learn how to use external services like Chainlink VRF to generate random numbers. It's like a lottery on the
//  blockchain, demonstrating how to use external randomness.

// # Concepts you will master
// 1. Chainlink VRF
// 2. random number generation
// 3. lottery logic

contract SimpleLottery {
    address public manager;
    address[] public players;
    address public winner;
    uint private seed;

    constructor() {
        manager = msg.sender;
        seed = uint(keccak256(abi.encodePacked(block.timestamp, msg.sender)));
    }

    function enter() public payable {
        require(msg.value == 0.01 ether, "Entry fee is 0.01 ETH");
        players.push(msg.sender);
    }

    function getRandom() private returns (uint) {
        seed = uint(keccak256(abi.encodePacked(block.timestamp, msg.sender, seed)));
        return seed;
    }

    function pickWinner() public {
        require(msg.sender == manager, "Only manager");
        require(players.length > 0, "No players");
        uint index = getRandom() % players.length;
        winner = players[index];
        payable(winner).transfer(address(this).balance);
        delete players;
    }

    function getPlayers() public view returns (address[] memory) {
        return players;
    }
}