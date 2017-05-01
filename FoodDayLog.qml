import QtQuick 2.0
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.4
import Material 0.3
import Material.ListItems 0.1
import "UIHelpers.js" as UIHelpers
import 'stores'
import 'singletons'

Card {
    property var log: dayLogStore.log
    property var food: dayLogStore.foodList
    property var recipes: dayLogStore.recipesList
    property date day: dataManager.selectedDate

    implicitHeight: content.implicitHeight - dp(3)
    anchors {
        left: parent.left
        right: parent.right
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
            id: foodList
            model: food
            clip: true
            anchors {
                left: parent.left
                right: parent.right
            }
            visible: foodList.count > 0
            delegate: FoodAmountRow {
                text: modelItem ? modelItem.Food.Name : ""
                food: modelItem
                modelItem: model

                onClicked: {
                    AppActions.requestEditFoodAmount(index);
                }

                onPressAndHold: {
                    AppActions.askToRemoveFoodFromLog(index);
                }
            }
        }


        Repeater {
            id: recipesList
            model: recipes
            clip: true
            anchors {
                left: parent.left
                right: parent.right
            }
            visible: recipesList.count > 0
            delegate: FoodAmountRow {
                text: modelItem ? modelItem.Recipe.Name : ""
                food: modelItem
                valueText: modelItem ? modelItem.TotalCalories.toFixed(2) + qsTr(" kcal") : ""
                modelItem: model
                subText: {
                    return modelItem
                            ? Math.round(modelItem.Amount, 2) + qsTr(" serving, ") + modelItem.Weight.toFixed(2) + qsTr(" g")
                            : ""
                }

                onClicked: {
                    AppActions.requestEditRecipeAmount(index);
                }

                onPressAndHold: {
                    AppActions.askToRemoveRecipeFromLog(index);
                }
            }
        }

        Standard {
            text: qsTr("Looks like you've eaten nothing");
            visible: foodList.count == 0 && recipesList.count == 0
        }

    }
}
