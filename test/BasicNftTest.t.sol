// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Test} from "forge-std/Test.sol";
import {DeployBasicNft} from "../script/DeployBasicNft.s.sol";
import {BasicNft} from "../src/BasicNft.sol";

contract BasicNftTest is Test {
    BasicNft basicNft;
    string public constant PUG_URI =
        "ipfs://bafybeig37ioir76s7mg5oobetncojcm3c3hxasyd4rvid4jqhy4gkaheg4/?filename=0-PUG.json";
    address User = makeAddr("User");

    function setUp() external {
        DeployBasicNft basicNftDeployer = new DeployBasicNft();
        basicNft = basicNftDeployer.run();
    }

    function testBasicNftNameIsCorrect() external view {
        assert(keccak256(bytes(basicNft.name())) == keccak256(bytes("Dogie")));
    }

    function testBasicNftSymbolIsCorrect() external view {
        assert(keccak256(bytes(basicNft.symbol())) == keccak256(bytes("DOG")));
    }

    function testUserCanMintNft() external {
        vm.prank(User);
        basicNft.mintNft(PUG_URI);
        assert(basicNft.s_tokenIdCounter() == uint256(1));
        assert(basicNft.balanceOf(User) == 1);
        assert(basicNft.ownerOf(1) == User);
        assert(keccak256(bytes(basicNft.tokenURI(1))) == keccak256(bytes(PUG_URI)));
    }
}
