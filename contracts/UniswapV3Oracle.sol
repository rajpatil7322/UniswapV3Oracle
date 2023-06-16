// SPDX-License-Identifier: UNLICENSED
pragma solidity =0.7.6;
pragma abicoder v2;

import "@uniswap/v3-core/contracts/interfaces/IUniswapV3Factory.sol";
import "@uniswap/v3-periphery/contracts/libraries/OracleLibrary.sol";

// const FACTORY = "0x1F98431c8aD98523631AE4a59f267346ea31F984"
//     // USDC
// const TOKEN_0 = "0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48"
// const DECIMALS_0 = 6n;
// // WETH
// const TOKEN_1 = "0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2"
// const DECIMALS_1 = 18n;
// // 0.3%
// const FEE = 3000



contract UniswapV3Oracle {
    address public immutable token0;
    address public immutable token1;
    address public immutable pool;

    constructor(address _token0,address _token1,address _factory,uint24 _fee){
        token0=_token0;
        token1=_token1;

        address _pool=IUniswapV3Factory(_factory).getPool(
            _token0,_token1,_fee
        );
        require(_pool!=address(0),"Pools does not exist");
        pool=_pool;
    }

    function estimateAmountOut(
        address tokenIn,
        uint128 amountIn,
        uint32 secondsAgo
    ) external view returns(uint amountOut) {
        require(tokenIn==token0 || tokenIn==token1,"invalid token");
        address tokenout=tokenIn==token0 ? token1:token0;

        (int24 tick,)=OracleLibrary.consult(pool,secondsAgo);
        amountOut = OracleLibrary.getQuoteAtTick(
            tick,
            amountIn,
            tokenIn,
            tokenout
        );
    }
}