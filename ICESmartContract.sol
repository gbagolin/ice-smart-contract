//SPDX-License-Identifier: LGPL-3.0-or-later
pragma solidity ^0.8.1;

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
        uint256 recipeId;
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

    function getMachineByCompanyId(uint256 companyId)
        public
        view
        returns (Machine[] memory)
    {
        uint256 numOfMachine = getNumOfProductsByRecipeId(companyId);
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
            recipesIndex < machines.length;
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
        uint256 recepieCounter = 0;
        for (
            uint256 recepieIndex = 0;
            recepieIndex < machines.length;
            recepieIndex++
        ) {
            if (recipes[recepieIndex].companyId == companyId) {
                recipeTemp[recepieCounter] = recipes[recepieIndex];
                recepieCounter += 1;
            }
        }
        return recipeTemp;
    }

    // function getNumOfRecipeStepsByRecipeId(uint256 recipeId)
    //     public
    //     view
    //     returns (uint256 numOfRecepes)
    // {
    //     uint256 counter = 0;

    //     for (
    //         uint256 recipesIndex = 0;
    //         recipesIndex < machines.length;
    //         recipesIndex++
    //     ) {
    //         if (recipes[recipesIndex].companyId == companyId) {
    //             counter += 1;
    //         }
    //     }
    //     return counter;
    // }

    function getCompanies() private view returns (Company[] memory) {
        return companies;
    }

    function getProducts() private view returns (Product[] memory) {
        return products;
    }
}
