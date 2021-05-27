const ICESmartContract = artifacts.require("ICESmartContract");

var firstCompanyId = 0;
var secondCompanyId = 1;

contract("Test machines", () => {
  it("Add one machine per company", async () => {
    const iceContract = await ICESmartContract.deployed();

    const machineId1 = (
      await iceContract.addMachine.call(
        firstCompanyId,
        "tornio",
        "tornio machine"
      )
    ).toNumber();

    await iceContract.addMachine(firstCompanyId, "tornio1", "tornio machine");

    const machineId2 = (
      await iceContract.addMachine.call(
        secondCompanyId,
        "tornio",
        "tornio machine"
      )
    ).toNumber();

    await iceContract.addMachine(secondCompanyId, "tornio2", "tornio machine");

    const machine1 = await iceContract.getMachineById(machineId1);
    const machine2 = await iceContract.getMachineById(machineId2);

    assert.equal(
      machine1.name,
      "tornio1",
      "Machine names first company not equal"
    );
    assert.equal(
      machine2.name,
      "tornio2",
      "Machine names second company not equal"
    );
  });

  it("Add ten machines per company", async () => {
    const iceContract = await ICESmartContract.deployed();
    for (let i = 0; i < 10; i++) {
      await iceContract.addMachine(
        firstCompanyId,
        `machine[${i}]`,
        `good machine`
      );
    }
    for (let i = 0; i < 10; i++) {
      await iceContract.addMachine(
        secondCompanyId,
        `machine[${i}]`,
        `good machine`
      );
    }

    let machines = await iceContract.getMachinesByCompanyId(firstCompanyId);
    assert.equal(
      machines.length,
      11,
      "Machines number is wrong within first company"
    );

    for (let i = 0; i < 10; i++) {
      assert.equal(
        machines[i].companyId,
        firstCompanyId,
        `Machine company id wrong, machine id: {${machines[i].id}}, company id: {${machines[i].companyId}}`
      );
    }

    assert.equal(
      machines[0].companyId,
      firstCompanyId,
      "Machine company id wrong, firstCompany"
    );

    machines = await iceContract.getMachinesByCompanyId(secondCompanyId);
    assert.equal(
      machines.length,
      11,
      "Machines number is wrong within second company"
    );

    for (let i = 0; i < 10; i++) {
      assert.equal(
        machines[i].companyId,
        secondCompanyId,
        `Machine company id wrong, machine id: {${machines[i].id}}, company id: {${machines[i].companyId}}`
      );
    }
  });
});
