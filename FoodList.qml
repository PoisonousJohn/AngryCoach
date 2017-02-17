import QtQuick 2.5
import QtQuick.Layouts 1.1
import Material 0.2
import QuickFlux 1.1
import 'stores'
import 'singletons'

EditableItemsList {
    id: searchFood
    model: foodStore.list
    title: qsTr("Choose food to add")
    
    onAdd: {
        AppActions.openFoodPage("");
    }

    onEditItem: {
        AppActions.openFoodPage(itemId);
    }

    onDeleteItem: {
        AppActions.askToRemoveFood(itemId);
    }


}
