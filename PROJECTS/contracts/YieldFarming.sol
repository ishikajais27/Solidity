// Build a system for earning rewards by staking tokens. You'll learn how to distribute rewards, demonstrating yield farming. It's like a digital savings
//  account with interest, showing how to create yield farming platforms.

// # Concepts you will master
// 1. Yield farming
// 2. staking
// 3. reward distribution


```solidity
// Simple Yield Farming (Staking and Rewards)

// # Concepts you will master
// 1. Yield farming
// 2. Staking
// 3. Reward distribution

pragma solidity ^0.8.0;

contract YieldFarm {
    struct Staker {
        uint amount;
        uint rewardDebt;
        uint lastStakeTime;
    }

    mapping(address => Staker) public stakers;
    uint public rewardRate = 10; // 10% annual reward
    uint public totalStaked;
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    function stake() public payable {
        require(msg.value > 0, "Need to stake something");
        Staker storage s = stakers[msg.sender];
        if (s.amount > 0) {
            uint pending = calculateReward(msg.sender);
            s.rewardDebt += pending;
        }
        s.amount += msg.value;
        s.lastStakeTime = block.timestamp;
        totalStaked += msg.value;
    }

    function calculateReward(address _user) public view returns (uint) {
        Staker memory s = stakers[_user];
        if (s.amount == 0) return 0;
        uint timePassed = (block.timestamp - s.lastStakeTime);
        uint reward = (s.amount * rewardRate * timePassed) / (100 * 365 days);
        return reward + s.rewardDebt;
    }

    function claimReward() public {
        Staker storage s = stakers[msg.sender];
        uint reward = calculateReward(msg.sender);
        require(reward > 0, "No reward");
        s.lastStakeTime = block.timestamp;
        s.rewardDebt = 0;
        payable(msg.sender).transfer(reward);
    }

    function withdraw(uint _amount) public {
        Staker storage s = stakers[msg.sender];
        require(s.amount >= _amount, "Not enough staked");
        uint reward = calculateReward(msg.sender);
        s.amount -= _amount;
        totalStaked -= _amount;
        s.lastStakeTime = block.timestamp;
        s.rewardDebt = 0;
        payable(msg.sender).transfer(_amount + reward);
    }

    function getUserData(address _user) public view returns (uint, uint, uint) {
        Staker memory s = stakers[_user];
        return (s.amount, calculateReward(_user), s.lastStakeTime);
    }

    function setRewardRate(uint _rate) public {
        require(msg.sender == owner, "Only owner");
        rewardRate = _rate;
    }
}
```
