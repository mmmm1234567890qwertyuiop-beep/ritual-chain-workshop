// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract AIJudge {
    struct Submission {
        bytes32 commitment;
        bool isRevealed;
        string answer;
    }

    mapping(uint256 => mapping(address => Submission)) public submissions;

    function submitCommitment(uint256 bountyId, bytes32 commitment) public {
        submissions[bountyId][msg.sender] = Submission(commitment, false, "");
    }

    function revealAnswer(uint256 bountyId, string memory answer, bytes32 salt) public {
        Submission storage sub = submissions[bountyId][msg.sender];
        require(!sub.isRevealed, "Already revealed");
        
        bytes32 expectedCommitment = keccak256(abi.encodePacked(answer, salt, msg.sender, bountyId));
        require(sub.commitment == expectedCommitment, "Invalid answer or salt");

        sub.answer = answer;
        sub.isRevealed = true;
    }
}