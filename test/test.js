const ICESmartContract = artifacts.require("ICESmartContract");

contract("ICESmartContract", () => {
  it("Company name should be equal", async () => {
    const iceContract = await ICESmartContract.deployed();
    await iceContract.addCompany("azienda di giovanni");
    const company = await iceContract.getCompanyById(0);
    console.log(company.name);
    assert.equal(company.name, 'azienda di giovanni', "names not");
  });
});
