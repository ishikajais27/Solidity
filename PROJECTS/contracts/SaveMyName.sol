// Imagine creating a basic profile. You'll make a contract where users can save their name (like 'Alice') and a short bio (like 'I build dApps').
//  You'll learn how to store text (using `string`) on the blockchain. Then, you'll create functions to let users save and retrieve this information.
//   This demonstrates how to store and retrieve data on the blockchain, essential for building profiles or user data storage.
// # Concepts You'll Master
// 1. State variables (string, bool)
// 2. Storage and retrieval

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;
contract SaveMyName{
   string public name;
string public bio;

  function  saveData(string memory n,string memory b) public{
      name = n;
       bio = b;

    }
    function getData() public view returns(string memory,string memory){
      return (name,bio);
    }
}