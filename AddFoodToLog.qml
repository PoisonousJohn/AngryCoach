import QtQuick 2.0

FoodList {
    id: addFoodToLog

    onItemSelected: {
        console.log("search food item selected default")
        chooseFoodAmount.foodId = item["Id"]
        chooseFoodAmount.loadPage({food: item})
    }

    PageLoader {
        id: chooseFoodAmount
        pagePath: "ChooseFoodAmount.qml"
        property string foodId;
        Connections {
            target: chooseFoodAmount.item
            onConfirmed: {
                dataManager.addFoodToLog(dataManager.selectedDate, chooseFoodAmount.foodId, amount);
                pageStack.pop();
            }
        }
    }
}
