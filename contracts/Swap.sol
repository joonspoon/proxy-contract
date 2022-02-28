// SPDX-License-Identifier: BSD-3-Clause
pragma solidity ^0.8.4;

import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/utils/math/SafeMathUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC20/extensions/ERC20WrapperUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/utils/AddressUpgradeable.sol";
import '@uniswap/lib/contracts/libraries/TransferHelper.sol';
import '@uniswap/v2-periphery/contracts/interfaces/IUniswapV2Router02.sol';

contract Swap is OwnableUpgradeable {

  address private constant UNISWAP_V2_ROUTER = 0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D;
  address private constant WETH_ADDRESS = 0xc778417E063141139Fce010982780140Aa0cD5Ab;

  function swapFromETH (
    address _tokenOut,
    uint _amountOutMin
  ) external payable {

    AddressUpgradeable.sendValue(payable(WETH_ADDRESS), msg.value);
    swap(WETH_ADDRESS, _tokenOut, msg.value, _amountOutMin);
  }

  function swapFromERC20 (
    address _tokenIn,
    address _tokenOut,
    uint _amountIn,
    uint _amountOutMin
  ) external {

    TransferHelper.safeTransferFrom(_tokenIn, msg.sender, address(this), _amountIn);
    swap(_tokenIn, _tokenOut, _amountIn, _amountOutMin);
  }

  function swap (
      address _tokenIn,
      address _tokenOut,
      uint _amountIn,
      uint _amountOutMin
    ) private {

      TransferHelper.safeApprove(_tokenIn, UNISWAP_V2_ROUTER, _amountIn);

      uint feePercentage = 1;  /// TODO: reduce the swap fee to .5%
      uint edgeFee = SafeMathUpgradeable.div(SafeMathUpgradeable.mul(_amountIn, feePercentage), 100);

      address[] memory path;
      if (_tokenIn == WETH_ADDRESS || _tokenOut == WETH_ADDRESS) {
        path = new address[](2);
        path[0] = _tokenIn;
        path[1] = _tokenOut;
      } else {
        path = new address[](3);
        path[0] = _tokenIn;
        path[1] = WETH_ADDRESS;
        path[2] = _tokenOut;
      }

      IUniswapV2Router02(UNISWAP_V2_ROUTER).swapExactTokensForTokens(
        _amountIn - edgeFee,
        _amountOutMin,
        path,
        msg.sender,
        block.timestamp
      );
  }

  ///TODO: restrict to owner
  function withdrawFees(address _token, address _recipient) external {
      ERC20Upgradeable tokenRequested = ERC20Upgradeable(_token);
      TransferHelper.safeApprove(_token, address(this), tokenRequested.balanceOf(address(this))); //may be able to remove this or approve all common tokens once in the constructor
      TransferHelper.safeTransferFrom(_token, address(this), _recipient, tokenRequested.balanceOf(address(this)));
    }

}
