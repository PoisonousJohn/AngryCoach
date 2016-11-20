import QtQuick 2.5
import QtQuick.Layouts 1.1
import Material 0.2
import QtQuick.Controls.Styles.Material 0.1 as MaterialStyle

ChooseFood {
    id: searchFood
    model: dataManager.food
    title: qsTr("Choose food to add")
    onAdd: {
        addFood.loadPage({foodId: ""})
    }
    
    onItemSelected: {
        chooseFoodAmount.loadPage({food: item})
    }
    onEditItem: {
        addFood.loadPage({foodId: itemId})
    }
    onDeleteItem: {
        foodDeleteDialog.itemId = itemId;
        foodDeleteDialog.show(qsTr("Delete food?"), qsTr("Do you really want to delete this item?"))
    }

    PageLoader {
        id: chooseFoodAmount
        pagePath: "ChooseFoodAmount.qml"
    }
    PageLoader {
        id: addFood
        pagePath: "AddFood.qml"
    }
    DialogLoader {
        id: foodDeleteDialog
        property string itemId;
        onAccepted: {
            dataManager.removeFood(itemId)
        }
    }

}
