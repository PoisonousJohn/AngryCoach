import QtQuick 2.5
import QtQuick.Layouts 1.1
import Material 0.2
import QuickFlux 1.1
import 'stores'
import 'singletons'

EditableItemsList {
    id: searchFood
    model: FoodStore.list
    title: qsTr("Choose food to add")
    
    onAdd: {
        AppActions.openFoodPage("");
    }

    onEditItem: {
        AppActions.openFoodPage(itemId);
    }

    onDeleteItem: {
        foodDeleteDialog.itemId = itemId;
        foodDeleteDialog.show(qsTr("Delete food?"), qsTr("Do you really want to delete this item?"))
    }

    DialogLoader {
        id: foodDeleteDialog
        property string itemId;
        onAccepted: {
            dataManager.removeFood(itemId)
        }
    }


}
