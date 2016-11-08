
.pragma library

function getRecipeStats(recipe, dataManager, serving) {
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

    return {
        "recipeWeight": recipeWeight,
        "nutritionWeight": nutritionWeight,
        "nutritions": nutritionsData,
        "calories": calories,
    };
}
