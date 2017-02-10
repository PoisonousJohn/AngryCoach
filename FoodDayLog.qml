import QtQuick 2.0
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.4
import Material 0.3
import Material.ListItems 0.1
import "UIHelpers.js" as UIHelpers
import 'stores'
import 'singletons'

Card {
    property var log: DayLogStore.log
    property date day: dataManager.selectedDate

    function updateDayModel() {
        listview.model = null;
        recipesList.model = null;
        listview.model = log["Food"];
        recipesList.model = log["Recipes"]
    }

    Component.onCompleted:  {
        updateDayModel();
    }

    implicitHeight: content.implicitHeight - dp(3)
    anchors {
        left: parent.left
        right: parent.right
    }


    onLogChanged: {
        updateDayModel();
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
            backgroundColor: Palette.colors["lightBlue"]["100"]
            text: qsTr("Eaten today")
        }

        Repeater {
            id: listview
            clip: true
            anchors {
                left: parent.left
                right: parent.right
            }
            visible: listview.count > 0
            delegate: FoodAmountRow {
                food: getFood()
                modelItem: modelData
                function getFood() {
                    var food = dataManager.getFoodById(modelData["FoodId"]);
                    return food;
                }

                onClicked: {
                    AppActions.requestEditFoodAmount(index);
//                    chooseFoodAmount.index = index;
//                    chooseFoodAmount.loadPage({ food: getFood(), dayLogIndex: index });
                }

                onPressAndHold: {
                    deleteDialog.itemIndex = index;
                    deleteDialog.show();
                }
            }
        }


        Repeater {
            id: recipesList
            clip: true
            anchors {
                left: parent.left
                right: parent.right
            }
            visible: recipesList.count > 0
            delegate: FoodAmountRow {
                property var stats: UIHelpers.getRecipeStats(food, dataManager, modelData["Amount"]);
                food: dataManager.getRecipeById(modelData["FoodId"]);
                valueText: stats["calories"] + qsTr(" kcal")
                modelItem: modelData
                subText: {
                    return modelData["Amount"] + qsTr(" serving, ") + stats["recipeWeight"] + qsTr(" g") + " (" + stats["calories"] + qsTr(" kcal") + ")"
                }

                onClicked: {
                    chooseRecipeAmount.loadPage({ recipe: food, dayLogIndex: index });
                }

                onPressAndHold: {
                    recipeDeleteDialog.itemIndex = index;
                    recipeDeleteDialog.show();
                }
            }
        }

        Standard {
            text: qsTr("Looks like you've eaten nothing");
            visible: listview.count == 0 && recipesList.count == 0
        }

    }

    PageLoader {
        id: chooseFoodAmount
        pagePath: "ChooseFoodAmount.qml"
        property int index;
        Connections {
            target: chooseFoodAmount.item
            onConfirmed: {
                dataManager.editFoodAmount(dataManager.selectedDate, chooseFoodAmount.index, amount);
                pageStack.pop();
            }
        }

    }

//    PageLoader {
//        id: chooseRecipeAmount
//        pagePath: "ChooseRecipeAmount.qml"
//    }

    Dialog {
        id: deleteDialog
        property int itemIndex;
        onAccepted: {
            dataManager.removeFoodFromLog(day, itemIndex)
        }

        title: qsTr("Delete item?")
        text: qsTr("Do you really want to delete this item?")
    }

    Dialog {
        id: recipeDeleteDialog
        property int itemIndex;
        onAccepted: {
            dataManager.removeRecipeFromLog(day, itemIndex)
        }

        title: qsTr("Delete item?")
        text: qsTr("Do you really want to delete this item?")
    }


}
