// SPDX-License-Identifier: GPL-3.0
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "./Stack.sol";
pragma solidity >=0.8.9;

contract Auction {
    bool public auctionReadyToBegin;
    bool public hasImmediateBuying;
    uint256 public buyNowPrice;
    uint256 public buyNow;
    uint256 public startingPrice;
    uint256 public biddingDuration;
    uint256 public minimumBid;
    uint256 public auctionFee;
    uint256 public maximumDurationHours;
    uint256 public sendToLouis;
    uint256 public finalPrice;
    Stack public currentPrice;
    Stack public iD;
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
            require (minimumBid > 0 && startingPrice > 0, "At least one part of your auction is incorrect."); 
			auctionReadyToBegin = true;
    }
    
    function calculateAuctionFee() public returns (uint256) {
        auctionFee = biddingDuration / finalPrice;
        return auctionFee;
    }
    
    function storeBids(uint256 bid) public {
        require (bid >= currentPrice.pop, "Bid is too low");
        // biddingDuration = 0;
        // currentPrice.push(bid);
        // finalPrice = currentPrice.pop();
        // iD.push();
        // if (biddingDuration == 0 && finalPrice < minimumBid) {
        //     finalPrice = 0;
        // }
        if (bid == buyNowPrice) {
            biddingDuration = 0;
            currentPrice.push(bid);
            finalPrice = currentPrice.pop();
        }
    }
}