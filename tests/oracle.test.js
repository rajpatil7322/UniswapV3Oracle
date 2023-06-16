// Right click on the script name and hit "Run" to execute
const { expect } = require("chai");
const { ethers } = require("hardhat");

const FACTORY = "0x1F98431c8aD98523631AE4a59f267346ea31F984"
    // USDC
const TOKEN_0 = "0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48"
const DECIMALS_0 = 6;
// WETH
const TOKEN_1 = "0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2"
const DECIMALS_1 = 18;
// 0.3%
const FEE = 3000

describe("Oracle", function () {
  it("test deployment", async function () {
    const UniswapV3Oracle = await ethers.getContractFactory("UniswapV3Oracle")
    const oracle = await UniswapV3Oracle.deploy(FACTORY, TOKEN_0, TOKEN_1, FEE)
    await oracle.deployed()

    const price = await oracle.estimateAmountOut(TOKEN_1, 10 ** DECIMALS_1, 10)

    console.log(`price: ${price}`)

  });
  
});