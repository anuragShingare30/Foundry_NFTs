// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import {Test,console} from "lib/forge-std/src/Test.sol";
import {DynamicNFTs} from "src/DynamicNFTs.sol";
import {DeployDynamicNfts} from "script/DeployDynamicNft.s.sol";


contract DynamicNFTIntegration is Test{
    DeployDynamicNfts public deployDynamicNfts;
    DynamicNFTs public dynamicNfts;

    string public SVG = vm.readFile("img/test.svg");


    function setUp() public {
        deployDynamicNfts = new DeployDynamicNfts();
        dynamicNfts = deployDynamicNfts.run();
        vm.deal(msg.sender, 1000 ether);
    }

    // test the vm.readFile(path) cheatcodes
    function test_CheckVmReadFile() public {
        console.log(SVG);
    }

    // testing the deploy function that converts the svg to imageuri
    function test_CheckSVGToImageUri() public {
        string memory imageUri = deployDynamicNfts.svgToImageUri(SVG);
        console.log(imageUri);
    }

    // test the minting function
    function test_MintDynamicNFT() public {
        vm.prank(msg.sender);
        dynamicNfts.mintDynamicNft();
        console.log(dynamicNfts.DynaminTokenURI(0));
    }
    
    // test the flipNFT function 
    function test_FlipDynamicNft() public {
        vm.prank(msg.sender);
        dynamicNfts.mintDynamicNft();
        assert(dynamicNfts.getNFTState(0) == DynamicNFTs.NFTState.Happy);

        vm.prank(msg.sender);
        dynamicNfts.DynamicallyFlipNFT(0);
        assert(dynamicNfts.getNFTState(0) == DynamicNFTs.NFTState.Bad);
    }


}