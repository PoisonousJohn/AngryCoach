import QtQuick 2.0
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.4
import Material 0.3
import Material.ListItems 0.1

Card {
    property date day: dataManager.selectedDate
    implicitHeight: content.implicitHeight - dp(3)
    anchors {
        left: parent.left
        right: parent.right
    }

    Connections {
        target: dataManager
        onDayLogChanged: {
            if (date.getTime() !== dataManager.selectedDate.getTime())
            {
                return;
            }

            listview.model = dataManager.getDayLog(date)
        }

        onSelectedDateChanged: {
            listview.model = dataManager.getDayLog(dataManager.selectedDate)
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
            elevation: 1
            backgroundColor: Palette.colors["purple"]["200"]
            text: qsTr("Eaten today")
        }

        Repeater {
            id: listview
            clip: true
//            model: 0
//            implicitHeight: contentHeight
            anchors {
                left: parent.left
                right: parent.right
            }
//            implicitHeight: dp(100)
            visible: count > 0
            delegate: FoodAmountRow {
                id: listViewDelegate
                food: getFood()
                modelItem: modelData
                function getFood() {
                    var food = dataManager.getFoodById(modelData["FoodId"]);
                    return food
                }

                onPressAndHold: {
                    deleteDialog.itemIndex = index;
                    deleteDialog.show();
                }
//                text: food["Name"]
//                valueText:
//                {
//                    modelData["Amount"] + qsTr(" g") + " (" + Math.round(food["FoodCalories"]["TotalCalories"] * (modelData["Amount"] / 100) ) + qsTr(" kcal") + ")"
//                }
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
            dataManager.removeFoodFromLog(day, itemIndex)
        }

        id: deleteDialog
        title: qsTr("Delete item?")
        text: qsTr("Do you really want to delete this item?")
    }


}
