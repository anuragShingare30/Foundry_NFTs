// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import {ERC721} from "lib/openzeppelin-contracts/contracts/token/ERC721/ERC721.sol";
import {Ownable} from "lib/openzeppelin-contracts/contracts/access/Ownable.sol";

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
