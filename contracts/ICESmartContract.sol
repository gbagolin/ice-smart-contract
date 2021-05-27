//SPDX-License-Identifier: LGPL-3.0-or-later
pragma solidity ^0.8.1;
pragma experimental ABIEncoderV2;

contract ICESmartContract {
    struct Company {
        uint256 id;
        string name;
    }

    struct Machine {
        uint256 id;
        string name;
        string description;
        uint256 companyId;
    }

    struct Recipe {
        uint256 id;
        string name;
        string description;
        uint256 companyId;
    }

    struct Product {
        uint256 id;
        string name;
        string description;
        uint256 companyId;
        uint256 recipeId;
    }

    struct RecipeStep {
        uint256 id;
        string name;
        string description;
        uint256 recipeId;
        uint256 machineId;
    }

    struct MeasureConstraint {
        uint256 id;
        string name;
        int256 maxMeasure;
        int256 minMeasure;
        string unitOfMeasure;
        uint256 recipeStepId;
        uint256 machineId;
    }

    struct Phase {
        uint256 id;
        string name;
        string description;
        uint256 productId;
        uint256 machineId;
        uint256 recipeStepId;
    }

    struct Measure {
        uint256 id;
        string name;
        string unitOfMeasure;
        uint256 measureStartTime;
        uint256 measureEndTime;
        uint256 phaseId;
        uint256 measureConstraintId;
    }

    // struct ProductInformation {
    //     Product product;
    //     Company company;
    //     Phase[] phases;
    //     Machine[] machinesUsed;
    //     Recipe recipeUsed;
    //     RecipeStep[] recipeSteps;
    //     Measure[] allMeasures;
    // }

    Company[] public companies;
    Machine[] public machines;
    Recipe[] public recipes;
    Product[] public products;
    RecipeStep[] public recipeSteps;
    MeasureConstraint[] public measureConstraints;
    Phase[] public phases;
    Measure[] public measures;

    uint256 private companyIdCounter;
    uint256 private machineIdCounter;
    uint256 private recipeIdCounter;
    uint256 private recipeStepIdCounter;
    uint256 private measureConstraintIdCounter;
    uint256 private productIdCounter;
    uint256 private phaseIdCounter;
    uint256 private measureIdCounter;

    function addCompany(string memory name) public returns (uint256 companyId) {
        companies.push(Company(companyIdCounter, name));
        companyIdCounter += 1;
        return companyIdCounter - 1;
    }

    function addMachine(
        uint256 companyId,
        string memory name,
        string memory description
    ) public returns (uint256 machineId) {
        machines.push(Machine(machineIdCounter, name, description, companyId));
        machineIdCounter += 1;
        return machineIdCounter - 1;
    }

    function addRecipe(
        uint256 companyId,
        string memory name,
        string memory description
    ) public returns (uint256 recipeId) {
        recipes.push(Recipe(recipeIdCounter, name, description, companyId));
        recipeIdCounter += 1;
        return recipeIdCounter - 1;
    }

    function addRecipeStep(
        uint256 recipeId,
        uint256 machineId,
        string memory name,
        string memory description
    ) public returns (uint256 recipeStepId) {
        recipeSteps.push(
            RecipeStep(
                recipeStepIdCounter,
                name,
                description,
                recipeId,
                machineId
            )
        );
        recipeStepIdCounter += 1;
        return recipeStepIdCounter - 1;
    }

    function addMeasureConstraint(
        uint256 recipeStepId,
        uint256 machineId,
        string memory name,
        int256 maxMeasure,
        int256 minMeasure,
        string memory unitOfMeasure
    ) public returns (uint256 measureId) {
        measureConstraints.push(
            MeasureConstraint(
                measureConstraintIdCounter,
                name,
                maxMeasure,
                minMeasure,
                unitOfMeasure,
                recipeStepId,
                machineId
            )
        );
        measureConstraintIdCounter += 1;
        return measureConstraintIdCounter - 1;
    }

    function addProduct(
        uint256 companyId,
        uint256 recipyId,
        string memory name,
        string memory description
    ) public returns (uint256 productId) {
        products.push(
            Product(productIdCounter, name, description, companyId, recipyId)
        );
        productIdCounter += 1;
        return productIdCounter - 1;
    }

    function addPhase(
        uint256 productId,
        uint256 machineId,
        uint256 recipeStepId,
        string memory name,
        string memory description
    ) public returns (uint256 phaseId) {
        phases.push(
            Phase(
                phaseIdCounter,
                name,
                description,
                productId,
                machineId,
                recipeStepId
            )
        );
        phaseIdCounter += 1;
        return phaseIdCounter - 1;
    }

    function addMeasure(
        uint256 phaseId,
        uint256 measureConstraintId,
        string memory name,
        string memory unitOfMeasure,
        uint256 measureStartTime,
        uint256 measureEndTime
    ) public returns (uint256 measureId) {
        measures.push(
            Measure(
                measureIdCounter,
                name,
                unitOfMeasure,
                measureStartTime,
                measureEndTime,
                phaseId,
                measureConstraintId
            )
        );
        measureIdCounter += 1;
        return measureIdCounter - 1;
    }

    function getCompanyById(uint256 companyId)
        public
        view
        returns (Company memory company)
    {
        for (
            uint256 companyIndex;
            companyIndex < companies.length;
            companyIndex++
        ) {
            if (companies[companyIndex].id == companyId) {
                return companies[companyIndex];
            }
        }
    }

    function getRecipesbyId(uint256 recipeId)
        public
        view
        returns (Recipe memory recipe)
    {
        for (uint256 recipeIndex; recipeIndex < recipes.length; recipeIndex++) {
            if (recipes[recipeIndex].id == recipeId) {
                return recipes[recipeIndex];
            }
        }
    }

    function getRecipeStepbyId(uint256 recipeStepId)
        public
        view
        returns (RecipeStep memory recipeStep)
    {
        for (
            uint256 recipeStepIndex;
            recipeStepIndex < recipeSteps.length;
            recipeStepIndex++
        ) {
            if (recipeSteps[recipeStepIndex].id == recipeStepId) {
                return recipeSteps[recipeStepIndex];
            }
        }
    }

    function getMeasureConstraintById(uint256 measureConstraintId)
        public
        view
        returns (MeasureConstraint memory measureConstraint)
    {
        for (
            uint256 measureConstraintIndex;
            measureConstraintIndex < measureConstraints.length;
            measureConstraintIndex++
        ) {
            if (
                measureConstraints[measureConstraintIndex].id ==
                measureConstraintId
            ) {
                return measureConstraints[measureConstraintIndex];
            }
        }
    }

    function getProductById(uint256 productId)
        public
        view
        returns (Product memory product)
    {
        for (
            uint256 productIndex;
            productIndex < products.length;
            productIndex++
        ) {
            if (products[productIndex].id == productId) {
                return products[productIndex];
            }
        }
    }

    function getPhaseById(uint256 phaseId)
        public
        view
        returns (Phase memory phase)
    {
        for (uint256 phaseIndex; phaseIndex < phases.length; phaseIndex++) {
            if (phases[phaseIndex].id == phaseId) {
                return phases[phaseIndex];
            }
        }
    }

    function getMeasureById(uint256 measureId)
        public
        view
        returns (Measure memory measure)
    {
        for (
            uint256 measureIndex;
            measureIndex < measures.length;
            measureIndex++
        ) {
            if (measures[measureIndex].id == measureId) {
                return measures[measureIndex];
            }
        }
    }

    function getMachineById(uint256 machineId)
        public
        view
        returns (Machine memory machine)
    {
        for (
            uint256 machineIndex;
            machineIndex < machines.length;
            machineIndex++
        ) {
            if (machines[machineIndex].id == machineId) {
                return machines[machineIndex];
            }
        }
    }

    function getNumOfProductsByCompanyId(uint256 companyId)
        private
        view
        returns (uint256 numOfProducts)
    {
        uint256 productCounter = 0;
        for (
            uint256 productIndex = 0;
            productIndex < products.length;
            productIndex++
        ) {
            if (products[productIndex].companyId == companyId) {
                productCounter += 1;
            }
        }
        return productCounter;
    }

    function getProductsByCompanyId(uint256 companyId)
        public
        view
        returns (Product[] memory)
    {
        uint256 numOfProducts = getNumOfProductsByCompanyId(companyId);
        Product[] memory productTemp = new Product[](numOfProducts);
        uint256 productCounter = 0;
        for (
            uint256 productIndex = 0;
            productIndex < products.length;
            productIndex++
        ) {
            if (products[productIndex].companyId == companyId) {
                productTemp[productCounter] = products[productIndex];
                productCounter += 1;
            }
        }
        return productTemp;
    }

    function getNumOfProductsByRecipeId(uint256 recipeId)
        private
        view
        returns (uint256 numOfProducts)
    {
        uint256 productCounter = 0;
        for (
            uint256 productIndex = 0;
            productIndex < products.length;
            productIndex++
        ) {
            if (products[productIndex].recipeId == recipeId) {
                productCounter += 1;
            }
        }
        return productCounter;
    }

    function getProductsByRecipyId(uint256 recipeId)
        public
        view
        returns (Product[] memory)
    {
        uint256 numOfProducts = getNumOfProductsByRecipeId(recipeId);
        Product[] memory productTemp = new Product[](numOfProducts);
        uint256 productCounter = 0;
        for (
            uint256 productIndex = 0;
            productIndex < products.length;
            productIndex++
        ) {
            if (products[productIndex].recipeId == recipeId) {
                productTemp[productCounter] = products[productIndex];
                productCounter += 1;
            }
        }
        return productTemp;
    }

    function getNumOfMachinesByCompanyId(uint256 companyId)
        public
        view
        returns (uint256 numOfMachines)
    {
        uint256 machineCounter = 0;

        for (
            uint256 machineIndex = 0;
            machineIndex < machines.length;
            machineIndex++
        ) {
            if (machines[machineIndex].companyId == companyId) {
                machineCounter += 1;
            }
        }
        return machineCounter;
    }

    function getMachinesByCompanyId(uint256 companyId)
        public
        view
        returns (Machine[] memory)
    {
        uint256 numOfMachine = getNumOfMachinesByCompanyId(companyId);
        Machine[] memory machineTemp = new Machine[](numOfMachine);
        uint256 machineCounter = 0;
        for (
            uint256 machineIndex = 0;
            machineIndex < machines.length;
            machineIndex++
        ) {
            if (machines[machineIndex].companyId == companyId) {
                machineTemp[machineCounter] = machines[machineIndex];
                machineCounter += 1;
            }
        }
        return machineTemp;
    }

    function getNumOfRecipesByCompanyId(uint256 companyId)
        public
        view
        returns (uint256 numOfRecepes)
    {
        uint256 counter = 0;

        for (
            uint256 recipesIndex = 0;
            recipesIndex < recipes.length;
            recipesIndex++
        ) {
            if (recipes[recipesIndex].companyId == companyId) {
                counter += 1;
            }
        }
        return counter;
    }

    function getRecipesByCompanyId(uint256 companyId)
        public
        view
        returns (Recipe[] memory)
    {
        uint256 numOfRecepies = getNumOfRecipesByCompanyId(companyId);
        Recipe[] memory recipeTemp = new Recipe[](numOfRecepies);
        uint256 recipeCounter = 0;
        for (
            uint256 recipeIndex = 0;
            recipeIndex < recipes.length;
            recipeIndex++
        ) {
            if (recipes[recipeIndex].companyId == companyId) {
                recipeTemp[recipeCounter] = recipes[recipeIndex];
                recipeCounter += 1;
            }
        }
        return recipeTemp;
    }

    function getNumOfRecipeStepsByRecipeId(uint256 recipeId)
        public
        view
        returns (uint256 numOfRecepes)
    {
        uint256 counter = 0;

        for (
            uint256 recipeIndex = 0;
            recipeIndex < recipeSteps.length;
            recipeIndex++
        ) {
            if (recipeSteps[recipeIndex].recipeId == recipeId) {
                counter += 1;
            }
        }
        return counter;
    }

    function getRecipeStepsByRecipeId(uint256 recipeId)
        public
        view
        returns (RecipeStep[] memory)
    {
        uint256 numOfRecipes = getNumOfRecipeStepsByRecipeId(recipeId);
        RecipeStep[] memory recipeTemp = new RecipeStep[](numOfRecipes);
        uint256 recipeCounter = 0;
        for (
            uint256 recipeIndex = 0;
            recipeIndex < recipeSteps.length;
            recipeIndex++
        ) {
            if (recipeSteps[recipeIndex].recipeId == recipeId) {
                recipeTemp[recipeCounter] = recipeSteps[recipeIndex];
                recipeCounter += 1;
            }
        }
        return recipeTemp;
    }

    function getNumOfRecipeStepsByMachineId(uint256 machineId)
        public
        view
        returns (uint256 numOfRecepes)
    {
        uint256 counter = 0;

        for (
            uint256 recipeIndex = 0;
            recipeIndex < recipeSteps.length;
            recipeIndex++
        ) {
            if (recipeSteps[recipeIndex].machineId == machineId) {
                counter += 1;
            }
        }
        return counter;
    }

    function getRecipeStepsByMachineId(uint256 machineId)
        public
        view
        returns (RecipeStep[] memory)
    {
        uint256 numOfRecipes = getNumOfRecipeStepsByMachineId(machineId);
        RecipeStep[] memory recipeTemp = new RecipeStep[](numOfRecipes);
        uint256 recipeCounter = 0;
        for (
            uint256 recipeIndex = 0;
            recipeIndex < recipeSteps.length;
            recipeIndex++
        ) {
            if (recipeSteps[recipeIndex].machineId == machineId) {
                recipeTemp[recipeCounter] = recipeSteps[recipeIndex];
                recipeCounter += 1;
            }
        }
        return recipeTemp;
    }

    function getNumOfMeasureConstraintByRecipeStepId(uint256 recipeStepId)
        public
        view
        returns (uint256 numOfMeasureConstraints)
    {
        uint256 counter = 0;

        for (
            uint256 measureConstraintIndex = 0;
            measureConstraintIndex < measureConstraints.length;
            measureConstraintIndex++
        ) {
            if (
                measureConstraints[measureConstraintIndex].recipeStepId ==
                recipeStepId
            ) {
                counter += 1;
            }
        }
        return counter;
    }

    function getMeasureConstraintsByRecipeStepId(uint256 recipeStepId)
        public
        view
        returns (MeasureConstraint[] memory)
    {
        uint256 numOfMeasureConstraints =
            getNumOfMeasureConstraintByRecipeStepId(recipeStepId);
        MeasureConstraint[] memory measureConstraintTemp =
            new MeasureConstraint[](numOfMeasureConstraints);
        uint256 measureConstraintCounter = 0;
        for (
            uint256 measureConstraintIndex = 0;
            measureConstraintIndex < measureConstraints.length;
            measureConstraintIndex++
        ) {
            if (
                measureConstraints[measureConstraintIndex].recipeStepId ==
                recipeStepId
            ) {
                measureConstraintTemp[
                    measureConstraintCounter
                ] = measureConstraints[measureConstraintIndex];
                measureConstraintCounter += 1;
            }
        }
        return measureConstraintTemp;
    }

    function getNumOfPhasesByProductId(uint256 productId)
        public
        view
        returns (uint256 numOfPhases)
    {
        uint256 counter = 0;

        for (uint256 phaseIndex = 0; phaseIndex < phases.length; phaseIndex++) {
            if (phases[phaseIndex].productId == productId) {
                counter += 1;
            }
        }
        return counter;
    }

    function getPhasesByProductId(uint256 productId)
        public
        view
        returns (Phase[] memory)
    {
        uint256 numOfPhases = getNumOfPhasesByProductId(productId);
        Phase[] memory phaseTemp = new Phase[](numOfPhases);
        uint256 phaseCounter = 0;
        for (uint256 phaseIndex = 0; phaseIndex < phases.length; phaseIndex++) {
            if (phases[phaseIndex].productId == productId) {
                phaseTemp[phaseCounter] = phases[phaseIndex];
                phaseCounter += 1;
            }
        }
        return phaseTemp;
    }

    function getNumOfPhasesByMachineId(uint256 machineId)
        public
        view
        returns (uint256 numOfPhases)
    {
        uint256 counter = 0;

        for (uint256 phaseIndex = 0; phaseIndex < phases.length; phaseIndex++) {
            if (phases[phaseIndex].machineId == machineId) {
                counter += 1;
            }
        }
        return counter;
    }

    function getPhasesByMachineId(uint256 machineId)
        public
        view
        returns (Phase[] memory)
    {
        uint256 numOfPhases = getNumOfPhasesByMachineId(machineId);
        Phase[] memory phaseTemp = new Phase[](numOfPhases);
        uint256 phaseCounter = 0;
        for (uint256 phaseIndex = 0; phaseIndex < phases.length; phaseIndex++) {
            if (phases[phaseIndex].machineId == machineId) {
                phaseTemp[phaseCounter] = phases[phaseIndex];
                phaseCounter += 1;
            }
        }
        return phaseTemp;
    }

    function getNumOfPhasesByRecipeStepId(uint256 recipeStepId)
        public
        view
        returns (uint256 numOfPhases)
    {
        uint256 counter = 0;

        for (uint256 phaseIndex = 0; phaseIndex < phases.length; phaseIndex++) {
            if (phases[phaseIndex].recipeStepId == recipeStepId) {
                counter += 1;
            }
        }
        return counter;
    }

    function getPhasesByRecipeStepId(uint256 recipeStepId)
        public
        view
        returns (Phase[] memory)
    {
        uint256 numOfPhases = getNumOfPhasesByRecipeStepId(recipeStepId);
        Phase[] memory phaseTemp = new Phase[](numOfPhases);
        uint256 phaseCounter = 0;
        for (uint256 phaseIndex = 0; phaseIndex < phases.length; phaseIndex++) {
            if (phases[phaseIndex].recipeStepId == recipeStepId) {
                phaseTemp[phaseCounter] = phases[phaseIndex];
                phaseCounter += 1;
            }
        }
        return phaseTemp;
    }

    function getNumOfMeasuresByPhaseId(uint256 phaseId)
        public
        view
        returns (uint256 numOfMeasures)
    {
        uint256 counter = 0;

        for (
            uint256 measureIndex = 0;
            measureIndex < measures.length;
            measureIndex++
        ) {
            if (measures[measureIndex].phaseId == phaseId) {
                counter += 1;
            }
        }
        return counter;
    }

    function getMeasuresByPhaseId(uint256 phaseId)
        public
        view
        returns (Measure[] memory)
    {
        uint256 numOfMeasures = getNumOfMeasuresByPhaseId(phaseId);
        Measure[] memory measureTemp = new Measure[](numOfMeasures);
        uint256 measureCounter = 0;
        for (
            uint256 measureIndex = 0;
            measureIndex < measures.length;
            measureIndex++
        ) {
            if (measures[measureIndex].phaseId == phaseId) {
                measureTemp[measureCounter] = measures[measureIndex];
                measureCounter += 1;
            }
        }
        return measureTemp;
    }

    function getNumOfMeasureConstraintsByMeasureConstraintId(
        uint256 measureConstraintId
    ) public view returns (uint256 numOfMeasures) {
        uint256 counter = 0;

        for (
            uint256 measureIndex = 0;
            measureIndex < measures.length;
            measureIndex++
        ) {
            if (
                measures[measureIndex].measureConstraintId ==
                measureConstraintId
            ) {
                counter += 1;
            }
        }
        return counter;
    }

    function getMeasuresByMeasureConstraintId(uint256 measureConstraintId)
        public
        view
        returns (Measure[] memory)
    {
        uint256 numOfMeasures =
            getNumOfMeasureConstraintsByMeasureConstraintId(
                measureConstraintId
            );
        Measure[] memory measureTemp = new Measure[](numOfMeasures);
        uint256 measureCounter = 0;
        for (
            uint256 measureIndex = 0;
            measureIndex < measures.length;
            measureIndex++
        ) {
            if (
                measures[measureIndex].measureConstraintId ==
                measureConstraintId
            ) {
                measureTemp[measureCounter] = measures[measureIndex];
                measureCounter += 1;
            }
        }
        return measureTemp;
    }

    // function getMachinesByListOfPhase(Phase[] memory phasesUsed)
    //     public
    //     view
    //     returns (Machine[] memory)
    // {
    //     Machine[] memory machinesUsed = new Machine[](phasesUsed.length);
    //     for (uint256 phaseIndex; phaseIndex < phasesUsed.length; phaseIndex++) {
    //         uint256 machineId = phasesUsed[phaseIndex].machineId;
    //         machinesUsed[phaseIndex] = getMachineById(machineId);
    //     }
    //     return machinesUsed;
    // }

    // function getRecipeStepsByListOfPhase(Phase[] memory phasesUsed)
    //     public
    //     view
    //     returns (RecipeStep[] memory)
    // {
    //     RecipeStep[] memory recipeStepsInPhases = new RecipeStep[](phasesUsed.length);
    //     for (uint256 phaseIndex; phaseIndex < phasesUsed.length; phaseIndex++) {
    //         uint256 recipeStepId = phasesUsed[phaseIndex].recipeStepId;
    //         recipeStepsInPhases[phaseIndex] = getRecipeStepbyId(recipeStepId);
    //     }
    //     return recipeStepsInPhases;
    // }

    // function getAllMeasuresByListOfPhase(Phase[] memory phasesUsed) private view returns (mapping(uint256 => Measure[]) storage){
    //     mapping(uint256 => Measure[]) storage prova;
    // }

    // function getProductInformationById(uint256 productId)
    //     public
    //     view
    //     returns (ProductInformation memory)
    // {
    //     Product memory product = getProductById(productId);
    //     Company memory company = getCompanyById(product.companyId);
    //     Phase[] memory phases = getPhasesByProductId(productId);
    //     Machine[] memory machines = getMachinesByListOfPhase(phases);
    //     Recipe memory recipe = getRecipesbyId(product.recipeId);
    //     RecipeStep[] memory recipeSteps = getRecipeStepsByListOfPhase(phases);

    // }
}
