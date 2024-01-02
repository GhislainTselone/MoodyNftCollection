// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Test} from "forge-std/Test.sol";
import {DeployMoodyNft} from "../../script/DeployMoodyNft.s.sol";
import {MoodyNft} from "../../src/MoodyNft.sol";
import {Helper} from "../../script/Helper.s.sol";

contract TestMoodyNft is Test {
    MoodyNft private s_moodyNft;
    Helper private s_helper;

    string private constant HAPPY_MOOD =
        "data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdCb3g9IjAgMCAyMDAgMjAwIiB3aWR0aD0iMjAwIiBoZWlnaHQ9IjIwMCI+CgogIDwhLS0gSGVhZCAtLT4KICA8Y2lyY2xlIGN4PSIxMDAiIGN5PSI2MCIgcj0iMjAiIGZpbGw9InllbGxvdyIgLz4KCiAgPCEtLSBCb2R5IC0tPgogIDxyZWN0IHg9IjkwIiB5PSI4MCIgd2lkdGg9IjIwIiBoZWlnaHQ9IjQwIiBmaWxsPSJibHVlIiAvPgoKICA8IS0tIExlZ3MgLS0+CiAgPHJlY3QgeD0iOTAiIHk9IjEyMCIgd2lkdGg9IjEwIiBoZWlnaHQ9IjIwIiBmaWxsPSJncmVlbiIgLz4KICA8cmVjdCB4PSIxMDAiIHk9IjEyMCIgd2lkdGg9IjEwIiBoZWlnaHQ9IjIwIiBmaWxsPSJncmVlbiIgLz4KCiAgPCEtLSBBcm1zIC0tPgogIDxyZWN0IHg9IjgwIiB5PSI4MCIgd2lkdGg9IjEwIiBoZWlnaHQ9IjMwIiBmaWxsPSJyZWQiIC8+CiAgPHJlY3QgeD0iMTEwIiB5PSI4MCIgd2lkdGg9IjEwIiBoZWlnaHQ9IjMwIiBmaWxsPSJyZWQiIC8+CgogIDwhLS0gSnVtcGluZyBBbmltYXRpb24gLS0+CiAgPGFuaW1hdGVUcmFuc2Zvcm0KICAgIGF0dHJpYnV0ZU5hbWU9InRyYW5zZm9ybSIKICAgIGF0dHJpYnV0ZVR5cGU9IlhNTCIKICAgIHR5cGU9InRyYW5zbGF0ZSIKICAgIHZhbHVlcz0iMCAwOyAwIC0yMDsgMCAwIgogICAgYmVnaW49IjBzIgogICAgZHVyPSIxcyIKICAgIHJlcGVhdENvdW50PSJpbmRlZmluaXRlIgogIC8+Cgo8L3N2Zz4K";
    string private constant SAD_MOOD =
        "data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdCb3g9IjAgMCAyMDAgMjAwIiB3aWR0aD0iMjAwIiBoZWlnaHQ9IjIwMCI+CgogIDwhLS0gSGVhZCAtLT4KICA8Y2lyY2xlIGN4PSIxMDAiIGN5PSI2MCIgcj0iMjAiIGZpbGw9InllbGxvdyIgLz4KCiAgPCEtLSBCb2R5IC0tPgogIDxyZWN0IHg9IjkwIiB5PSI4MCIgd2lkdGg9IjIwIiBoZWlnaHQ9IjQwIiBmaWxsPSJibHVlIiAvPgoKICA8IS0tIExlZ3MgLS0+CiAgPHJlY3QgeD0iOTAiIHk9IjEyMCIgd2lkdGg9IjEwIiBoZWlnaHQ9IjIwIiBmaWxsPSJncmVlbiIgLz4KICA8cmVjdCB4PSIxMDAiIHk9IjEyMCIgd2lkdGg9IjEwIiBoZWlnaHQ9IjIwIiBmaWxsPSJncmVlbiIgLz4KCiAgPCEtLSBBcm1zIC0tPgogIDxyZWN0IHg9IjgwIiB5PSI4MCIgd2lkdGg9IjEwIiBoZWlnaHQ9IjMwIiBmaWxsPSJyZWQiIC8+CiAgPHJlY3QgeD0iMTEwIiB5PSI4MCIgd2lkdGg9IjEwIiBoZWlnaHQ9IjMwIiBmaWxsPSJyZWQiIC8+CgogIDwhLS0gTW91dGggLS0+CiAgPGVsbGlwc2UgY3g9IjEwMCIgY3k9IjY1IiByeD0iNSIgcnk9IjMiIGZpbGw9ImJsYWNrIiAvPgoKICA8IS0tIEV5ZXMgLS0+CiAgPGNpcmNsZSBjeD0iOTUiIGN5PSI1OCIgcj0iMiIgZmlsbD0iYmxhY2siIC8+CiAgPGNpcmNsZSBjeD0iMTA1IiBjeT0iNTgiIHI9IjIiIGZpbGw9ImJsYWNrIiAvPgoKICA8IS0tIEV5ZWJyb3dzIC0tPgogIDxsaW5lIHgxPSI5MCIgeTE9IjU1IiB4Mj0iOTMiIHkyPSI1MyIgc3Ryb2tlPSJibGFjayIgc3Ryb2tlLXdpZHRoPSIyIiAvPgogIDxsaW5lIHgxPSIxMTAiIHkxPSI1NSIgeDI9IjEwNyIgeTI9IjUzIiBzdHJva2U9ImJsYWNrIiBzdHJva2Utd2lkdGg9IjIiIC8+Cgo8L3N2Zz4K";

    function setUp() external {
        DeployMoodyNft deploy = new DeployMoodyNft();
        (s_helper, s_moodyNft) = deploy.run();
    }

    function testStartMinting() external {
        vm.prank(msg.sender);
        vm.deal(msg.sender, 10e18);
        s_moodyNft.startMinting(HAPPY_MOOD, SAD_MOOD);
        vm.prank(msg.sender);
        string memory displayImageUri = s_moodyNft.getDisplayedImageUri(0);
        assert(
            keccak256(abi.encodePacked(HAPPY_MOOD)) ==
                keccak256(abi.encodePacked(displayImageUri))
        );
    }

    // As of now, i am just learning the implementation of NFTs
    // I wont make other tests as i will spend more time later on smart contract auditing course
}
