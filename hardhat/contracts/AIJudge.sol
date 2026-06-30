// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Bounty {
    struct Submission {
        bytes32 commitment;
        string answer;
        bool isRevealed;
        bool exists;
    }

    mapping(uint256 => mapping(address => Submission)) public submissions;

    // 1. Участник фиксирует свой ответ через хеш
    function submitCommitment(uint256 bountyId, bytes32 commitment) external {
        require(!submissions[bountyId][msg.sender].exists, "Already submitted");
        submissions[bountyId][msg.sender] = Submission(commitment, "", false, true);
    }

    // 2. Участник раскрывает ответ, предоставляя исходный текст и соль
    function revealAnswer(uint256 bountyId, string calldata answer, bytes32 salt) external {
        Submission storage sub = submissions[bountyId][msg.sender];
        require(sub.exists, "No commitment found");
        require(!sub.isRevealed, "Already revealed");

        // Проверка: хеш данных должен совпадать с тем, что был отправлен ранее
        bytes32 computedHash = keccak256(abi.encodePacked(answer, salt, msg.sender, bountyId));
        require(computedHash == sub.commitment, "Invalid reveal: hash mismatch");

        sub.answer = answer;
        sub.isRevealed = true;
    }

    // Заглушки для будущего функционала
    function judgeAll(uint256 bountyId, bytes calldata llmInput) external {}
    function finalizeWinner(uint256 bountyId, uint256 winnerIndex) external {}
}