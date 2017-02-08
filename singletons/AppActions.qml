pragma Singleton

import QtQuick 2.0
import QuickFlux 1.0

ActionCreator {
    signal openFoodList();
    signal openRecipeList();

    signal openAddFoodPage();
    signal openEditFoodPage(string foodId);
    signal cancelEditFood();

    signal selectFood(string foodId);
    signal deselectFood();
    signal addFoodAmount(double amount);

    signal openDaySelectionPopup();
    signal selectDay(var day);

    signal addFood(var data);
    signal editFood(string foodId, var data);
    signal removeFood(string foodId);

    signal addRecipe(var data);
    signal editRecipe(string recipeId, var data);
    signal removeRecipe(string foodId);

    signal addFoodToLog(string foodId, double amount);
    signal addRecipeToLog(string foodId, double amount);
    signal removeFoodFromLog(int index);
    signal removeRecipeFromLog(int index);
    signal editFoodAmountInLog(int index, double amount);
    signal editRecipeAmountInLog(int index, double amount);

    signal updateUserProfile(var data);
}
