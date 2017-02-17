pragma Singleton

import QtQuick 2.0
import QuickFlux 1.0

ActionCreator {
    // ported

    signal openFoodList();
    signal openRecipeList();

    signal openFoodPage(string foodId);
    signal acceptFoodPageValues(var data);

    signal openRecipePage(string recipeId);
    signal acceptRecipePageValues(var data);
    signal discardRecipePage();

    signal requestAddFoodAmount(string foodId);
    signal requestEditFoodAmount(int index);
    signal openFoodAmountPage();
    signal acceptFoodAmount(string foodId, double amount);
    signal addFoodAmountToDayLog(double amount);

    signal requestAddRecipeAmount(string recipeId);
    signal requestEditRecipeAmount(int index);
    signal openRecipeAmountPage();
    signal acceptRecipeAmount(string recipeId, double amount);

    signal openDaySelectionPopup();
    signal selectDay(var day);

    signal askToRemoveFoodFromLog(int index);
    signal askToRemoveRecipeFromLog(int index);
    signal removeFoodFromLog(int index);
    signal removeRecipeFromLog(int index);

    signal openUserProfile();
    signal lockUserProfilePage();

    signal updateUserProfile(var data);

    signal openConfirmationDialog(string title, string message, var onConfirmAction);

    signal askToRemoveFood(string foodId);
    signal removeFood(string foodId);
    signal askToRemoveRecipe(string recipeId);
    signal removeRecipe(string recipeId);

    // todo

}
