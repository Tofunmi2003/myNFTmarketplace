
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

 
interface IERC721 {
    function transferFrom(address from, address to, uint256 tokenId) external;
    function ownerOf(uint256 tokenId) external view returns (address);
}

 
 contract SimpleNFTMarketplace{
     struct NFTItems{
        uint256 price;
        address sellers;
     }
 
 mapping(address => mapping(uint256 => NFTItems)) public listings;

    event NFTListed(address indexed nftAddress, uint256 indexed tokenId, uint256 price, address seller);
    event NFTBought(address indexed nftAddress, uint256 indexed tokenId, address buyer, uint256 price);
    event NFTUnlisted(address indexed nftAddress, uint256 indexed tokenId, address seller);

 
 
 function ListNFT(address nftAddress, uint256 tokenId, uint256 price) external {
     require(listings[nftAddress][tokenId].price > 0, "Price must be greater than zero"); 
      require(IERC721(nftAddress).ownerOf(tokenId) == msg.sender, "You are not the owner of this NFT");

        listings[nftAddress][tokenId] = NFTItems(price, msg.sender);

        emit NFTListed(nftAddress, tokenId, price, msg.sender);
}

 
 function buyNFT(address nftAddress, uint256 tokenId) external payable {
    NFTItems storage item = listings[nftAddress][tokenId];
    require(item.price > 0, "NFT is not listed for sale");
    require(msg.value >= item.price, "Insufficient payment");

    // Get the seller's address and price
    address seller = item.sellers;
    uint256 price = item.price;

    
    IERC721(nftAddress).transferFrom(seller, msg.sender, tokenId);

    // Transfer funds to the seller
    payable(seller).transfer(price);

    delete listings[nftAddress][tokenId];

    emit NFTBought(nftAddress, tokenId, msg.sender, price);
}
 
 function unlistNFT(address nftAddress, uint256 tokenId) external {
        NFTItems memory listing = listings[nftAddress][tokenId];
        require(listing.sellers == msg.sender, "You are not the seller of this NFT");

        // Remove the listing
        delete listings[nftAddress][tokenId];

        emit NFTUnlisted(nftAddress, tokenId, msg.sender);
    }

    // Function to get details of a listed NFT
    function getListing(address nftAddress, uint256 tokenId) external view returns (NFTItems memory) {
        return listings[nftAddress][tokenId];
    }
}
 
 

 