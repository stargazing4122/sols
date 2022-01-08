//SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.4.25;

contract Voting {

    //events
    event Vote(address indexed _voterAddress, uint _candidateId);

    //strucs
    struct Candidate {
        uint id;
        string name;
        string association;
        uint totalVotes;
    }

    //variables
    uint public totalCandidates;

    //mappings
    mapping ( uint => Candidate ) public candidates; //(candidateId => Candidate)
    //Candidate[] public candidates;

    mapping (address => bool) private voters; //( voterAddress => isVoted)
    //Voter[] private voters;

    //constructor
    constructor () public {
        _addCandidate('Peter', 'Football');
        _addCandidate('Louis','Basketball');
        _addCandidate('Dennis','Voleyball');
    }

    //functions for constructor
    function _addCandidate ( string memory _candidateName, string memory _candidateAssociation ) private {
        totalCandidates++;
        candidates[totalCandidates] = Candidate(totalCandidates, _candidateName, _candidateAssociation, 0);
        //candidates.push( Candidate(totalCandidates, _candidateName, _candidateAssociation, 0));
    }

    //others functions
    function isVoterVoted (address _address) public view returns (bool) {
        return voters[_address] == true;
        /*for (uint i = 0; i< voters.length; i++){
            if (voters[i].voterAddress == _address){
                return voters[i].isVoted;
            }
            return false;
        }*/
    }

    function isValidCandidate ( uint _id ) private view returns (bool) {
        return totalCandidates >= _id && _id > 0;
    }


    //function main 
    function vote ( uint _candidateId ) public {
        require(!isVoterVoted(msg.sender),'you have voted');
        require(isValidCandidate(_candidateId),'input a valid candidate');

        voters[msg.sender] = true;
        candidates[_candidateId].totalVotes++;

        emit Vote(msg.sender, _candidateId);

    }






}
