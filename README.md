# Ritual Chain Workshop: Privacy-Preserving AI Bounty Judge

This project implements a secure **Commit-Reveal** bounty system designed to prevent plagiarism.

## Overview
The goal of this implementation is to ensure fairness in bounty programs. By using a commit-reveal flow, participants' answers remain hidden and encrypted until the reveal phase, preventing others from copying submissions.

## Key Features
- **Commit Phase**: Participants submit a cryptographic commitment to their answer.
- **Reveal Phase**: Submissions are only verified and eligible for AI judging once they are revealed after the deadline.
- **Fairness**: This approach ensures that the judging process is transparent, secure, and plagiarism-resistant.

## Project Structure
- `/hardhat` -> Contains the smart contract (`AIJudge.sol`) and test suite.
- `/web` -> Contains the frontend application for user interaction.
