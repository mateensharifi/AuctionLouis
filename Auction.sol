pragma solidity  >=0.8.9;

contract Auction {
    bool private auctionReadyToBegin;
    bool private hasImmediateBuying;
    uint256 private buyNowPrice;
    uint256 private buyNow;
    uint256 private startingPrice;
    uint256 private biddingDuration;
    uint256 private minimumBid;
    uint256 private auctionFee;
    uint256 private maximumDurationHours;
    uint256 private sendToLouis;
    uint256 private finalPrice;
    address private creator;
    
    constructor() {
        creator = msg.sender;
    }
    
    modifier validAddress(address _addr) {
        require(_addr != address(0), "Not valid address");
        _;
    }
    
    function setUpAuction (uint256 time, uint256 minBid, bool hasBuyNow, uint256 buyNow) public validAddress(creator) isSeller(creator) {
        biddingDuration = time;
		minimumBid = minBid;
		hasImmediateBuying = hasBuyNow;
		buyNowPrice = buyNow;
    }
    
    modifier isSeller(address _addr) {
        require (_addr==creator);
        _;
    }
    
    function prepareAuction() public validAddress(creator) {
        	if (biddingDuration <= 48 && minimumBid > 0 && startingPrice > 0) {
			auctionReadyToBegin = true;
		}
// 		else {
// 			 throw ("At least one part of your auction is incorrect.");
// 		}
		
		
    }
    
}