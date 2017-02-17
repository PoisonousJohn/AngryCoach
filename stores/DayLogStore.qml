import QtQuick 2.5
import QuickFlux 1.1
import '.'
import '../formHelper.js' as FormHelper
import '../singletons'

AppListener {
    property var day: dataManager.selectedDate
    // general data about log
    property var log
    // food list in the log
    property var foodList
    // recipes list in the log
    property var recipesList

    // properties for editing food amount in the log
    property var foodAmount
    property var recipeAmount

    function updateAllValues(day) {
        var viewModel = {}
        var dayLog = dataManager.getDayLog(day);

        var totalCalories = 0;
        var carbs = 0;
        var fats = 0;
        var proteins = 0;
        var weight = 0;

        if (!foodList)
        {
            foodList = createListModel(dayLogStore);
        }

        if (!recipesList)
        {
            recipesList = createListModel(dayLogStore);
        }

        foodList.clear();
        recipesList.clear();

        for (var i = 0; i < dayLog.Food.length; ++i)
        {
            var foodAmount = foodStore.getFoodAmountViewModel(
                        i,
                        dayLog.Food[i].FoodId,
                        dayLog.Food[i].Amount
            );
            totalCalories += foodAmount.TotalCalories;
            carbs += foodAmount.Carbs;
            fats += foodAmount.Fats;
            proteins += foodAmount.Proteins;
            weight += foodAmount.Weight;
            foodList.append(foodAmount);
        }

        for (i = 0; i < dayLog.Recipes.length; ++i)
        {
            var recipeAmount = recipesStore.getRecipeAmountViewModel(
                        i,
                        dayLog.Recipes[i].FoodId,
                        dayLog.Recipes[i].Amount
            );
            totalCalories += recipeAmount.TotalCalories;
            carbs += recipeAmount.Carbs;
            fats += recipeAmount.Fats;
            proteins += recipeAmount.Proteins;
            weight += recipeAmount.Weight;
            recipesList.append(recipeAmount);
        }

        viewModel.Carbs = carbs;
        viewModel.Proteins = proteins;
        viewModel.Fats = fats;
        viewModel.TotalCalories = totalCalories;
        viewModel.Weight = weight;

        log = viewModel;
    }

    function updateFoodStats(food, removing) {
        var modifier = removing ? -1 : 1;
        log.Carbs += food.Carbs * modifier;
        log.Proteins += food.Proteins * modifier;
        log.Fats += food.Fats * modifier;
        log.TotalCalories += food.TotalCalories * modifier;
        log.Weight += food.Weight * modifier;
        dayLogStore.logChanged();
    }

    id: dayLogStore

    Component.onCompleted: {
        updateAllValues(day);
    }

    onDayChanged: {
        updateAllValues(day);
    }

    onDispatched: {
        var amountModel = null;
        switch (type) {
            case "askToRemoveFoodFromLog":
                AppActions.openConfirmationDialog(
                            qsTr("Confirm deletion"),
                            qsTr("Delete this entry from your day log?"),
                            function() { AppActions.removeFoodFromLog(message.index) });
                break;
            case "askToRemoveRecipeFromLog":
                AppActions.openConfirmationDialog(
                            qsTr("Confirm deletion"),
                            qsTr("Delete this entry from your day log?"),
                            function() { AppActions.removeRecipeFromLog(message.index) });
                break;
            case "removeRecipeFromLog":
                updateFoodStats(recipesList.get(message.index), true);
                dataManager.removeRecipeFromLog(day, message.index);
                recipesList.remove(message.index);
                break;
            case "removeFoodFromLog":
                updateFoodStats(foodList.get(message.index), true);
                dataManager.removeFoodFromLog(day, message.index);
                foodList.remove(message.index);
                break;
            case "requestAddRecipeAmount":
                recipeAmount = recipesStore.getRecipeAmountViewModel(-1, message.recipeId, 1);
                AppActions.openRecipeAmountPage();
                break;
            case "requestEditRecipeAmount":
                var recipeAmountInLog = dataManager.getDayLog(day).Recipes[message.index];
                recipeAmount = recipesStore.getRecipeAmountViewModel(
                            message.index,
                            recipeAmountInLog.FoodId,
                            recipeAmountInLog.Amount);
                AppActions.openRecipeAmountPage();
                break;
            case "requestAddFoodAmount":
                foodAmount = foodStore.getFoodAmountViewModel(-1, message.foodId, 100);
                AppActions.openFoodAmountPage();
                break;
            case "requestEditFoodAmount":
                var logAmount = dataManager.getDayLog(day).Food[message.index];
                foodAmount = foodStore.getFoodAmountViewModel(message.index,
                                                    logAmount.FoodId,
                                                    logAmount.Amount);
                AppActions.openFoodAmountPage();
                break;
            case "acceptRecipeAmount":
                if (recipeAmount.Index < 0) {
                    dataManager.addRecipeToLog(	day,
                                                recipeAmount.Recipe.Id,
                                                message.amount);
                    amountModel = recipesStore.getRecipeAmountViewModel(
                                    recipesList.count,
                                    recipeAmount.Recipe.Id,
                                    message.amount);
                    recipesList.append(amountModel);
                    updateFoodStats(amountModel.Recipe, false);
                } else {
                    updateFoodStats(recipesList.get(recipeAmount.Index), true);
                    dataManager.editRecipeAmount(	day,
                                                    recipeAmount.Index,
                                                    message.amount);
                    amountModel = recipesStore.getRecipeAmountViewModel(
                                    recipeAmount.Index,
                                    recipeAmount.Recipe.Id,
                                    message.amount);
                    recipesList.remove(recipeAmount.Index);
                    recipesList.insert(recipeAmount.Index, amountModel);
                    updateFoodStats(amountModel.Recipe, false);
                }
                recipeAmount = null;
                break;
            case "selectDay":
                dataManager.selectedDate = message.day;
                break;
            case  "addFoodAmountToDayLog":

                if (foodAmount.Index < 0)
                {
                    dataManager.addFoodToLog(day, foodAmount.Food.Id, message.amount);
                    amountModel = foodStore.getFoodAmountViewModel(
                                foodList.count,
                                foodAmount.Food.Id,
                                message.amount
                    );
                    foodList.append(amountModel);
                    updateFoodStats(amountModel.Food, false);
                }
                else
                {
                    updateFoodStats(foodList.get(foodAmount.Index), true);
                    dataManager.editFoodAmount(day, foodAmount.Index, message.amount);
                    amountModel = foodStore.getFoodAmountViewModel(
                                foodAmount.Index,
                                foodAmount.Food.Id,
                                message.amount
                    );
                    foodList.remove(foodAmount.Index);
                    foodList.insert(foodAmount.Index, amountModel);
                    updateFoodStats(amountModel, false);
                }
                foodAmount = null;
                break;
        }
    }


}
