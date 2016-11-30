import QtQuick 2.5
import QtQml.Models 2.2
import QtQuick.Layouts 1.1
import Material 0.3
import Material.ListItems 0.1
import QtQuick.Controls.Styles.Material 0.1 as MaterialStyle

SearchList {
    id: editableItemsList
    signal add();
    signal editItem(string itemId);
    signal deleteItem(string itemId);
    visible: false
    defaultModelField: "Name"
    listView {
        delegateModel.delegate: StandardWithDivider {
            id: listDelegate
            property int modelIndex: DelegateModel.itemsIndex
            height: 50 * Units.dp
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
                    if (!modelData)
                    {
                        if (!listDelegate.DelegateModel.inSearchFilter)
                        {
                            return "Not found in filter"
                        }

                        var obj = editableItemsList.searchGroup.get(0);
                        var data = listDelegate.DelegateModel.model.modelData;
                        return data["Name"];
                    }

                    return modelData["Name"];
//                    return modelData ? modelData["Name"] : "";
                }
            }
        }
    }

    BottomActionSheet {
        id: contextMenu
        property string foodId;
        actions: [
            Action {
                name: qsTr("Edit")
                onTriggered: {
                    editItem(contextMenu.foodId);
                }
            },
            Action {
                name: qsTr("Delete")
                onTriggered: {
                    deleteItem(contextMenu.foodId)
                }
            }

        ]
    }


    StandardActionButton {
        AwesomeIcon {
            anchors.centerIn: parent
            color: Palette.colors.white["500"]
            name: "plus"
        }
        
        onClicked: {
            add();
        }
    }

}
