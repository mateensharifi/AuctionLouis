// SPDX-License-Identifier: GPL-3.0
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
pragma solidity >=0.8.9;

contract Auction {
    bool public auctionReadyToBegin;
    bool public hasImmediateBuying;
    uint256 public buyNowPrice;
    uint256 public buyNow;
    uint256 public biddingDuration;
    uint256 public minimumBid;
    uint256 public auctionFee;
    uint256 public maximumDurationHours;
    uint256 public finalPrice = 0;
    uint256 public currentPrice = 0;
    address payable public seller;
    address public topBidder = address(0);
    uint256 public nftId;
    IERC721 public nft;
    
    event Win(address winner, uint256 price);
     
    constructor() {
        seller = payable(msg.sender);
    }
    
    modifier validAddress(address _addr) {
        require(_addr != address(0), "Not valid address");
        _;
    }
    
    function setUpAuction (uint256 time, uint256 minBid, bool hasBuyNow, uint256 buyNow, address theNft, uint256 nftID) external validAddress(seller) isSeller(seller)  {
        require (minBid > 0, "Auction must be longer");
        biddingDuration = time;
		minimumBid = minBid;
		hasImmediateBuying = hasBuyNow;
		buyNowPrice = buyNow;
		nft = IERC721(theNft);
		nftId = nftID;
    }
    
    modifier isSeller(address _addr) {
        require (_addr==seller);
        _;
    }
    
    function prepareAuction() public validAddress(seller) {
            require (minimumBid > 0 && minimumBid > 0, "At least one part of your auction is incorrect."); 
			auctionReadyToBegin = true;
    }
    
    function calculateAuctionFee() public returns (uint256) {
        auctionFee = biddingDuration / finalPrice;
        return auctionFee;
    }
    
    function storeBids(uint256 bid) public {
        require (bid >= currentPrice, "Bid is too low");
        if (bid == buyNowPrice) {
            biddingDuration = 0;
            currentPrice = bid;
            finalPrice = bid;
        }
        else {
            currentPrice = bid;
        }
        topBidder = msg.sender;
    }
    
    function win() external {
        if (topBidder != address(0)) {
            nft.transferFrom(address(this), topBidder, nftId);
        } 
        emit Win(topBidder, currentPrice);
    }
    
    
}