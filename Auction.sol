// SPDX-License-Identifier: GPL-3.0
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "./Stack.sol";
pragma solidity >=0.8.9;

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
    Stack private currentPrice;
    Stack private iD;
    address payable public seller;
    uint256 public nftId;
    IERC721 public nft;
     
    constructor() {
        seller = payable(msg.sender);
    }
    
    modifier validAddress(address _addr) {
        require(_addr != address(0), "Not valid address");
        _;
    }
    
    function setUpAuction (uint256 time, uint256 minBid, bool hasBuyNow, uint256 buyNow, address theNft, uint256 nftID) public validAddress(seller) isSeller(seller) {
        require (startingPrice >0, "Auction must be longer");
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
            require (biddingDuration <= 48 && minimumBid > 0 && startingPrice > 0, "At least one part of your auction is incorrect."); 
			auctionReadyToBegin = true;
    }
    
    function calculateAuctionFee() public returns (uint256) {
        auctionFee = biddingDuration / finalPrice;
        return auctionFee;
    }
    
    function storeBids(uint256 bid) public {
        require (bid >= currentPrice.pop, "Bid is too low");
        biddingDuration = 0;
        currentPrice.push(bid);
        finalPrice = currentPrice.pop();
        iD.push("Username: " + creator.getUsername() + "\n User ID: " + creator.getUserID());
        if (biddingDuration == 0 && finalPrice < minimumBid) {
            finalPrice = 0;
        }
    }
}