// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Voting {
    // Model a Candidate
    struct Candidate {
        uint id;
        string name;
        uint voteCount;
    }

    // Store accounts that have voted
    mapping(address => bool) public voters;
    // Store Candidates
    // Fetch Candidate
    mapping(uint => Candidate) public candidates;
    // Store Candidates Count
    uint public candidatesCount;

    // voted event
    event votedEvent (
        uint indexed _candidateId
    );

    constructor() {
        addCandidate("Modi");
        addCandidate("Pappu");
    }

    function addCandidate(string memory _name) public {
        candidatesCount++;
        candidates[candidatesCount] = Candidate(candidatesCount, _name, 0);
    }

    function vote(uint _candidateId) public {
        // require that they haven't voted before
        require(!voters[msg.sender], "This account has already voted.");

        // require a valid candidate
        require(_candidateId >= 1 && _candidateId <= candidatesCount, "Invalid candidate ID.");

        // record that voter has voted
        voters[msg.sender] = true;

        // update candidate vote Count
        candidates[_candidateId].voteCount++;

        // trigger voted event
        emit votedEvent(_candidateId);
    }

    receive() external payable {
        // Fallback function to receive Ether
        // This function allows the contract to receive Ether
    }

    fallback() external {
        revert("Invalid function called");
    }
}
