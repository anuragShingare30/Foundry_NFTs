// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import {Script} from "lib/forge-std/src/Script.sol";
import {BasicNFTs} from "src/BasicNFTs.sol";

contract DeployBasicNFTs is Script{

    uint256 public constant ANVIL_PRIVATE_KEY=0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80;

    function run() public returns(BasicNFTs){
        vm.startBroadcast(ANVIL_PRIVATE_KEY);
        BasicNFTs basicNFTs = new BasicNFTs();
        vm.stopBroadcast();

        return basicNFTs;
    }
}