const ICESmartContract = artifacts.require("ICESmartContract");

var firstCompanyId = 0;
var secondCompanyId = 0;

contract("Test company", () => {
  it("Add company", async () => {
    const iceContract = await ICESmartContract.deployed();
    //let's first check the outcome of the function call.
    const companyId = (
      await iceContract.addCompany.call("azienda di giovanni")
    ).toNumber();
    // this does not return the company id.
    await iceContract.addCompany("azienda di giovanni");

    const company = await iceContract.getCompanyById(companyId);

    assert.equal(company.name, "azienda di giovanni", "names not equal");

    firstCompanyId = companyId;
  });

  it("Add another company", async () => {
    const iceContract = await ICESmartContract.deployed();

    var companyId = (
      await iceContract.addCompany.call("azienda di luca")
    ).toNumber();

    await iceContract.addCompany("azienda di luca");

    const company = await iceContract.getCompanyById(companyId);

    assert.equal(company.name, "azienda di luca", "names not equal");

    secondCompanyId = companyId;
  });

});
