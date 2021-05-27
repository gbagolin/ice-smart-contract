const ICESmartContract = artifacts.require("ICESmartContract");

module.exports = function(deployer) {
  deployer.deploy(ICESmartContract);
};
