const ICESmartContract = artifacts.require("ICESmartContract");

var firstCompanyId = 0;
var secondCompanyId = 1;
var machineId = 2;
var globalRecipeId = 0;

contract("Test recipe", () => {
  it("Add Recipe", async () => {
    const iceContract = await ICESmartContract.deployed();

    const recipeId = (
      await iceContract.addRecipe.call(
        firstCompanyId,
        "ricetta 1",
        "ricetta per produrre un cubo"
      )
    ).toNumber();

    await iceContract.addRecipe(
      firstCompanyId,
      "ricetta 1",
      "ricetta per produrre un cubo"
    );

    const recipe = await iceContract.getRecipebyId(recipeId);

    assert.equal(recipe.name, "ricetta 1", "names not equal");

    globalRecipeId = recipeId;
  });
  it("Add Recipe Step", async () => {
    const iceContract = await ICESmartContract.deployed();

    //adding 10 steps, one for each machine.
    for (let i = 0; i < 10; i++) {
      await iceContract.addRecipeStep(
        globalRecipeId,
        i + 2, //machine id.
        `step: ${i + 1}`,
        "no description."
      );
    }

    const recipeSteps = await iceContract.getRecipeStepsByRecipeId(
      globalRecipeId
    );

    assert.equal(recipeSteps.length, 10, "recipe steps array length is wrong");
  });
});
