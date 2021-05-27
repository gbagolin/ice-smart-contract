const ICESmartContract = artifacts.require("ICESmartContract");

var firstCompanyId = 0;
var machineId = 2;
var globalRecipeId = 0;
var globalRecipeStepId = 0;

contract("Test measure constraint", () => {
  it("Add measure constraint", async () => {
    const iceContract = await ICESmartContract.deployed();
    const measureConstraintId = await iceContract.addMeasureConstraint.call(
      globalRecipeStepId,
      machineId,
      "misura fatta il giorno 27/05",
      -256,
      1024,
      "gradi"
    );
    await iceContract.addMeasureConstraint(
      globalRecipeStepId,
      machineId,
      "misura fatta il giorno 27/05",
      -256,
      1024,
      "gradi"
    );

    const measureConstraint = await iceContract.getMeasureConstraintById(
      measureConstraintId
    );

    assert.equal(
      measureConstraint.name,
      "misura fatta il giorno 27/05",
      "names not equal"
    );
    assert.equal(measureConstraint.maxMeasure, -256, "max measures not equal");
  });
});
