pragma Singleton

import QtQuick 2.5
import QuickFlux 1.1
import '.'
import '../formHelper.js' as FormHelper
import '../singletons'

AppListener {
    property var day: dataManager.selectedDate
    property var log
    property var foodAmount

    function getFoodAmountModelView(index, foodId, amount) {
        return {
            "Index": index, // index in current day log
            "Food": FoodStore.getFoodViewModel(foodId),
            "Amount": amount
        };
    }

    onDayChanged: {
        log = dataManager.getDayLog(day);
    }

    onDispatched: {
        switch (type) {
            case "requestAddFoodAmount":
                foodAmount = getFoodAmountModelView(-1, message.foodId, 100);
                AppActions.openFoodAmountPage();
                break;
            case "requestEditFoodAmount":
                var logAmount = dataManager.getDayLog(day).Food[message.index];
                foodAmount = getFoodAmountModelView(message.index,
                                                    logAmount.FoodId,
                                                    logAmount.Amount);
                AppActions.openFoodAmountPage();
                break;
            case "selectDay":
                dataManager.selectedDate = message.day;
                break;
            case  "acceptFoodAmount":
                if (foodAmount.Index < 0)
                {
                    dataManager.addFoodToLog(day,
                                             foodAmount.Food.Id,
                                             FormHelper.getFloatFromText(message.amount));
                }
                else
                {
                    dataManager.editFoodAmount(day,
                                               foodAmount.Index,
                                               FormHelper.getFloatFromText(message.amount));
                }
                foodAmount = null;
                break;
        }
    }

    Connections {
        target: dataManager
        onDayLogChanged: {
            log = dataManager.getDayLog(day)
        }
    }


}
