import QtQuick 2.0
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.4
import Material 0.3
import Material.ListItems 0.1

Card {
    property date day: new Date()
    implicitHeight: content.implicitHeight
    anchors {
        left: parent.left
        right: parent.right
    }

    Connections {
        target: dataManager
        onDayLogChanged: {
            listview.model = dataManager.getDayLog(date)
        }
    }

    ColumnLayout {
        id: content

        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
        }

        Subheader {
            text: qsTr("Eaten today")
        }

        ListView {
            id: listview
            anchors {
                left: parent.left
                right: parent.right
            }
            implicitHeight: dp(100)
            model: dataManager.getDayLog(day)
            delegate: Standard {
                onPressAndHold: {
                    deleteDialog.itemIndex = index;
                    deleteDialog.show();
                }
                text: modelData["Name"]
                valueText: modelData["FoodCalories"]["TotalCalories"] + qsTr(" kcal")
            }
        }

        Standard {
            text: qsTr("Looks like you've eaten nothing");
            visible: listview.count == 0
        }
    }

    Dialog {
        property int itemIndex;
        onAccepted: {
            console.log("Delete item " + itemIndex)
            dataManager.removeFoodFromLog(day, itemIndex)
        }

        id: deleteDialog
        title: qsTr("Delete item?")
        text: qsTr("Do you really want to delete this item?")
    }


}
