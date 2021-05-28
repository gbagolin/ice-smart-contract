const ICESmartContract = artifacts.require("ICESmartContract");

var globalFirstCompanyId = 0;
var globalMachineId = 2;
var globalRecipeId = 0;
var globalProductId = 0;

contract("Test 'phase'", () => {
  it("Add phase", async () => {
    const iceContract = await ICESmartContract.deployed();
    for (let index = 0; index < 10; index++) {
      await iceContract.addPhase(
        globalProductId,
        index + globalMachineId,
        index,
        `fase #${index}`,
        "no description"
      );
    }

    const phases = await iceContract.getPhasesByProductId(globalProductId);
    assert.equal(phases.length, 10, "length not equal");
  });
});
