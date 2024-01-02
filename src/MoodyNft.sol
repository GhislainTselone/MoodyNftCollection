// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";
import {console} from "forge-std/console.sol";



/**
 * @title MoodyNft contract 
 * @author Ghislain Te selone
 * @notice This is an nft collection that enable minter to showcase one nft 
 * at a time based on a mood variable
 */
contract MoodyNft is ERC721 {
    error MoodyNft__TokenIdNotOwnYet();
    error MoodyNft__SenderDontOwnTokenId();

    address payable private immutable i_owner;
    mapping(uint256 => OwnerAndUris) private s_ownerInfos;
    uint256 private s_counter;

    enum MoodIs {
        HAPPY,
        SAD
    }

    struct OwnerAndUris {
        address _owner;
        string[2] _uris;
        string _uriToPush;
        MoodIs _mood;
    }

    constructor(
        string memory _collectionName,
        string memory _collectionSymbol
    ) ERC721(_collectionName, _collectionSymbol) {
        i_owner = payable(msg.sender);
    }

    receive() external payable {}

    fallback() external payable {}

    /**
     * @dev State changing functions
     */
    function startMinting(
        string memory _happyMood,
        string memory _sadMood
    ) external {
        s_ownerInfos[s_counter] = OwnerAndUris(
            msg.sender,
            [_happyMood, _sadMood],
            _happyMood,
            MoodIs.HAPPY
        );
        _safeMint(msg.sender, s_counter);
        s_counter++;
    }

    function setTheMood(uint256 _tokenId) external {
        if (ownerOf(_tokenId) == address(0))
            revert MoodyNft__TokenIdNotOwnYet();

        if (ownerOf(_tokenId) != msg.sender)
            revert MoodyNft__SenderDontOwnTokenId();

        MoodIs mood = s_ownerInfos[_tokenId]._mood;

        if (mood == MoodIs.HAPPY) {
            string memory uriToPush = s_ownerInfos[_tokenId]._uris[1];
            s_ownerInfos[_tokenId]._uriToPush = uriToPush;
            s_ownerInfos[_tokenId]._mood = MoodIs.SAD;
        } else {
            string memory uriToPush = s_ownerInfos[_tokenId]._uris[0];
            s_ownerInfos[_tokenId]._uriToPush = uriToPush;
            s_ownerInfos[_tokenId]._mood = MoodIs.HAPPY;
        }
    }

    /**
     * @dev Read-only functions
     */

    function _baseURI() internal pure override returns (string memory) {
        return "data:application/json;base64,";
    }

    function tokenURI(
        uint256 _tokenId
    ) public view override returns (string memory _uri) {
        if (ownerOf(_tokenId) == address(0))
            revert MoodyNft__TokenIdNotOwnYet();

        string memory imageUri = s_ownerInfos[_tokenId]._uriToPush;

        bytes memory json = abi.encodePacked(
            '{"name":"',
            name(),
            '", "description":"An NFT that reflects the mood of the owner, 100% on Chain!", ',
            '"attributes": [{"trait_type": "moodiness", "value": 100}], "image":"',
            imageUri,
            '"}'
        ); // returned bytes

        string memory base64Encoded = Base64.encode(json); // return string

        _uri = string(abi.encodePacked(_baseURI(), base64Encoded));
    }

    function getCounter() external view returns (uint256 _counter) {
        _counter = s_counter;
    }

    function getMood(uint256 _tokenId) external view returns (MoodIs _mood) {
        if (ownerOf(_tokenId) == address(0))
            revert MoodyNft__TokenIdNotOwnYet();

        _mood = s_ownerInfos[_tokenId]._mood;
    }

    function getOwner() external view returns (address payable _owner) {
        _owner = i_owner;
    }

    function getOwnerInfo(
        uint256 _id
    ) external view returns (OwnerAndUris memory _infos) {
        if (ownerOf(_id) == address(0)) revert MoodyNft__TokenIdNotOwnYet();
        _infos = s_ownerInfos[_id];
    }

    function getDisplayedImageUri(
        uint256 _tokenId
    ) external view returns (string memory _uri) {
        if (ownerOf(_tokenId) == address(0))
            revert MoodyNft__TokenIdNotOwnYet();

        _uri = s_ownerInfos[_tokenId]._uriToPush;
    }
}
