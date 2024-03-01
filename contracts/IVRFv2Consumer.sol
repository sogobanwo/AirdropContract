// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

interface IVRFv2Consumer{
     function getRequestStatus(
        uint256 _requestId
    ) external view returns (bool fulfilled, uint256[] memory randomWords) ;

}