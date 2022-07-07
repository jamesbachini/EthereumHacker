// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract CBDC is ERC20 {
    uint256 public initialSupply = 1000000000000 ether; // 1 trillion & 18 decimals
    uint256 public inflation = 100000000 ether;
    address public centralBank;
    uint256 public usdPrice = 100000;
    mapping(address => bool) public oracles;

    constructor() ERC20("Central Bank Digital Currency", "CBDC") {
      _mint(msg.sender, initialSupply);
      centralBank = msg.sender;
    }

    function addOracle(string calldata _secret) public {
        // https://twitter.com/CentralBankDigi
        bytes32 answer = 0x70b00831d459e9f2e4b22b203fbdfd5d1830d5c16a36579bcbb12f91de2159e9;
        bytes32 yourAnswer = keccak256(abi.encode(_secret));
        require(yourAnswer == answer, "You Will Never Break In");
        oracles[msg.sender] = true;
    }

    function testAnswer(string calldata _secret) public pure returns (bytes32) {
        bytes32 yourAnswer = keccak256(abi.encode(_secret));
        return yourAnswer;
    }

    function isOracle(address _checkAddress) public view returns (bool) {
        return oracles[_checkAddress];
    }

    function printMoney() public {
        require(oracles[msg.sender] == true, "Only The Elite Can Print Money");
        _mint(centralBank, inflation);
    }

    function updatePrice(bytes32 _blockHash, uint256 _usdPrice) public {
        require(oracles[msg.sender] == true, "Only The Elite Can Manipulate Markets");
        uint256 blockNumber = block.number - 1;
        bytes32 blockHash = blockhash(blockNumber);
        require(blockHash == _blockHash, "Only Smart Contracts Can Manipulate Markets");
        usdPrice = _usdPrice;
    }

}