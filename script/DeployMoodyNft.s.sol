// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {Helper} from "../script/Helper.s.sol";
import {MoodyNft} from "../src/MoodyNft.sol";

contract DeployMoodyNft is Script {
    function run() external returns (Helper s_helper, MoodyNft s_moodyNft) {
        s_helper = new Helper();
        string memory name = s_helper.getItems()._collectionName;
        string memory symbol = s_helper.getItems()._collectionSymbol;

        vm.startBroadcast();
        s_moodyNft = new MoodyNft(name, symbol);
        vm.stopBroadcast();
    }
}
