// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import {ERC721} from "lib/openzeppelin-contracts/contracts/token/ERC721/ERC721.sol";
import {Ownable} from "lib/openzeppelin-contracts/contracts/access/Ownable.sol";


/**
 * @title Developing Basic NFTs collection using smart contract
 * @author anurag shingare
 * @notice This smart contract deploy a Basic NFT on sepolia/anvil using smart contract by providing the tokenURI(NFT metadata)
 * @dev This smart contract includes:
        a. This Creates the NFTs collection on wallet!
        b. Using `mintNft` function you can mint the NFT by providing the tokenURI
        c. `tokenURI` function retuurns the tokenURI of specified token id.
        d. On, calling `mintNft()` your NFT will be deployed and will visible on your Metamask wallet / sepolia opensea.
        e. Provide the deployed contract address and token id.
 */



contract BasicNFTs is ERC721, Ownable {
    // errors

    // type declaration
    mapping(uint256 => string) private s_tokenIdToURI;

    // state varaibles
    uint256 private s_tokenId; 

    // functions
    constructor() 
        ERC721("Monkey", "MNK") 
        Ownable(msg.sender) 
    {
        s_tokenId = 0;
    }

    function mintNft(string memory _tokenUri) public {
        s_tokenIdToURI[s_tokenId] = _tokenUri;
        _safeMint(msg.sender, s_tokenId);
        s_tokenId++;
    }

    function tokenURI(uint256 _tokenId) public view override returns(string memory){
        return s_tokenIdToURI[_tokenId];
    }
    
}
