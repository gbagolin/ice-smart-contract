const ICESmartContract = artifacts.require("ICESmartContract");

var globalFirstCompanyId = 0;
var globalMachineId = 2;
var globalRecipeId = 0;

contract("Test product", () => {
  it("Add product", async () => {
    const iceContract = await ICESmartContract.deployed();
    const productId = await iceContract.addProduct.call(
      globalFirstCompanyId,
      globalRecipeId,
      "primo prodotto",
      "fatto il giorno 27"
    );
    await iceContract.addProduct(
      globalFirstCompanyId,
      globalRecipeId,
      "primo prodotto",
      "fatto il giorno 27"
    );

    const product = await iceContract.getProductById(productId);

    assert.equal(product.name, "primo prodotto", "names not equal");
  });
});
