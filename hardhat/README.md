# Privacy-Preserving AI Bounty Judge

This project implements a secure Commit-Reveal bounty system designed to prevent plagiarism.

## Overview

The core problem in traditional bounty systems is fairness: if answers are public during the submission phase, participants can copy earlier ideas. This contract keeps answers hidden until the reveal phase. 

- **Commit Phase**: Participants submit a hash (`keccak256`) of their answer, salt, sender address, and bounty ID.
- **Reveal Phase**: After the deadline, participants reveal their original answer and salt. The contract verifies the commitment, ensuring only valid, pre-committed answers are eligible for AI judging.

## Why this approach

Using a Commit-Reveal flow ensures that submissions remain confidential until the judging phase, promoting originality and fairness in AI bounty programs.