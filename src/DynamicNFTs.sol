// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import {ERC721} from "lib/openzeppelin-contracts/contracts/token/ERC721/ERC721.sol";
import {Ownable} from "lib/openzeppelin-contracts/contracts/access/Ownable.sol";
import {Base64} from "lib/openzeppelin-contracts/contracts/utils/Base64.sol";

contract DynamicNFTs is ERC721, Ownable {
    // errors
    error DynamicNFTs_YouAreNotOwnerOfThisNFT();

    // type declaration
    enum NFTState {
        Happy,
        Bad
    }

    mapping(uint => NFTState) public s_NFTState;

    // state varaibles
    uint256 private s_tokenId;
    // data:image/svg+xml;base64,URI
    string private s_HappyMonkeyImageURI;
    string private s_BadMonkeyImageURI;

    // events
    event DynamicNFTs_NFTCreated(uint256 tokenId);

    // functions
    constructor(
        string memory happyMonkeyImageUri,
        string memory badMonkeyImageUri
    ) ERC721("DynamicMonkeys", "DMNK") Ownable(msg.sender) {
        s_tokenId = 0;
        s_HappyMonkeyImageURI = happyMonkeyImageUri;
        s_BadMonkeyImageURI = badMonkeyImageUri;
    }

    function mintDynamicNft() public {
        uint256 tokenId = s_tokenId; 
        _safeMint(msg.sender, tokenId);
        s_tokenId++; 
        emit DynamicNFTs_NFTCreated(tokenId);
    }

    function DynamicallyFlipNFT(uint256 _tokenId) public onlyOwner {
        if (s_NFTState[_tokenId] == NFTState.Happy) {
            s_NFTState[_tokenId] = NFTState.Bad;
        } else {
            s_NFTState[_tokenId] = NFTState.Happy;
        }
    }

    function _baseURI() internal view override returns (string memory) {
        return "data:application/json:base64,";
    }

    function DynaminTokenURI(
        uint256 _tokenId
    ) public view returns (string memory) {
        // if (ownerOf(_tokenId) != msg.sender) {
        //     revert DynamicNFTs_YouAreNotOwnerOfThisNFT();
        // }
        string memory s_name = name();
        string memory s_baseuri = _baseURI();
        string memory s_imageuri;

        if (s_NFTState[_tokenId] == NFTState.Bad) {
            s_imageuri = s_BadMonkeyImageURI;
        } else {
            s_imageuri = s_HappyMonkeyImageURI;
        }

        // Create the JSON string dynamically
        string memory tokenMetadata = string(
            abi.encodePacked(
                _baseURI(),
                Base64.encode(
                    bytes(
                        abi.encodePacked(
                            "{",
                            '"name":"',
                            s_name,
                            '",',
                            '"description":"NFTs collection of moodies monkeys!",',
                            '"image":"',
                            s_imageuri,
                            '",',
                            '"attributes":[{',
                            '"trait_type":"mood",',
                            '"value":"moodies"',
                            "}]",
                            "}"
                        )
                    )
                )
            )
        );

        return tokenMetadata;
    }
}
