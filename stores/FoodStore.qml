import QuickFlux 1.1
import '../formHelper.js' as FormHelper
import '../singletons'

AppListener {
    property var list: dataManager.food
    property var food


    function getFoodAmountViewModel(index, foodId, amount) {
        var food = getFoodViewModel(foodId)
        var amountFactor = food ? amount / food.Weight : 1;
        return {
            "Index": index, // index in current day log
            "FoodId": food.Id,
            "Food": food,
            "Amount": amount,
            "Carbs": food ? food.Carbs * amountFactor : 0,
            "Fats": food ? food.Fats * amountFactor : 0,
            "Proteins": food ? food.Proteins * amountFactor : 0,
            "TotalCalories": food ? food.TotalCalories * amountFactor : 0,
            "Weight": food ? food.Weight * amountFactor : 0,
            "NutritionsWeight": food ? food.NutritionsWeight * amountFactor : 0,
        };
    }

    function getFoodViewModel(foodId) {
        var foodObj = foodId ? dataManager.getFoodById(foodId) : null;
        var foodViewModel = {
            "Id": foodId ? foodObj.Id : "",
            "Name": foodId ? foodObj.Name : "",
            "Carbs": foodId ? foodObj.FoodCalories.Carbs : 0,
            "Proteins": foodId ? foodObj.FoodCalories.Proteins : 0,
            "Fats": foodId ? foodObj.FoodCalories.Fats : 0,
            "TotalCalories":  foodId ? foodObj.FoodCalories.TotalCalories : 0,
            "NutritionsWeight": foodId
                                       ? (foodObj.FoodCalories.Carbs
                                          + foodObj.FoodCalories.Proteins
                                          + foodObj.FoodCalories.Fats)
                                       : 0,
            "Weight": foodId ? foodObj.Weight : 100
        };
        return foodViewModel;
    }

    onDispatched: {
        switch (type) {
            case "askToRemoveFood":
                AppActions.openConfirmationDialog(
                            qsTr("Delete this food?"),
                            qsTr("Are you sure you want to delete this food? All your records and recipes related with this food will be lost"),
                            function() {
                                AppActions.removeFood(message.foodId);
                            }
                );
                break;
            case "removeFood":
                dataManager.removeFood(message.foodId);
                break;
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
