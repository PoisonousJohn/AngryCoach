pragma Singleton

import QuickFlux 1.1
import '../formHelper.js' as FormHelper
import '.'

AppListener {
    property var list: dataManager.food
    property var food
    property bool isEditing: food !== null && food !== undefined
    property var selectedFood

    function getFoodViewModel(foodId) {
        var foodObj = dataManager.getFoodById(foodId);
        var foodViewModel = {
            "Id": foodObj["Id"],
            "Name": foodObj["Name"],
            "Carbs": FormHelper.numberToString(foodObj["FoodCalories"]["Carbs"]),
            "Proteins": FormHelper.numberToString(foodObj["FoodCalories"]["Proteins"]),
            "Fats": FormHelper.numberToString(foodObj["FoodCalories"]["Fats"]),
            "TotalCalories":  FormHelper.numberToString(foodObj["FoodCalories"]["TotalCalories"]),
            "Weight": FormHelper.numberToString(foodObj["Weight"])
        };
        return foodViewModel;
    }

    onDispatched: {
        switch (type) {
            case "selectFood":
                var foodViewModel = getFoodViewModel(message.foodId);
                foodViewModel.Amount = 100;
                selectedFood = foodViewModel;
                break;
            case "openEditFoodPage":
                food = getFoodViewModel(message.foodId);
                break;
            case "cancelEditFood":
                food = null;
                break;
            case  "addFoodAmount":
                dataManager.addFoodToLog(DayLogStore.day, selectedFood.Id, FormHelper.getFloatFromText(message.amount));
                break;

        }

    }
}
