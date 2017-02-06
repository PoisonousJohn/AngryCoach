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

    AppListener {
        onDispatched: {
            switch (type) {
                case "openAddFoodToLogPage":
                    addFoodToLogLoader.loadPage();
                    break;
                case "openAddRecipeToLogPage":
                    recipeListLoader.loadPage();
                    break;
            }
        }
    }
}
