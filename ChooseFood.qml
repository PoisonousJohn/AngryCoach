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

            Text {
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.margins: 16 * Units.dp
                anchors.verticalCenter: parent.verticalCenter
                text: {
                    return modelData["Name"];
                }
            }

            Button {
                anchors.rightMargin: dp(10)
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                width: editIcon.width + dp(10)
                Icon {
                    id: editIcon
                    anchors.centerIn: parent
                    name: "editor/mode_edit"
                }
            }

        }
    }

    onItemSelected: {
        console.log("Adding food to log: " + item["Id"] + " for date " + dayLog.day);
        chooseFoodAmount.food = item;
        pageStack.push(chooseFoodAmount);
        //            dataManager.addFoodToLog(dayLog.day, item["Id"])
        //            pageStack.pop()
    }
    
    StandardActionButton {
        AwesomeIcon {
            anchors.centerIn: parent
            name: "plus"
        }
        
        onClicked: {
            pageStack.push(addFood)
        }
    }
}
