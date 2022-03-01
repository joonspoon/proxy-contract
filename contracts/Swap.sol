// SPDX-License-Identifier: BSD-3-Clause
pragma solidity ^0.8.4;

import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/utils/math/SafeMathUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC20/extensions/ERC20WrapperUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/utils/AddressUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import '@uniswap/lib/contracts/libraries/TransferHelper.sol';
import '@uniswap/v2-periphery/contracts/interfaces/IUniswapV2Router02.sol';

contract Swap is Initializable, OwnableUpgradeable {

  address private constant UNISWAP_V2_ROUTER = 0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D;
  address private constant WETH_ADDRESS = 0xc778417E063141139Fce010982780140Aa0cD5Ab;

  mapping( address => bool) private preferredFeeCurrencies;

  function initialize() public initializer {
     /// Rinkeby
    address USDT_ADDRESS = 0x3B00Ef435fA4FcFF5C209a37d1f3dcff37c705aD;
    preferredFeeCurrencies[USDT_ADDRESS] = true;
    address USDC_ADDRESS = 0xeb8f08a975Ab53E34D8a0330E0D34de942C95926;
    preferredFeeCurrencies[USDC_ADDRESS] = true;
    address DAI_ADDRESS = 0xc3dbf84Abb494ce5199D5d4D815b10EC29529ff8;
    preferredFeeCurrencies[DAI_ADDRESS] = true;
 }

  function isPreferred(address _currency) private view returns (bool) {
    return preferredFeeCurrencies[_currency];
  }

  ///TODO: restrict to owner
  function addPreferredCurrencyForFees(address _currency) public {
    preferredFeeCurrencies[_currency] = true;
  }

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

      /// if the input token is already in one our preferred currencies, subtract the fee right away
      if (isPreferred(_tokenIn)) {
        uint edgeFee = SafeMathUpgradeable.div(_amountIn, 200); /// Charge a swap fee of .5%

        IUniswapV2Router02(UNISWAP_V2_ROUTER).swapExactTokensForTokens(
          _amountIn - edgeFee,
          _amountOutMin,
          path,
          msg.sender,
          block.timestamp
        );

    } else {  /// fee needs to be charged after swap

      uint[] memory amounts = IUniswapV2Router02(UNISWAP_V2_ROUTER).swapExactTokensForTokens(
        _amountIn,
        _amountOutMin,
        path,
        address(this),
        block.timestamp
      );

      uint amountReturned = amounts[amounts.length - 1];  // if multiple hops were involved, the final amount will be in the last element
      uint edgeFee = SafeMathUpgradeable.div(amountReturned, 200); /// Charge a swap fee of .5%

      TransferHelper.safeApprove(_tokenOut,  address(this), amountReturned - edgeFee);
      TransferHelper.safeTransferFrom(_tokenOut, address(this), msg.sender, amountReturned - edgeFee);
    }
  }

  ///TODO: restrict to owner
  function withdrawFees(address _token, address _recipient) external {
      ERC20Upgradeable tokenRequested = ERC20Upgradeable(_token);
      TransferHelper.safeApprove(_token, address(this), tokenRequested.balanceOf(address(this))); //may be able to remove this or approve all common tokens once in the constructor
      TransferHelper.safeTransferFrom(_token, address(this), _recipient, tokenRequested.balanceOf(address(this)));
    }

}
