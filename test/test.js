const ICESmartContract = artifacts.require("ICESmartContract");

contract("ICESmartContract", () => {
  it("Adding a new company", async () => {
    const iceContract = await ICESmartContract.deployed();
    await iceContract.addCompany("azienda di giovanni");
    const company = await iceContract.getCompanyById(0);
    assert.equal(company.name, "azienda di giovanni", "names not");
  });
  it("Company accessible also here", async () => {
    const iceContract = await ICESmartContract.deployed();
    const company = await iceContract.getCompanyById(0);
    assert.equal(company.name, "azienda di giovanni", "names not");
  });
});
