const ICESmartContract = artifacts.require("ICESmartContract");

var firstCompanyId = 0;
var globalMachineId = 2;
var globalRecipeId = 0;
var globalRecipeStepId = 0;

contract("Test measure constraint", () => {
  it("Add measure constraint", async () => {
    const iceContract = await ICESmartContract.deployed();

    for (let index = 0; index < 10; index++) {
      await iceContract.addMeasureConstraint(
        index,
        index + globalMachineId,
        `constraint per macchina ${index}`,
        1,
        -1,
        "unità di misura: ${index}"
      );
    }

    const measureConstraints = await iceContract.getMeasureConstraints();

    assert.equal(measureConstraints.length, 10, "length not equal");
  });
});
