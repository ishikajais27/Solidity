// Build a smart bank that offers different types of deposit boxes — basic, premium, time-locked, etc. Each box follows a common interface and supports
// ownership transfer. A central VaultManager contract interacts with all deposit boxes in a unified way, letting users store secrets and transfer ownership
// like handing over the key to a digital locker. This teaches interface design, modularity, and how contracts communicate with each other safely.

// # Concepts you will master
// 1. Interfaces
// 2. Abstraction
// 3. Ownership Transfer
// 4. Contract-to-contract interaction

interface DepositTypes {
    function basicDeposit() external payable;
    function premiumDeposits() external payable;
    function timeLockedDeposits() external payable;
}

contract Deposits is DepositTypes {
    mapping(address => uint) public balances;
    uint public constant min = 0.1 ether; 

    struct TimeLockedDeposit {
        uint amount;
        uint unlockTime;
    }

    mapping(address => TimeLockedDeposit) public timeLockedDepositsMapping;
    uint public constant LOCK_DURATION = 1 days;

    event BasicDeposited(address indexed user, uint amount);
    event PremiumDeposited(address indexed user, uint amount);
    event TimeLockedDeposited(address indexed user, uint amount, uint unlockTime);

    function basicDeposit() external payable override {
        require(msg.value > 0, "Must send valid amount");
        balances[msg.sender] += msg.value;
        emit BasicDeposited(msg.sender, msg.value);
    }

    function premiumDeposits() external payable override {
        require(msg.value > min, "Deposit below minimum for premium deposit");
        balances[msg.sender] += msg.value;
        emit PremiumDeposited(msg.sender, msg.value); 
    }

    function timeLockedDeposits() external payable override {
        require(msg.value > 0, "Must send valid amount");
        TimeLockedDeposit storage userDeposit = timeLockedDepositsMapping[msg.sender];
        userDeposit.amount += msg.value;
        userDeposit.unlockTime = block.timestamp + LOCK_DURATION;
        emit TimeLockedDeposited(msg.sender, msg.value, userDeposit.unlockTime);
    }
}

contract VaultManager {
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not Owner");
        _;
    }

    function ownershipTransfer(address newOwner) public onlyOwner {
        owner = newOwner;
    }

    function useDeposits(address depositBoxAddress) external payable onlyOwner {
        Deposits depositBox = Deposits(depositBoxAddress);

       
        depositBox.basicDeposit{value: 1 ether}();
        depositBox.premiumDeposits{value: 2 ether}();
        depositBox.timeLockedDeposits{value: 0.5 ether}();
    }
}
