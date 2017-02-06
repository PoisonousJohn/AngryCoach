import QuickFlux 1.1
import '../formHelper.js' as FormHelper

Store {
    property var list: dataManager.food
    property var food
    property bool isEditing: food !== null && food !== undefined

    Filter {
        type: "openEditFoodPage"
        onDispatched: {
            var foodObj = dataManager.getFoodById(message.foodId);
            var foodViewModel = {
                "Id": foodObj["Id"],
                "Name": foodObj["Name"],
                "Carbs": FormHelper.numberToString(foodObj["FoodCalories"]["Carbs"]),
                "Proteins": FormHelper.numberToString(foodObj["FoodCalories"]["Proteins"]),
                "Fats": FormHelper.numberToString(foodObj["FoodCalories"]["Fats"]),
                "TotalCalories":  FormHelper.numberToString(foodObj["FoodCalories"]["TotalCalories"]),
                "Weight": FormHelper.numberToString(foodObj["Weight"])
            };
            food = foodViewModel;
        }
    }

    Filter {
        type: "cancelEditFood"
        onDispatched: {
            food = null;
        }
    }

}
