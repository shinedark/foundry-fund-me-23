// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {FundMe} from "../src/FundMe.sol";
import {Script, console2} from "forge-std/Script.sol";
import {DevOpsTools} from "foundry-devops/src/DevOpsTools.sol";

contract FundFundMe is Script {

    uint256 constant SEND_VALUE = 0.01 ether;

    function fundFundMe(address mostRecentlyDeployed) public {
        vm.startBroadcast();
        FundMe(payable(mostRecentlyDeployed)).fund{value: SEND_VALUE}();
        vm.stopBroadcast();
        console2.log("Funded FundMe!", SEND_VALUE);
    }
   function run() external {

    address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment("FundMe", block.chainid);
    fundFundMe(mostRecentlyDeployed);

   }

}   

contract WithdrawFundMe is Script {
  uint256 constant SEND_VALUE = 0.01 ether;

    function withdrawFundMe(address mostRecentlyDeployed) public {
        vm.startBroadcast();
        FundMe(payable(mostRecentlyDeployed)).withdraw();
        vm.stopBroadcast();
        console2.log("Funded FundMe!", SEND_VALUE);
    }
   function run() external {
    vm.startBroadcast();
    address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment("FundMe", block.chainid);
    withdrawFundMe(mostRecentlyDeployed);
    vm.stopBroadcast();
   }
}

