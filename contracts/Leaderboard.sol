// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract Leaderboard {
    string[] public leaderboard;
    mapping(address => uint256) public position;
    address public cbdc;

    constructor (address _cbdc) {
        cbdc = _cbdc;
    }

    function graduate(string calldata _yourName, string memory _secret) public {
        uint256 balance = IERC20(cbdc).balanceOf(msg.sender);
        require (balance > 0, "You Need To Complete Level 5 First");
        bool isCorrect = false;
        assembly {
            mstore(0x80, 0x636f6e67726174756c6174696f6e730000000000000000000000000000000000)
            let secret := mload(0x80)
            let yourAnswer := mload(add(_secret, 32))
            if eq(yourAnswer, secret) {
                isCorrect := true
            }
        }
        require(isCorrect == true, "Your Secret Code Is Not Correct");
        require(position[msg.sender] == 0, "You Are Already In The Leaderboard");
        position[msg.sender] = leaderboard.length;
        leaderboard.push(_yourName);
    }

    function leaderboardLength() public view returns (uint256) {
        return leaderboard.length;
    }

    function connectWithMe() public pure returns (string memory) {
        bytes32 findMeHere = 0x747769747465722e636f6d2f6a616d65735f62616368696e6900000000000000;
        bytes memory bytesArray = new bytes(32);
        for (uint256 i; i < 32; i++) bytesArray[i] = findMeHere[i];
        return string(bytesArray);
    }
}