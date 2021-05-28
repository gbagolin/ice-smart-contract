const ICESmartContract = artifacts.require("ICESmartContract");

var globalFirstCompanyId = 0;
var globalMachineId = 2;
var globalRecipeId = 0;
var globalProductId = 0;

contract("Test 'Measure'", () => {
  it("Add measure", async () => {
    const iceContract = await ICESmartContract.deployed();
    for (let index = 0; index < 10; index++) {
      await iceContract.addMeasure(
        index,
        index,
        `measure for machine #${index}`,
        "unit of measure",
        10,
        10
      );
    }

    const measures = await iceContract.getMeasuresByPhaseId(2);
    assert.equal(measures.length, 1, "length not equal");
  });
});
