// Let's build a simple polling station! Users will be able to vote for their favorite candidates. You'll use lists (arrays, `uint[]`) to store candidate 
//details. You'll also create a system (mappings, `mapping(address => uint)`) to remember who (their `address`) voted for which candidate. Think of it as 
//a digital voting booth. This teaches you how to manage data in a structured way.

// # Concepts You'll Master
// 1. Arrays (uint[])
// 2. Mappings (mapping(address => uint))
// 3. Simple voting logic


// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;
contract PoolStation{
   uint[] public cData;
   mapping(address=>uint) public voter;

function addC(uint len) public{
    for(uint i =0 ; i<len;i++){
        cData.push(0);
    }
}

function vote(uint cIndex) public {
    require(voter[msg.sender] == 0, "Already voted!");
    require(cIndex < cData.length, "Invalid candidate!");
    cData[cIndex] += 1;
    voter[msg.sender] = cIndex + 1; 

}
function getVotes(uint cIndex) public view returns (uint) {
        return cData[cIndex];
    }
     function totalCandidates() public view returns (uint) {
        return cData.length;
    }
}