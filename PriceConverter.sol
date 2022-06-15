// SPDX-License-Identifier: MIt
pragma solidity ^0.8.8;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

library PriceConverter {
    // Gets ETH value in usd
    function getPrice() public view returns (uint256) {
        // ABI
        // Address (ETH / USD) 	0x8A753747A1Fa494EC906cE90E9f37563A8AF630e
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x8A753747A1Fa494EC906cE90E9f37563A8AF630e);

        // These commas , ,,, means the unused arguments
        (,int256 price,,,) = priceFeed.latestRoundData();

        // Price = ETH in terms of usd
        // 300000000000  // Value is 3000, but comes with 8 decimals 3000.00000000
        // Need to match the decimals in eth(1e18) and the usd value

        // Converting to uint256 and matching decimals
        return uint256(price * 1e10);
    }

    function getConversionRate(uint256 ethAmount) internal view returns (uint256) {
        uint256 ethPrice = getPrice();
        uint256 ethAmountInUsd = (ethPrice * ethAmount) / 1e18;
        return ethAmountInUsd;
    }
}