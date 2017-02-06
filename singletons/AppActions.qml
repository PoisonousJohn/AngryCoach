pragma Singleton

import QtQuick 2.0
import QuickFlux 1.0

ActionCreator {
    signal openAddFoodPage();
    signal openEditFoodPage(string foodId);
    signal cancelEditFood();
    signal openAddFoodToLogPage();
    signal openAddRecipeToLogPage();

    signal addFood(var data);
    signal editFood(string foodId, var data);
    signal removeFood(string foodId);

    signal addRecipe(var data);
    signal editRecipe(string recipeId, var data);
    signal removeRecipe(string foodId);

    signal addFoodToLog(date date, string foodId, double amount);
    signal addRecipeToLog(date date, string foodId, double amount);
    signal removeFoodFromLog(date date, int index);
    signal removeRecipeFromLog(date date, int index);
    signal editFoodAmountInLog(date date, int index, double amount);
    signal editRecipeAmountInLog(date date, int index, double amount);

    signal updateUserProfile(var data);
}
