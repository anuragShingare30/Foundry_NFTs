// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import {Script} from "lib/forge-std/src/Script.sol";
import {BasicNFTs} from "src/BasicNFTs.sol";
import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";


contract MintNFT is Script{
    string public constant tokenUri = "ipfs://bafybeigrrzrsqcedeqzf3xlodqg2agicgk5f7eibgydojvvapjkct6ixcq/?filename=NFT.json";
    uint256 public constant ANVIL_PRIVATE_KEY=0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80;

    function mintNft(address _contractAddress) public {
        vm.startBroadcast(ANVIL_PRIVATE_KEY);
        BasicNFTs(_contractAddress).mintNft(tokenUri);
        vm.stopBroadcast();
    }

    function run() public {
        address contractAddress = DevOpsTools.get_most_recent_deployment("BasicNFTs", block.chainid);
        mintNft(contractAddress);
    }
}   