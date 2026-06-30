import { expect } from "chai";
import hre from "hardhat";

describe("AIJudge", function () {
  it("Should commit and reveal", async function () {
    const [addr1] = await hre.ethers.getSigners();
    const AIJudge = await hre.ethers.getContractFactory("AIJudge");
    const aiJudge = await AIJudge.deploy();
    
    await aiJudge.waitForDeployment();

    const bountyId = 1;
    const answer = "My secret AI solution";
    const salt = hre.ethers.encodeBytes32String("my-secret-salt");

    const commitment = hre.ethers.solidityPackedKeccak256(
      ["string", "bytes32", "address", "uint256"],
      [answer, salt, addr1.address, bountyId]
    );

    await aiJudge.connect(addr1).submitCommitment(bountyId, commitment);
    await aiJudge.connect(addr1).revealAnswer(bountyId, answer, salt);
    
    const submission = await aiJudge.submissions(bountyId, addr1.address);
    expect(submission.isRevealed).to.equal(true);
  });
});