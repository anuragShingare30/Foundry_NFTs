// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import {Test,console} from "lib/forge-std/src/Test.sol";
import {DynamicNFTs} from "src/DynamicNFTs.sol";

contract DynamicNFTtest is Test{
    DynamicNFTs dynamicNft;

    function setUp() public {
        dynamicNft = new DynamicNFTs("HAPPY_MONKEY","BAD_MONKEY");
        vm.deal(msg.sender, 1000 ether);
    }

    function test_GetTokenUri() public {
        vm.prank(msg.sender);
        dynamicNft.mintDynamicNft();
        console.log(dynamicNft.DynaminTokenURI(0));
    }
}