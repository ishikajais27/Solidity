// Let's build a simple counter! Imagine a digital clicker. You'll create a 'function' named `click()`. Each time someone calls this function,
// a number stored in the contract (a 'variable') will increase by one. You'll learn how to declare a variable to hold a number (an `uint`) 
//and create functions to change it (increment/decrement). This is the very first step in making interactive smart contracts, showing how to store and modify data.
// # Concepts you will master
// 1. Basic Solidity syntax
// 2. Variables (uint)
// 3. Increment/Decrement functions

// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

contract Counter{
   event LogMessage(string msg ,uint256 counter);
 uint256 public count = 0;
 function Incre() public returns(uint256) {
  count+=1;
  emit LogMessage("Incremented",count);
  return count;
 } 
 function Decr()public returns(uint256){
  count-=1;
  emit LogMessage("Decremented",count);
  return count;
 }
 
}