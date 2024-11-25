This Solidity smart contract implements a basic NFT marketplace. It allows users to list their NFTs for sale, buy listed NFTs, and unlist NFTs.

Key Features:

Listing NFTs: Users can list their NFTs for sale by specifying the NFT contract address, token ID, and desired price.
Buying NFTs: Users can purchase listed NFTs by sending the required amount of Ether to the smart contract.
Unlisting NFTs: Sellers can remove their NFTs from the marketplace.
How it Works:

Listing an NFT:

The user calls the ListNFT function, providing the NFT contract address, token ID, and desired price.
The contract verifies ownership of the NFT and stores the listing details.
An NFTListed event is emitted to log the listing.
Buying an NFT:

The user calls the buyNFT function, providing the NFT contract address and token ID.
The contract verifies the listing and ensures the buyer has sent enough Ether.
The NFT is transferred from the seller to the buyer using the NFT contract's transferFrom function.
The seller receives the payment.
An NFTBought event is emitted to log the purchase.
Unlisting an NFT:

The seller calls the unlistNFT function, providing the NFT contract address and token ID.
The contract verifies that the caller is the original seller.
The listing is removed from the marketplace.
An NFTUnlisted event is emitted to log the unlisting.
