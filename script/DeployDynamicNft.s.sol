// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import {Script} from "lib/forge-std/src/Script.sol";
import {DynamicNFTs} from "src/DynamicNFTs.sol";
import {Base64} from "lib/openzeppelin-contracts/contracts/utils/Base64.sol";

/**
    * This is the deploy script for our DynamicNFTs contract
    * We have deploy our contract on anvil chain using
        a. anvil private key
        b. anvil default account
*/

contract DeployDynamicNfts is Script{

    string public s_happyImageUri = vm.readFile("img/happy.svg");
    string public s_badImageUri = vm.readFile("img/bad.svg");
    uint256 public constant ANVIL_PRIVATE_KEY=0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80;

    function run() public returns(DynamicNFTs){
        vm.startBroadcast(ANVIL_PRIVATE_KEY);
        DynamicNFTs dynamicNfts = new DynamicNFTs(svgToImageUri(s_happyImageUri),svgToImageUri(s_badImageUri));
        vm.stopBroadcast();

        return dynamicNfts;
    }

    function svgToImageUri(string memory svg) public view returns(string memory){
        string memory baseUri = "data:image/svg+xml;base64,";
        string memory svgToBase64Encoded = Base64.encode(bytes(string(abi.encodePacked(svg))));

        return string(abi.encodePacked(baseUri,svgToBase64Encoded));
    }
     
}