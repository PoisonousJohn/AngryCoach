import QtQuick 2.0
import QuickFlux 1.0

Item {
    PageLoader {
        id: recipeListLoader
        pagePath: "RecipesList.qml"
    }
    PageLoader {
        id: chooseRecipeAmount
        pagePath: "ChooseRecipeAmount.qml"
    }

    PageLoader {
        id: addRecipe
        pagePath: "AddRecipe.qml"
    }
    PageLoader {
        id: addFoodToLogLoader
        pagePath: "AddFoodToLog.qml"
    }
    PageLoader {
        id: chooseFoodAmount
        pagePath: "ChooseFoodAmount.qml"
    }
    Loader {
        id:datePickerLoader
        function load() {
            source = "DatePickerPopup.qml"
            item.open();
        }
    }
    PageLoader {
        id: addFood
        pagePath: "AddFood.qml"
    }

    AppListener {
        onDispatched: {
            switch (type) {
                case "openRecipePage":
                    addRecipe.loadPage();
                    break;
                case "openFoodPage":
                    addFood.loadPage();
                    break;
                case "openDaySelectionPopup":
                    datePickerLoader.load();
                    break;
                case "openFoodList":
                    addFoodToLogLoader.loadPage();
                    break;
                case "openRecipeList":
                    recipeListLoader.loadPage();
                    break;
                case "openFoodAmountPage":
                    chooseFoodAmount.loadPage();
                    break;
            }
        }
    }
}
