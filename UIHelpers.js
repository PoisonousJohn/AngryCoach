
.pragma library

function getRecipeStats(recipe, dataManager, serving) {
    return null
    var nutritionModel = ["Carbs", "Proteins", "Fats"];
    var recipeWeight = 0;
    var nutritionWeight = 0;
    var nutritionsData = {};
    var calories = 0;
    var servingFactor = serving / recipe["Servings"]
    for (var j = 0; j < recipe["Ingredients"].length; ++j)
    {
        var food = dataManager.getFoodById(recipe["Ingredients"][j]["FoodId"]);
        var foodAmount = recipe["Ingredients"][j]["Amount"];
        var amountFactor = foodAmount / food["Weight"];
        recipeWeight += foodAmount * servingFactor;

        calories += food["FoodCalories"]["TotalCalories"] * amountFactor * servingFactor;

        for (var i = 0; i < nutritionModel.length; ++i)
        {
            var nutritionKey = nutritionModel[i];
            var weight = food["FoodCalories"][nutritionKey] * amountFactor * servingFactor;
            nutritionWeight += weight;
            if (!(nutritionKey in nutritionsData))
            {
                nutritionsData[nutritionKey] = 0;
            }

            nutritionsData[nutritionKey] += weight;
        }
    }

    for (var i = 0; i < nutritionModel.length; ++i)
    {
        nutritionKey = nutritionModel[i];

        nutritionsData[nutritionKey] = parseFloat(nutritionsData[nutritionKey].toFixed(2));
    }

    return {
        "recipeWeight": parseFloat(recipeWeight.toFixed(2)),
        "nutritionWeight": parseFloat(nutritionWeight.toFixed(2)),
        "nutritions": nutritionsData,
        "calories": Math.round(calories),
    };
}

//11 1,2
