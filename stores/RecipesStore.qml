pragma Singleton

import QuickFlux 1.1
import '../formHelper.js' as FormHelper

AppListener {
    property var list: dataManager.recipes
    property var recipe

    function getRecipeViewModel(recipeId) {
        var recipeObj = recipeId ? dataManager.getRecipeById(recipeId) : null;
        var recipeViewModel = {
            "Id": recipeObj ? recipeObj["Id"] : "",
            "Name": recipeObj ? recipeObj["Name"] : "",
            "Ingredients": recipeObj ? recipeObj["Ingredients"] : [],
        };
        return recipeViewModel;
    }

    onDispatched: {
        switch (type) {
            case "openRecipePage":
                recipe = getRecipeViewModel(message.recipeId);
                break;
            case "acceptRecipePageValues":
                if (recipe.Id)
                {
                    dataManager.editRecipe(recipe.Id, message.data);
                }
                else
                {
                    dataManager.addRecipe(recipe.data);
                }
                break;

        }

    }
}
