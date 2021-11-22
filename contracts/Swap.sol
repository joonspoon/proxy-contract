// SPDX-License-Identifier: BSD-3-Clause
pragma solidity ^0.8.4;

import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
// import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import '@uniswap/lib/contracts/libraries/TransferHelper.sol';
import '@uniswap/v2-periphery/contracts/interfaces/IUniswapV2Router02.sol';

contract Swap is OwnableUpgradeable {

  address private constant UNISWAP_V2_ROUTER = 0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D;

  function swap(
      address _tokenIn,
      address _tokenOut,
      uint _amountIn,
      uint _amountOutMin,
      address _to
    ) external {

    TransferHelper.safeTransferFrom(_tokenIn, msg.sender, address(this), _amountIn);
    TransferHelper.safeApprove(_tokenIn, UNISWAP_V2_ROUTER, _amountIn);
    // IERC20(_tokenIn).transferFrom(msg.sender, address(this), _amountIn);
    // IERC20(_tokenIn).approve(UNISWAP_V2_ROUTER, _amountIn);

    address[] memory path = new address[](2);
    path[0] = _tokenIn;
    path[1] = _tokenOut;

    IUniswapV2Router02(UNISWAP_V2_ROUTER).swapExactTokensForTokens(
      _amountIn,
      _amountOutMin,
      path,
      _to,
      block.timestamp
    );
  }

  // function getAmountOutMin(
  //   address _tokenIn,
  //   address _tokenOut,
  //   uint _amountIn
  // ) external view returns (uint) {
  //
  //   address[] memory path = new address[](2);
  //   path[0] = _tokenIn;
  //   path[1] = _tokenOut;
  //
  //   uint[] memory amountOutMins = IUniswapV2Router02(UNISWAP_V2_ROUTER).getAmountsOut(_amountIn, path);
  //
  //   return amountOutMins[path.length - 1];
  // }
}
