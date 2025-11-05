// Build a secure system for holding funds until conditions are met. You'll learn how to manage payments and handle disputes. It's like a digital middleman
//  for secure transactions, demonstrating secure conditional payments.

// # Concepts you will master
// 1. Escrow service
// 2. conditional payments
// 3. dispute resolution

contract Escrow {
    address public buyer;
    address public seller;
    address public arbiter;
    uint public amount;
    bool public buyerApproved;
    bool public sellerApproved;
    bool public disputed;

    constructor(address _seller, address _arbiter) payable {
        buyer = msg.sender;
        seller = _seller;
        arbiter = _arbiter;
        amount = msg.value;
    }

    function approveRelease() public {
        require(msg.sender == buyer || msg.sender == seller, "Not authorized");
        if (msg.sender == buyer) buyerApproved = true;
        if (msg.sender == seller) sellerApproved = true;
        if (buyerApproved && sellerApproved) releaseFunds();
    }

    function raiseDispute() public {
        require(msg.sender == buyer || msg.sender == seller, "Not allowed");
        disputed = true;
    }

    function resolveDispute(address _winner) public {
        require(msg.sender == arbiter, "Only arbiter");
        require(disputed, "No dispute raised");
        payable(_winner).transfer(address(this).balance);
        disputed = false;
    }

    function releaseFunds() internal {
        require(!disputed, "Dispute active");
        payable(seller).transfer(address(this).balance);
    }

    function getDetails() public view returns (address, address, uint, bool) {
        return (buyer, seller, amount, disputed);
    }
}