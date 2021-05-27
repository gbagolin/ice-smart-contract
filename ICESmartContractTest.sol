// pragma solidity ^0.8.1;
// pragma experimental ABIEncoderV2;
// import "truffle/Assert.sol";
// import "truffle/DeployedAddresses.sol";
// import "../contracts/ICESmartContract.sol";


// contract TestMetaCoin {
//     function testInitialBalanceUsingDeployedContract() public {
//         ICESmartContract iceContract =
//             ICESmartContract(DeployedAddresses.ICESmartContract());

//         uint256 expected = 1;

//         iceContract.addCompany("azienda di giovanni");
//         uint256 companyId = iceContract.addCompany("azienda di luca");
//         (uint256 id, bytes32 companyName) = iceContract.getCompanyById(companyId);
//         bytes32 expectedName = 'azienda di luca'; 
//         Assert.equal(companyId, expected, "Not equal");
//         Assert.equal(companyName, expectedName, "Names not equal");
//     }
// }
