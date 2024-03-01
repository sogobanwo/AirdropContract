// SPDX-License-Identifier: MIT
pragma solidity 0.8.0;

contract AirdropContract {
    address[] participants;
    uint[] entries;
    uint numberOfEntries;
    address owner;
    uint numOfWinners;
    uint totalNumberOfPossibleEntries

    event SuccessfulRegistration(address user, bool registrationStatus);

    mapping (address => bool) isRegistered;
    mapping (address => bool) hasParticipated;
    mapping  (address => uint) participantsPoints;

    constructor(uint _totalNumberOfPossibleEntries, uint _numOfWinners){
        require(_numOfWinners <  _totalNumberOfPossibleEntries, "Winners can't be less than entries");
        owner = msg.sender;
        totalNumberOfEntries = _totalNumberOfPossibleEntries
        numOfWinners = _numOfWinners
    }

    function onlyOwner() private view  {
        require(msg.sender == owner, "Only Owner can trigger Distribution");
    }

    function registerUser() external {
        require(msg.sender != address(0), "address zero detected");

        require(isRegistered[msg.sender] == false, "You are already registered");

        isRegistered[msg.sender] = true;

        participants.push(msg.sender);
        
    }

    function pickNumberGame(uint[3] _numberPrediction) external  {

        require(msg.sender != address(0), "address zero detected");

        require(isRegistered[msg.sender] == true, "You are need to be a registered user");

        require(hasParticipated[msg.sender] == false, "You can't participate twice");

        uint8 _matchingPredictions = 0;

        for (uint256 i = 0; i < _numberPrediction.length; i++) {
            if(_numberPrediction[i] == randomResult1) {
                _matchingPredictions++;
            }
            if(_numberPrediction[i] == randomResult2){
                _matchingPredictions++;
            }
            if( _numberPrediction[i] == randomResult3){
                _matchingPredictions++;
            }
        }

        participantsPoints[msg.sender] = _matchingPredictions;

        if(_matchingPredictions > 0 ) {

        entries.push(msg.sender);

        }

        numberOfEntries++;

        if(numberOfEntries == _totalNumberOfPossibleEntries){
           triggerDistribution();
        }

    }

    function calculateReward() {

        uint totalPrizePool = numOfWinners * prizePerWinner;

    }

    function triggerDistribution() private view  {

        onlyOwner() ;

        require(numOfWinners > 0 && numOfWinners <= numberOfEntries, "Invalid number of winners");

        IVRFv2Consumer.requestRandomness(keyHash, fee);
    }


    function setNumberOfWinnerAndPrizePerPerson(uint _newNumberOfWinners, uint _prizePerWinner) external {

        require(_newNumberOfWinners < totalNumberOfEntries, "Winners Can't be more than Particpants");

        numOfWinners = _newNumberOfWinners;

        prizePerWinner = _prizePerWinner

    }
}