// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract GalaNFT is ERC721 {
    uint256 public _tokenId = 0;
    uint256 public _maxSupply = 100;

    constructor() ERC721("GalaNFT", "GALANFT") {
        do {
            mint(msg.sender);
        }
        while (_tokenId < _maxSupply); 
    }

    function mint(address _to) public {
        require (_tokenId <= _maxSupply,"You need to increase the maximum supply");
        _mint(_to, _tokenId);
        _tokenId += 1;
    }

    function increaseMaxSupply() public {
        _maxSupply += 1;
    }
}