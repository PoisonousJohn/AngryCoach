import QtQuick 2.5
import QuickFlux 1.1
import '../formHelper.js' as FormHelper
import '../singletons'

AppListener {
    property var list: dataManager.recipes
    property var recipe
    property int foodIndex: -1
    property var foodAmount
    property var ingredients

    function getRecipeAmountViewModel(index, recipeId, amount) {
        var viewModel = {};
        var recipe = getRecipeViewModel(recipeId);
        var amountFactor = recipe ? amount / recipe.Servings : 1;
        var ingredients = [];
        recipe.Ingredients.forEach(function(item, i, arr) {
            ingredients.push(foodStore.getFoodAmountViewModel(i, item.Food.Id, item.Amount * amountFactor));
        });

        return {
            "Index": index, // index in current day log
            "Recipe": recipe,
            "Amount": amount,
            "Ingredients": ingredients,
            "Carbs": recipe ? recipe.Carbs * amountFactor : 0,
            "Fats": recipe ? recipe.Fats * amountFactor : 0,
            "Proteins": recipe ? recipe.Proteins * amountFactor : 0,
            "TotalCalories": recipe ? recipe.TotalCalories * amountFactor : 0,
            "NutritionsWeight": recipe ? recipe.NutritionsWeight * amountFactor : 0,
            "Weight": recipe ? recipe.Weight * amountFactor : 0,
        };
    }

    function getRecipeViewModel(recipeId) {
        var recipeObj = recipeId ? dataManager.getRecipeById(recipeId) : null;

        var ingredients = [];
        var totalCalories = 0;
        var carbs = 0;
        var proteins = 0;
        var fats = 0;
        var weight = 0;
        var nutritionsWeight = 0;

        if (recipeObj) {
            for (var i = 0; i < recipeObj.Ingredients.length; ++i) {
                var ingredient = foodStore.getFoodAmountViewModel(
                            i,
                            recipeObj.Ingredients[i].FoodId,
                            recipeObj.Ingredients[i].Amount
                );
                ingredients.push(ingredient);
                totalCalories += ingredient.TotalCalories;
                fats += ingredient.Fats;
                carbs += ingredient.Carbs;
                proteins += ingredient.Proteins;
                weight += ingredient.Weight;
                nutritionsWeight += ingredient.NutritionsWeight;
            }
        }

        var recipeViewModel = {
            "Id": recipeObj ? recipeObj["Id"] : "",
            "Name": recipeObj ? recipeObj["Name"] : "",
            "Ingredients": ingredients,
            "Servings": recipeObj ? recipeObj["Servings"] :  1,
            "TotalCalories": totalCalories,
            "Carbs": carbs,
            "Proteins": proteins,
            "Fats": fats,
            "Weight": weight,
            "NutritionsWeight": nutritionsWeight,
        };
        return recipeViewModel;
    }

    id: recipesStore

    onDispatched: {
        switch (type) {
            case "requestEditFoodAmountInRecipe":
                foodIndex = message.index;
                recipesStore.foodAmount = foodStore.getFoodAmountViewModel(message.index,
                                                    ingredients.get(foodIndex).FoodId,
                                                    ingredients.get(foodIndex).Amount);
                AppActions.openFoodAmountPage();
                break;
            case "askToRemoveRecipe":
                AppActions.openConfirmationDialog(
                            qsTr("Delete this food?"),
                            qsTr("Are you sure you want to delete this recipe? All your records related with this recipe will be lost"),
                            function() {
                                AppActions.removeRecipe(message.recipeId);
                            }
                );
                break;
            case "removeRecipe":
                dataManager.removeRecipe(message.recipeId);
                break;

            case "requestAddFoodAmount":
                if (!recipesStore.recipe)
                {
                    return;
                }
                foodIndex = -1;
                recipesStore.foodAmount = foodStore.getFoodAmountViewModel(-1, message.foodId, 100);
                AppActions.openFoodAmountPage();
                break;

            case "acceptRecipePageValues":
                // message contains only info directly related to the recipe
                // ingredients model is places right in this store
                var ingredientsList = []
                for (var i = 0; i < ingredients.count; ++i) {
                    var ingredient = ingredients.get(i);
                    ingredientsList.push(ingredient);
                }
                var data = message.data;
                data.Ingredients = ingredientsList;
                if (recipe.Id)
                {
                    dataManager.editRecipe(recipe.Id, data);
                }
                else
                {
                    dataManager.addRecipe(data);
                }
                recipe = null;
                break;
            case "acceptFoodAmount":
                if (recipe) {

                    var foodAmount = foodStore.getFoodAmountViewModel(foodIndex, message.foodId, message.amount);
                    if (foodIndex < 0)
                    {
                        ingredients.append(foodAmount);
                    }
                    else
                    {
                        ingredients.remove(foodAmount.Index);
                        ingredients.insert(foodAmount.Index, foodAmount);
                    }

                } else {
                    // forward message to day log
                    AppActions.addFoodAmountToDayLog(message.amount);
                }
                foodAmount = null;
                break;
            case "openRecipePage":
                recipe = getRecipeViewModel(message.recipeId);
                if (!ingredients)
                {
                    ingredients = createListModel(recipesStore);
                }
                ingredients.clear();
                var recipeIngredients = recipe["Ingredients"];
                for (var i = 0; i < recipeIngredients.length; ++i)
                {
                    ingredients.append(recipeIngredients[i]);
                }

                break;
            case "discardRecipePage":
                recipe = null;
                break;
            case "acceptRecipePageValues":
                data = {
                    "Name": message.Name,
                    "Servings": message.Servings,
                    "Ingredients": ingredients
                };

                if (recipe.Id)
                {
                    dataManager.editRecipe(recipe.Id, data);
                }
                else
                {
                    dataManager.addRecipe(data);
                }
                recipe = null;
                break;

        }

    }

}
