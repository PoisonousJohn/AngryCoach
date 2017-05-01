import QtQuick 2.0
import QtQuick.Layouts 1.1
import Material 0.3
import Material.ListItems 0.1
import "formHelper.js" as FormHelper
import "stores"
import 'singletons'

ScrollablePage {
    property bool isEditing: recipeModel !== null
                                && recipeModel !== undefined
                                && recipeModel.Id
    property var ingredients: recipesStore.ingredients
    property var recipeModel: recipesStore.recipe

    signal addIngredient();

    function createModel(parent) {
        var newModel = modelComponent.createObject(parent);
        return newModel;
    }

    id:addRecipePage
    onAddIngredient: {
        AppActions.openFoodList();
    }

    onGoBack: {
        AppActions.discardRecipePage();
    }

    actions: [
        Action {
            name: qsTr("Done")
            iconName: "action/done"
            enabled: {
                return  title.displayText.length > 0 &&
                        addRecipePage.ingredients !== undefined  &&
                        addRecipePage.ingredients.count > 0 &&
                        FormHelper.getFloatFromText(servings.displayText) > 0
            }
            onTriggered: {
                var data = {};
                data["Name"] = title.displayText;
                data["Servings"] = servings.displayText
                // ingredients are owned by RecipesStore
                // let it handle them
                AppActions.acceptRecipePageValues(data);
                pageStack.pop();
            }
        }

    ]

    scrollableContent: mainLayout

    title: isEditing ? qsTr("Edit recipe") : qsTr("Add recipe")

    onRecipeModelChanged: {
        title.text = recipeModel ? recipeModel["Name"] : "";

        if (!recipeModel)
        {
            return;
        }
    }


    Component {
        id: modelComponent
        ListModel {
        }
    }

    ColumnLayout {
        id: mainLayout
        spacing: 0
        anchors {
            left: parent.left
            right: parent.right
        }

        Card {
            anchors {
                left: parent.left
                right: parent.right
            }
            height: dp(80)
            backgroundColor: Palette.colors["deepPurple"]["400"]

            TextField {
                id: title
                focus: !isEditing
                anchors {
                    centerIn: parent
                }

                color: Palette.colors["deepPurple"]["200"]

                width: parent.width * 0.9

                floatingLabel: true
                font.pointSize: 20
                placeholderText: qsTr("Title")
            }

        }

        Subheader {
            text: qsTr("Servings")
        }

        Standard {
            elevation: 1
            anchors {
                left: parent.left
                right: parent.right
            }
            TextField {
                anchors {
                    verticalCenter: parent.verticalCenter
                    left: parent.left
                    right: parent.right
                    margins: dp(20)
                }
                id: servings
                placeholderText: qsTr("Servings")
                text: recipeModel ? recipeModel["Servings"] : "1"
                inputMethodHints: Qt.ImhFormattedNumbersOnly
            }
        }

        Subheader {
            text: qsTr("Ingredients")
        }

        RecipeIngredients {
            ingredients: addRecipePage.ingredients
            allowAdd: true
            onClicked: {
                AppActions.requestEditFoodAmountInRecipe(index)
            }
            onPressAndHold: {
                deleteIngredientDialog.itemIndex = index;
                deleteIngredientDialog.show();
            }
        }

    }

    Dialog {
        property int itemIndex;
        onAccepted: {
            addRecipePage.ingredients.remove(itemIndex)
        }

        id: deleteIngredientDialog
        title: qsTr("Delete item?")
        text: qsTr("Do you really want to delete this item?")
    }

}
