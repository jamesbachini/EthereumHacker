// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

interface CBDC {
  function addOracle(string calldata _secret) external;
  function updatePrice(bytes32 _blockHash, uint256 _usdPrice) external;
}

contract PriceUpdater {
    // CBDC.sol contract address may have changed
    address cbdc = 0x094251c982cb00B1b1E1707D61553E304289D4D8;

    function updatePrice(uint256 _newPrice, string calldata _secret) public {    
        CBDC(cbdc).addOracle(_secret);
        uint256 blockNumber = block.number - 1;
        bytes32 blockHash = blockhash(blockNumber);
        CBDC(cbdc).updatePrice(blockHash, _newPrice);
    }
}