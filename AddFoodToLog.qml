import QtQuick 2.0
import QuickFlux 1.0
import 'singletons'

FoodList {

    id: addFoodToLog

    onItemSelected: {
        AppActions.requestAddFoodAmount(item["Id"]);
    }
}
