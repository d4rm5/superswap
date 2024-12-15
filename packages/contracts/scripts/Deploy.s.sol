// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import {console} from "forge-std/console.sol";
import {Script} from "forge-std/Script.sol";
import {SimpleLiquidityPool} from "../src/SimpleLiquidityPool.sol";
import {SwapCrossChain} from "../src/SwapCrossChain.sol";
import {Inter} from "../src/Inter.sol";

contract DeployContracts is Script {
    address public constant TOKEN0 = 0x4200000000000000000000000000000000000024; // Example Token 0
    address public constant TOKEN1 = 0x4200000000000000000000000000000000000034; // Example Token 1

    function run() external {
        vm.startBroadcast();

        // Deploy on Chain 2
        SimpleLiquidityPool liquidityPool = new SimpleLiquidityPool(TOKEN0, TOKEN1);
        Inter interContract = new Inter();

        vm.startBroadcast();
        // Deploy on Chain 1
        SwapCrossChain swapCrossChain = new SwapCrossChain();

        console.log("LiquidityPool deployed at:", address(liquidityPool));
        console.log("Inter deployed at:", address(interContract));
        console.log("SwapCrossChain deployed at:", address(swapCrossChain));

        vm.stopBroadcast();
    }
}
