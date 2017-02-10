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

    signal requestAddFoodAmount(string foodId);
    signal requestEditFoodAmount(int index);
    signal openFoodAmountPage();
    signal acceptFoodAmount(double amount);

    signal openDaySelectionPopup();
    signal selectDay(var day);

    // todo


    signal removeFood(string foodId);

    signal addRecipe(var data);
    signal editRecipe(string recipeId, var data);
    signal removeRecipe(string foodId);

    signal removeFoodFromLog(int index);
    signal removeRecipeFromLog(int index);

    signal updateUserProfile(var data);
}
