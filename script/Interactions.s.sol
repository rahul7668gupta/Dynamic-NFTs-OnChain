// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {DeployBasicNft} from "../script/DeployBasicNft.s.sol";
import {BasicNft} from "../src/BasicNft.sol";
import {Script} from "forge-std/Script.sol";
import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";

contract MintBasicNft is Script {
    BasicNft basicNft;
    string public constant PUG_URI =
        "ipfs://bafybeig37ioir76s7mg5oobetncojcm3c3hxasyd4rvid4jqhy4gkaheg4/?filename=0-PUG.json";

    function run() external {
        address lastBasicNftDeployed = DevOpsTools.get_most_recent_deployment("BasicNft", block.chainid);
        basicNft = BasicNft(lastBasicNftDeployed);
        mintNft();
    }

    function mintNft() public {
        vm.startBroadcast();
        basicNft.mintNft(PUG_URI);
        vm.stopBroadcast();
    }
}
