import QtQuick 2.5
import QtQuick.Layouts 1.1
import Material 0.2
import QtQuick.Controls.Styles.Material 0.1 as MaterialStyle

ScrollablePage {

    actions: [
        Action {
            name: qsTr("Choose day")
            iconName: "action/today"
            onTriggered: {
                datePickerPopup.open()
            }
        }

    ]

    id: mainPage
    title: "Application Name"
    scrollableContent: ColumnLayout {
        id: column
        anchors {
            left: parent.left
            right: parent.right
        }

        DayStatsCard {
        }

        FoodDayLog {
            id: dayLog
            day: dataManager.selectedDate
        }
    }


    FloatingMenuButton {
        id: floatingMenu
        AwesomeIcon {
            color: Palette.colors.white["500"]
            name: "plus"
            anchors.centerIn: parent
        }
        ActionButton {
            id: button1
            action: Action {
                iconName: "maps/local_dining"
                tooltip: qsTr("Recipe")
                onTriggered: {
                    pageStack.push(searchRecipe)
                    floatingMenu.close()
                }
            }

        }
        ActionButton {
            id: button2
            action: Action {
                iconName: "food"
                tooltip: qsTr("Food")
                onTriggered: {
                    pageStack.push(searchFood)
                    floatingMenu.close()
                }

            }
        }

        buttons: [button1,button2]
//        onClicked: {
//            pageStack.push(searchFood)
//        }

    }

    PopupBase {
        id: datePickerPopup
        overlayLayer: "dialogOverlayLayer"
        overlayColor: Qt.rgba(0, 0, 0, 0.3)
        anchors.centerIn: parent

        opacity: showing ? 1 : 0
        visible: opacity > 0
        DatePicker {
           id: datePicker
           Component.onCompleted: dataManager.selectedDate = selectedDate
           selectedDate: new Date()
           anchors.centerIn: parent
           onSelectedDateChanged: {
               dataManager.selectedDate = selectedDate
           }
        }
    }

    AddRecipe {
        id: addRecipe
    }

    AddFood {
        id: addFood
        visible: false
    }

    ChooseFoodAmount {
        id: chooseFoodAmount
        visible: false
        onConfirmed: {
            console.log("adding food confirmed "  + amount)
            dataManager.addFoodToLog(dayLog.day, food["Id"], amount);
            pageStack.pop();
        }
    }

    ChooseFoodAmount {
        id: chooseRecipeAmount
        visible: false
        onConfirmed: {
            console.log("adding recipe confirmed "  + amount)
            dataManager.addRecipeToLog(dayLog.day, food["Id"], amount);
            pageStack.pop();
        }
    }

    Dialog {
        id: foodDeleteDialog
        property string foodId;
        onAccepted: {
            dataManager.removeFood(foodId)
        }

        title: qsTr("Delete item?")
        text: qsTr("Do you really want to delete this item?")
    }

    Dialog {
        id: recipeDeleteDialog
        property string recipeId;
        onAccepted: {
            dataManager.removeRecipe(recipeId)
        }

        title: qsTr("Delete item?")
        text: qsTr("Do you really want to delete this item?")
    }

    ChooseFood {
        id: searchRecipe
        model: dataManager.recipes
        title: qsTr("Choose recipe to add")
        onAdd: {
            addRecipe.recipeId = ""
            pageStack.push(addRecipe)
        }

        onItemSelected: {
            console.log("Adding recipe to log: " + item["Id"] + " for date " + dayLog.day);
            chooseRecipeAmount.food = item;
            pageStack.push(chooseRecipeAmount);
        }
        onEditItem: {
            addRecipe.recipeId = itemId;
            pageStack.push(addRecipe);
        }
        onDeleteItem: {
            recipeDeleteDialog.recipeId = itemId
            recipeDeleteDialog.show();
        }
    }

    ChooseFood {
        id: searchFood
        model: dataManager.food
        title: qsTr("Choose food to add")
        onAdd: {
            addFood.foodId = ""
            pageStack.push(addFood)
        }

        onItemSelected: {
            console.log("Adding food to log: " + item["Id"] + " for date " + dayLog.day);
            chooseFoodAmount.food = item;
            pageStack.push(chooseFoodAmount);
        }
        onEditItem: {
            addFood.foodId = itemId;
            pageStack.push(addFood);
        }
        onDeleteItem: {
            foodDeleteDialog.foodId = itemId
            foodDeleteDialog.show();
        }
    }

}
