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
        AppActions.openAddFoodPage();
    }

    onEditItem: {
        AppActions.openEditFoodPage(itemId);
    }

    onDeleteItem: {
        foodDeleteDialog.itemId = itemId;
        foodDeleteDialog.show(qsTr("Delete food?"), qsTr("Do you really want to delete this item?"))
    }

    PageLoader {
        id: addFood
        pagePath: "AddFood.qml"

        AppListener {
            onDispatched: {
                switch (type) {
                    case "openAddFoodPage":
                        addFood.loadPage({foodId: ""});
                        break;
                    case "openEditFoodPage":
                        addFood.loadPage({foodId: message.foodId});
                        break;
                }
            }
        }
    }

    DialogLoader {
        id: foodDeleteDialog
        property string itemId;
        onAccepted: {
            dataManager.removeFood(itemId)
        }
    }


}
