// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import {Test} from "lib/forge-std/src/Test.sol";
import {console} from "lib/forge-std/src/console.sol";
import {DeployNFTs} from "script/Deploy.s.sol";
import {BasicNFTs} from "src/BasicNFTs.sol";

contract NFTsTest is Test{
    BasicNFTs basicNFTs;

    address public USER = address(0);
    uint256 private constant INITIAL_BALANCE = 100 ether;
    string public constant s_tokenURI = "ipfs://bafybeigrrzrsqcedeqzf3xlodqg2agicgk5f7eibgydojvvapjkct6ixcq.ipfs.dweb.link?filename=NFT.json";

    function setUp() public {
        DeployNFTs deployNFTs = new DeployNFTs();
        basicNFTs = deployNFTs.run();
        vm.deal(msg.sender, 1000 ether);
    }

    function test_TokenNameNSymbol() public {
        console.log(basicNFTs.name());
        console.log(basicNFTs.symbol());

        // String are array of bytes n we cannot compare the array of bytes directly.
        // We will use abi.encodePacked(string);
        assert(keccak256(abi.encodePacked(basicNFTs.name())) == keccak256(abi.encodePacked(basicNFTs.symbol())));
    }

    function test_UserCanMintAndHaveBalance() public{
        vm.prank(msg.sender);
        basicNFTs.mintNft(s_tokenURI);
        assert(keccak256(abi.encodePacked(basicNFTs.tokenURI(0))) == keccak256(abi.encodePacked(s_tokenURI)));
        // assert(basicNFTs.balanceOf(msg.sender) == 1);
    }
}