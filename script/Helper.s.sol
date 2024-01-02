//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract Helper {
    Items private s_returnedItems;

    string private constant COLLECTION_NAME = "MOODY_NFT";
    string private constant COLLECTION_SYMBOL = "MN";

    constructor() {
        uint256 activeNetwork = block.chainid;

        if (activeNetwork == 80001) {
            s_returnedItems = whenOnMumbai();
        }
    }

    struct Items {
        string _collectionName;
        string _collectionSymbol;
    }

    function whenOnMumbai() private pure returns (Items memory _items) {
        _items = Items(COLLECTION_NAME, COLLECTION_SYMBOL);
    }

    function getItems() external view returns (Items memory _items) {
        _items = s_returnedItems;
    }
}
