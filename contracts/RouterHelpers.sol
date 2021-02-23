// SPDX-License-Identifier: UNLICENSED
pragma solidity =0.7.6;
pragma abicoder v2;

import '@uniswap/v3-core/contracts/interfaces/IUniswapV3Factory.sol';
import '@uniswap/v3-core/contracts/interfaces/IUniswapV3Pool.sol';

import './interfaces/IRouterImmutableState.sol';
import './interfaces/IRouterPositions.sol';
import './libraries/PoolAddress.sol';

abstract contract RouterHelpers is IRouterImmutableState {
    modifier checkDeadline(uint256 deadline) {
        require(block.timestamp <= deadline, 'Transaction too old');
        _;
    }

    function verifyCallback(
        address tokenA,
        address tokenB,
        uint24 fee
    ) internal view {
        require(msg.sender == PoolAddress.computeAddress(this.factory(), tokenA, tokenB, fee));
    }
}
