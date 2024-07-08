// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract BasicNft is ERC721 {
    uint256 public s_tokenIdCounter;
    mapping(uint256 => string) s_tokenIdToUri;

    constructor() ERC721("Dogie", "DOG") {}

    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        return s_tokenIdToUri[tokenId];
    }

    function mintNft(string memory tokenUri) public {
        // increment token id counter
        s_tokenIdCounter++;
        // set the token uri
        s_tokenIdToUri[s_tokenIdCounter] = tokenUri;
        // safe mint
        _mint(msg.sender, s_tokenIdCounter);
    }
}
