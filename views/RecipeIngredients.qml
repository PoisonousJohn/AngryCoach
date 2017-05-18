import QtQuick 2.0
import QtQuick.Layouts 1.1
import Material 0.3
import Material.ListItems 0.1
import '../stores'
import '../singletons'

Card {
    property var ingredients
    property bool allowAdd

    signal clicked(int index)
    signal pressAndHold(int index)

    id: recipeIngredients

    anchors {
        left: parent.left
        right: parent.right
    }
    
    implicitHeight: recipesLayout.implicitHeight
    
    ColumnLayout {
        id: recipesLayout
        anchors {
            left: parent.left
            right: parent.right
        }
        
        Repeater {
            id: repeater
            model: ingredients
            delegate: FoodAmountRow {
                modelItem: 'modelData' in model ? model.modelData : model;
                subText: modelItem ? modelItem.TotalCalories.toFixed(2) + qsTr(" kcal") : ""
                valueText: modelItem ? modelItem.Amount.toFixed(2) + qsTr(" g") : ""
                food: modelItem ? modelItem["Food"] : undefined
                onClicked: {
                    recipeIngredients.clicked(index)
                }
                onPressAndHold: {
                    recipeIngredients.pressAndHold(index)
                }
            }
        }
        
        Standard {
            text: qsTr("Add ingredient")
            iconName: "av/playlist_add"
            onClicked: addIngredient()
            visible: allowAdd
        }
    }
    
}
