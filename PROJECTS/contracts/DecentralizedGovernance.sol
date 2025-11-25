// Build a system for voting on proposals. You'll learn how to create a digital organization where members can vote, demonstrating decentralized governance.
//  It's like a digital democracy, showing how to create DAOs.

// # Concepts you will master
// 1. DAO structure
// 2. voting
// 3. token-based governance


contract DecentralizedGovernance {
    struct Proposal {
        uint id;
        string description;
        uint votesFor;
        uint votesAgainst;
        uint endTime;
        bool executed;
    }

    mapping(uint => Proposal) public proposals;
    mapping(address => uint) public tokens;
    mapping(uint => mapping(address => bool)) public hasVoted;

    uint public nextProposalId;
    address public owner;

    constructor() {
        owner = msg.sender;
        tokens[owner] = 1000;
    }

    modifier onlyTokenHolders() {
        require(tokens[msg.sender] > 0, "No tokens to vote");
        _;
    }

    function mintTokens(address _to, uint _amount) public {
        require(msg.sender == owner, "Only owner");
        tokens[_to] += _amount;
    }

    function createProposal(string memory _desc, uint _duration) public onlyTokenHolders {
        proposals[nextProposalId] = Proposal(
            nextProposalId,
            _desc,
            0,
            0,
            block.timestamp + _duration,
            false
        );
        nextProposalId++;
    }

    function vote(uint _id, bool _support) public onlyTokenHolders {
        Proposal storage p = proposals[_id];
        require(block.timestamp < p.endTime, "Voting ended");
        require(!hasVoted[_id][msg.sender], "Already voted");

        hasVoted[_id][msg.sender] = true;
        if (_support) {
            p.votesFor += tokens[msg.sender];
        } else {
            p.votesAgainst += tokens[msg.sender];
        }
    }

    function executeProposal(uint _id) public {
        Proposal storage p = proposals[_id];
        require(block.timestamp >= p.endTime, "Voting not ended");
        require(!p.executed, "Already executed");

        if (p.votesFor > p.votesAgainst) {
          
            p.executed = true;
        } else {
         
            p.executed = true;
        }
    }

    function getProposal(uint _id)
        public
        view
        returns (string memory, uint, uint, bool)
    {
        Proposal memory p = proposals[_id];
        return (p.description, p.votesFor, p.votesAgainst, p.executed);
    }
}
```
