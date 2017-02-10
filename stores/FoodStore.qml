pragma Singleton

import QuickFlux 1.1
import '../formHelper.js' as FormHelper

AppListener {
    property var list: dataManager.food
    property var food

    function getFoodViewModel(foodId) {
        var foodObj = foodId ? dataManager.getFoodById(foodId) : null;
        var foodViewModel = {
            "Id": foodId ? foodObj["Id"] : "",
            "Name": foodId ? foodObj["Name"] : "",
            "Carbs": foodId ? foodObj["FoodCalories"]["Carbs"] : "",
            "Proteins": foodId ? foodObj["FoodCalories"]["Proteins"] : "",
            "Fats": foodId ? foodObj["FoodCalories"]["Fats"] : "",
            "TotalCalories":  foodId ? foodObj["FoodCalories"]["TotalCalories"] : "",
            "Weight": foodId ? foodObj["Weight"] : 100
        };
        return foodViewModel;
    }

    onDispatched: {
        switch (type) {
            case "openFoodPage":
                food = getFoodViewModel(message.foodId);
                break;
            case "acceptFoodPageValues":
                if (food.Id)
                {
                    dataManager.editFood(food.Id, message.data);
                }
                else
                {
                    dataManager.addFood(message.data);
                }
                break;

        }

    }
}
