// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

contract MoodNft is ERC721 {
    enum Mood {
        HAPPY,
        SAD
    }

    uint256 public s_tokenIdCounter;
    string public s_happyImageUri;
    string public s_sadImageUri;
    mapping(uint256 => Mood) userMood;

    constructor(string memory happyImageUri, string memory sadImageUri) ERC721("MoodNft", "MOOD") {
        s_happyImageUri = happyImageUri;
        s_sadImageUri = sadImageUri;
    }

    function _baseURI() internal pure override returns (string memory) {
        return "data:application/json;base64,";
    }

    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        string memory imageURI;
        if (userMood[tokenId] == Mood.HAPPY) {
            imageURI = s_happyImageUri;
        } else {
            imageURI = s_sadImageUri;
        }
        return string(
            abi.encodePacked(
                _baseURI(),
                Base64.encode(
                    abi.encodePacked(
                        '{"name":"',
                        name(), // You can add whatever name here
                        '", "description":"An NFT that reflects the mood of the owner, 100% on Chain!", ',
                        '"attributes": [{"trait_type": "moodiness", "value": 100}], "image":"',
                        imageURI,
                        '"}'
                    )
                )
            )
        );
    }

    function mintNft() public {
        // increment token id counter
        s_tokenIdCounter++;
        // safe mint
        _mint(msg.sender, s_tokenIdCounter);
    }

    function flipMood(uint256 tokenId) external {
        // only owner of token id should be able to change mood
        // Fetch the owner of the token
        address owner = ownerOf(tokenId);
        // Only want the owner of NFT to change the mood.
        _checkAuthorized(owner, msg.sender, tokenId);
        // flip mood
        if (userMood[tokenId] == Mood.HAPPY) {
            userMood[tokenId] = Mood.SAD;
        } else {
            userMood[tokenId] = Mood.HAPPY;
        }
    }
}
