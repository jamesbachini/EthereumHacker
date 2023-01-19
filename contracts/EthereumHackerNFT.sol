// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Base64.sol";

contract EthereumHackerNFT is ERC721 {
    uint256 public tokenId;

    constructor() ERC721("EthereumHacker", "EH") {
    }

    function tokenURI(uint256) override public pure returns (string memory) {
        string memory json = Base64.encode(bytes(string(abi.encodePacked('{"name": "EthereumHacker", "description": "Thank you for playing, gg", "image": "https://ethereumhacker.com/img/nft.png"}'))));
        return string(abi.encodePacked('data:application/json;base64,', json));
    }

    function mint() public {
        require(tokenId < 1000, "All 1000 tokens have been minted");
        require(balanceOf(msg.sender) == 0, "You already have an NFT");
        _safeMint(msg.sender, tokenId);
        tokenId = tokenId + 1;
    }
}