import QtQuick 2.0
import QuickFlux 1.0

Item {
    PageLoader {
        id: recipeListLoader
        pagePath: "RecipesList.qml"
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

    AppListener {
        onDispatched: {
            switch (type) {
                case "openDaySelectionPopup":
                    datePickerLoader.load();
                    break;
                case "openFoodList":
                    addFoodToLogLoader.loadPage();
                    break;
                case "openRecipeList":
                    recipeListLoader.loadPage();
                    break;
                case "selectFood":
                    chooseFoodAmount.loadPage();
                    break;
            }
        }
    }
}
