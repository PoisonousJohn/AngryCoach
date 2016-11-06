import QtQuick 2.5
import QtQuick.Layouts 1.1
import Material 0.3
import Material.ListItems 0.1
import QtQuick.Controls.Styles.Material 0.1 as MaterialStyle

SearchList {
    id: searchFood
    title: qsTr("Choose food")
    visible: false
    model: dataManager.food
    defaultModelField: "Name"
    listView {
        delegate: BaseListItem {
            id: listDelegate
            elevation: 1
            property int modelIndex: index
            height: dp(50)
            onClicked: {
                listView.itemClicked(modelIndex)
            }
            onPressAndHold: {
                contextMenu.foodId = modelData["Id"];
                contextMenu.title = modelData["Name"];
                contextMenu.open();
            }

            Text {
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.margins: 16 * Units.dp
                anchors.verticalCenter: parent.verticalCenter
                text: {
                    return modelData["Name"];
                }
            }
        }
    }

    onItemSelected: {
        console.log("Adding food to log: " + item["Id"] + " for date " + dayLog.day);
        chooseFoodAmount.food = item;
        pageStack.push(chooseFoodAmount);
    }

    BottomActionSheet {
        id: contextMenu
        property string foodId;
        actions: [
            Action {
                name: qsTr("Edit")
                onTriggered: {
                    addFood.foodId = contextMenu.foodId;
                    pageStack.push(addFood);
                }
            },
            Action {
                name: qsTr("Delete")
                onTriggered: {
                    deleteDialog.foodId = contextMenu.foodId;
                    deleteDialog.show();
                }
            }

        ]
    }
    
    StandardActionButton {
        AwesomeIcon {
            anchors.centerIn: parent
            name: "plus"
        }
        
        onClicked: {
            addFood.foodId = ""
            pageStack.push(addFood)
        }
    }

    Dialog {
        property string foodId;
        onAccepted: {
            dataManager.removeFood(foodId)
        }

        id: deleteDialog
        title: qsTr("Delete item?")
        text: qsTr("Do you really want to delete this item?")
    }
}
