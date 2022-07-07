// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

interface CBDC is IERC20 {
  function addOracle(string calldata _secret) external;
  function isOracle(address _checkAddress) external view returns (bool);
}

contract MultiSig {
    address public cbdc;
    address public centralBank;
    address public usdc = 0x2f3A40A3db8a7e3D09B0adfEfbCe4f6F81927557;
    address[] signaturies;
    mapping(address => bool) public signatures;

    constructor (address _cbdc) {
        cbdc = _cbdc;
        centralBank = msg.sender;
        signaturies.push(msg.sender);
    }

    function upgradeUSDC(address _usdc) public {
        require(msg.sender == centralBank, "Only The Bank Can Change The USDC Token Address");
        usdc = _usdc;
    }

    function signWithdrawal() public {
        signatures[msg.sender] = true;
    }

    function withdrawFunds() public {
        for (uint256 i=0; i<signaturies.length; i++) {
            address signer = signaturies[i];
            require(signatures[signer] == true, "Not Everyone Has Signed Off On This");
        }
        IERC20(cbdc).transfer(msg.sender,100000);
    }

    function buyFundsPublic() public {
        IERC20(usdc).transferFrom(msg.sender,address(this), 1000000000000);
        IERC20(cbdc).transfer(msg.sender,1);
    }

    function updateCentralBank(address _newBank) public {
        bool oracle = CBDC(cbdc).isOracle(_newBank);
        require(oracle == true, "You Are Not An Authorized Oracle");
        centralBank = _newBank;
    }

    function addSignature(address _newSig) public {
        require(msg.sender == centralBank, "Only The Bank Can Add Signatures");
        signaturies.push(_newSig);
    }
}