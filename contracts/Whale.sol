// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/IERC721.sol";

contract Whale {
    function checkOwner() public view returns (address) {
        return IERC721(0x484Ec30Feff505b545Ed7b905bc25a6a40589181).ownerOf(45);
    }
}