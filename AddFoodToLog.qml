import QtQuick 2.0
import QuickFlux 1.0
import 'singletons'

FoodList {
    id: addFoodToLog

    onItemSelected: {
        AppActions.selectFood(item["Id"]);
    }

    AppListener {
        onDispatched: {
            if (type === "addFoodAmount") {
                MainPageStack.pageStack.pop();
            }
        }
    }

}
