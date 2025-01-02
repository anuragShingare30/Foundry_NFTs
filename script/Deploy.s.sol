// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import {Script} from "lib/forge-std/src/Script.sol";
import {BasicNFTs} from "src/BasicNFTs.sol";

contract DeployNFTs is Script{

    function run() public returns(BasicNFTs){
        vm.startBroadcast();
        BasicNFTs basicNFTs = new BasicNFTs();
        vm.stopBroadcast();

        return basicNFTs;
    }
}