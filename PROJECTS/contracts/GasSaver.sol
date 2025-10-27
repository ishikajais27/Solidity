// Build a simple voting system where users can vote on proposals. Your challenge is to make it as gas-efficient as possible. Optimize how you store voter 
// data, handle input parameters, and design functions. You'll learn how `calldata`, `memory`, and `storage` affect gas usage and discover small changes that
//  lead to big savings. It's like designing a voting machine that runs faster and cheaper without losing accuracy.

// # Concepts you will master
// 1. Gas optimization
// 2. Efficient data locations
// 3. Calldata vs memory
// 4. Minimizing storage writes


contract GasSaverVoteSystem{
   struct Proposal{
    string name;
    address id;
    uint totalVote; 
}

    mapping(address=>bool)user;
 Proposal[] public proposals;

function VotingSystem(uint proposalIndex) external{
    require(user[msg.sender]!=false,"User can only vote ones");
    proposals[proposalIndex].totalVote += 1;
   user[msg.sender] = true;

}
}