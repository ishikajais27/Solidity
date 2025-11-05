// Build an upgradeable subscription manager for a SaaS-like dApp. The proxy contract stores user subscription info (like plans, renewals, and expiry dates),
//  while the logic for managing subscriptions—adding plans, upgrading users, pausing accounts—lives in an external logic contract. When it's time to add new 
//  features or fix bugs, you simply deploy a new logic contract and point the proxy to it using `delegatecall`, without migrating any data. This simulates
//   how real-world apps push updates without asking users to reinstall. You'll learn how to architect upgrade-safe contracts using the proxy pattern and 
//   `delegatecall`, separating storage from logic for long-term maintainability.

// # Concepts you will master
// 1. Upgradeable contracts
// 2. proxy pattern
// 3. delegate call for upgrades


//designed to allow developers to modify the logic or functionality of a contract without having to redeploy it. key idea is to separate the contract’s
// state (data) from its logic (code), making it possible to update the logic while preserving the existing data.
//we often use a combination of two contracts: the Proxy contract and the Implementation contract.
//Proxy contract-> When users send transactions to the proxy contract, it forwards those calls to the implementation contract, effectively acting as a bridge.
//Implementation Contract: This contract contains the actual logic of the smart contract. It can be upgraded without changing the proxy contract,  
//proxy runs the implementation contract’s code, but the data (like uint number;) is stored inside the proxy, not the implementation.


pragma solidity ^0.8.0;

contract SubscriptionStorage {
    struct User {
        string plan;
        uint expiry;
        bool paused;
    }

    mapping(address => User) public users;
    address public logicContract;
    address public owner;

    constructor(address _logic) {
        logicContract = _logic;
        owner = msg.sender;
    }

    function updateLogic(address _newLogic) public {
        require(msg.sender == owner, "Not owner");
        logicContract = _newLogic;
    }

    fallback() external payable {
        (bool success, ) = logicContract.delegatecall(msg.data);
        require(success, "Delegatecall failed");
    }
}

contract SubscriptionLogicV1 {
    function subscribe(address _user, string memory _plan, uint _days) public {
        SubscriptionStorage s = SubscriptionStorage(address(this));
        s.users(_user).plan = _plan;
        s.users(_user).expiry = block.timestamp + (_days * 1 days);
        s.users(_user).paused = false;
    }

    function pause(address _user) public {
        SubscriptionStorage s = SubscriptionStorage(address(this));
        s.users(_user).paused = true;
    }

    function resume(address _user) public {
        SubscriptionStorage s = SubscriptionStorage(address(this));
        s.users(_user).paused = false;
    }
}

contract SubscriptionLogicV2 {
    function upgradePlan(address _user, string memory _newPlan, uint _extraDays) public {
        SubscriptionStorage s = SubscriptionStorage(address(this));
        s.users(_user).plan = _newPlan;
        s.users(_user).expiry += _extraDays * 1 days;
    }

    function renew(address _user, uint _days) public {
        SubscriptionStorage s = SubscriptionStorage(address(this));
        s.users(_user).expiry = block.timestamp + (_days * 1 days);
    }
}






