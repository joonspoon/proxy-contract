// SPDX-License-Identifier: BSD-3-Clause
pragma solidity ^0.8.4;

import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/utils/math/SafeMathUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol";
import '@uniswap/lib/contracts/libraries/TransferHelper.sol';
import '@uniswap/v2-periphery/contracts/interfaces/IUniswapV2Router02.sol';

contract Swap is OwnableUpgradeable {

  address private constant UNISWAP_V2_ROUTER = 0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D;

  function swap(
      address _tokenIn,
      address _tokenOut,
      uint _amountIn,
      uint _amountOutMin,
      address _to ///TODO: Remove since sender will always be the recepient
    ) external {

    TransferHelper.safeTransferFrom(_tokenIn, msg.sender, address(this), _amountIn);
    TransferHelper.safeApprove(_tokenIn, UNISWAP_V2_ROUTER, _amountIn);

    uint feePercentage = 1;  // charge a 1% swap fee
    uint edgeFee = SafeMathUpgradeable.div(SafeMathUpgradeable.mul(_amountIn, feePercentage), 100);

    address[] memory path = new address[](2);
    path[0] = _tokenIn;
    path[1] = _tokenOut;

    IUniswapV2Router02(UNISWAP_V2_ROUTER).swapExactTokensForTokens(
      _amountIn - edgeFee,
      _amountOutMin,
      path,
      _to,
      block.timestamp
    );
  }

  //TODO: restrict to owner
  function withdrawFees(address _token, address _recipient) external {
      ERC20Upgradeable tokenRequested = ERC20Upgradeable(_token);
      TransferHelper.safeApprove(_token, address(this), tokenRequested.balanceOf(address(this)));
      TransferHelper.safeTransferFrom(_token, address(this), _recipient, tokenRequested.balanceOf(address(this)));
    }

}
