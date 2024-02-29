// SPDX-License-Identifier: MIT
pragma solidity 0.8.0;

contract AirdropContract {
    address[] participants;
    uint[] entries;
    uint numberOfEntries;
    address owner;
    uint totalPrizePool;
    uint numOfWinners;
    uint prizePerWinner;


    event SuccessfulRegistration(address user, bool registrationStatus);

    constructor(){
        owner = msg.sender;
    }

    mapping (address => bool) isRegistered;

    mapping  (address => uint) pickedNumber;

    function onlyOwner() private view  {
        require(msg.sender == owner, "Only Owner can trigger Distribution");
    }

    function registerUser() external {
        require(msg.sender != address(0), "address zero detected");

        require(isRegistered[msg.sender] == false, "You are already registered");

        isRegistered[msg.sender] = true;

        participants.push(msg.sender);
        
    }

    function checkIfNumberExists(uint256 _number) private view returns (bool) {
        for (uint256 i = 0; i < entries.length; i++) {
            if (entries[i] == _number) {
                return true;
            }
        }
        return false;
    }

    function pickNumberGame(uint _number) external  {

        require(msg.sender != address(0), "address zero detected");

        require(isRegistered[msg.sender] == true, "You are need to be a registered user");

        require(checkIfNumberExists(_number) == false, "Number already picked");

        pickedNumber[msg.sender] = _number;

        entries.push(_number);

        numberOfEntries++;

        if(numberOfEntries == 10){
           triggerDistribution();
        }

    }

    function triggerDistribution() private view  {
        onlyOwner() ;



    }
}