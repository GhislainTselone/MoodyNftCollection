// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {MoodyNft} from "../src/MoodyNft.sol";
import {console} from "forge-std/console.sol";

contract StartMinting is Script {
    // Added manually
    address private constant MOODY_NFT_ADDRESS = address(0);
    string private constant HAPPY_MOOD =
        "data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdCb3g9IjAgMCAyMDAgMjAwIiB3aWR0aD0iMjAwIiBoZWlnaHQ9IjIwMCI+CgogIDwhLS0gSGVhZCAtLT4KICA8Y2lyY2xlIGN4PSIxMDAiIGN5PSI2MCIgcj0iMjAiIGZpbGw9InllbGxvdyIgLz4KCiAgPCEtLSBCb2R5IC0tPgogIDxyZWN0IHg9IjkwIiB5PSI4MCIgd2lkdGg9IjIwIiBoZWlnaHQ9IjQwIiBmaWxsPSJibHVlIiAvPgoKICA8IS0tIExlZ3MgLS0+CiAgPHJlY3QgeD0iOTAiIHk9IjEyMCIgd2lkdGg9IjEwIiBoZWlnaHQ9IjIwIiBmaWxsPSJncmVlbiIgLz4KICA8cmVjdCB4PSIxMDAiIHk9IjEyMCIgd2lkdGg9IjEwIiBoZWlnaHQ9IjIwIiBmaWxsPSJncmVlbiIgLz4KCiAgPCEtLSBBcm1zIC0tPgogIDxyZWN0IHg9IjgwIiB5PSI4MCIgd2lkdGg9IjEwIiBoZWlnaHQ9IjMwIiBmaWxsPSJyZWQiIC8+CiAgPHJlY3QgeD0iMTEwIiB5PSI4MCIgd2lkdGg9IjEwIiBoZWlnaHQ9IjMwIiBmaWxsPSJyZWQiIC8+CgogIDwhLS0gSnVtcGluZyBBbmltYXRpb24gLS0+CiAgPGFuaW1hdGVUcmFuc2Zvcm0KICAgIGF0dHJpYnV0ZU5hbWU9InRyYW5zZm9ybSIKICAgIGF0dHJpYnV0ZVR5cGU9IlhNTCIKICAgIHR5cGU9InRyYW5zbGF0ZSIKICAgIHZhbHVlcz0iMCAwOyAwIC0yMDsgMCAwIgogICAgYmVnaW49IjBzIgogICAgZHVyPSIxcyIKICAgIHJlcGVhdENvdW50PSJpbmRlZmluaXRlIgogIC8+Cgo8L3N2Zz4K";
    string private constant SAD_MOOD =
        "data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdCb3g9IjAgMCAyMDAgMjAwIiB3aWR0aD0iMjAwIiBoZWlnaHQ9IjIwMCI+CgogIDwhLS0gSGVhZCAtLT4KICA8Y2lyY2xlIGN4PSIxMDAiIGN5PSI2MCIgcj0iMjAiIGZpbGw9InllbGxvdyIgLz4KCiAgPCEtLSBCb2R5IC0tPgogIDxyZWN0IHg9IjkwIiB5PSI4MCIgd2lkdGg9IjIwIiBoZWlnaHQ9IjQwIiBmaWxsPSJibHVlIiAvPgoKICA8IS0tIExlZ3MgLS0+CiAgPHJlY3QgeD0iOTAiIHk9IjEyMCIgd2lkdGg9IjEwIiBoZWlnaHQ9IjIwIiBmaWxsPSJncmVlbiIgLz4KICA8cmVjdCB4PSIxMDAiIHk9IjEyMCIgd2lkdGg9IjEwIiBoZWlnaHQ9IjIwIiBmaWxsPSJncmVlbiIgLz4KCiAgPCEtLSBBcm1zIC0tPgogIDxyZWN0IHg9IjgwIiB5PSI4MCIgd2lkdGg9IjEwIiBoZWlnaHQ9IjMwIiBmaWxsPSJyZWQiIC8+CiAgPHJlY3QgeD0iMTEwIiB5PSI4MCIgd2lkdGg9IjEwIiBoZWlnaHQ9IjMwIiBmaWxsPSJyZWQiIC8+CgogIDwhLS0gTW91dGggLS0+CiAgPGVsbGlwc2UgY3g9IjEwMCIgY3k9IjY1IiByeD0iNSIgcnk9IjMiIGZpbGw9ImJsYWNrIiAvPgoKICA8IS0tIEV5ZXMgLS0+CiAgPGNpcmNsZSBjeD0iOTUiIGN5PSI1OCIgcj0iMiIgZmlsbD0iYmxhY2siIC8+CiAgPGNpcmNsZSBjeD0iMTA1IiBjeT0iNTgiIHI9IjIiIGZpbGw9ImJsYWNrIiAvPgoKICA8IS0tIEV5ZWJyb3dzIC0tPgogIDxsaW5lIHgxPSI5MCIgeTE9IjU1IiB4Mj0iOTMiIHkyPSI1MyIgc3Ryb2tlPSJibGFjayIgc3Ryb2tlLXdpZHRoPSIyIiAvPgogIDxsaW5lIHgxPSIxMTAiIHkxPSI1NSIgeDI9IjEwNyIgeTI9IjUzIiBzdHJva2U9ImJsYWNrIiBzdHJva2Utd2lkdGg9IjIiIC8+Cgo8L3N2Zz4K";

    function startMinting(
        string memory _happyMood,
        string memory _sadMood,
        address _moodyNft
    ) public {
        MoodyNft moodyNft = MoodyNft(payable(_moodyNft));
        vm.startBroadcast();
        moodyNft.startMinting(_happyMood, _sadMood);
        vm.stopBroadcast();
    }

    function run() external {
        startMinting(HAPPY_MOOD, SAD_MOOD, MOODY_NFT_ADDRESS);
    }
}

contract GetDisplayedImageUri is Script {
    // Addes manually
    address private constant MOODY_NFT_ADDRESS = address(0);
    uint256 private constant TOKEN_ID = 0;

    function displayedImageUri(
        uint256 _tokenId,
        address _moodyNft
    ) public returns (string memory _uri) {
        MoodyNft moodyNft = MoodyNft(payable(_moodyNft));
        vm.startBroadcast();
        _uri = moodyNft.getDisplayedImageUri(_tokenId);
        vm.stopBroadcast();
        console.log(_uri);
    }

    function run() external {
        displayedImageUri(TOKEN_ID, MOODY_NFT_ADDRESS);
    }
}

//... More could have been made here
