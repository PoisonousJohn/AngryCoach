import QtQuick 2.0
import QtQuick.Layouts 1.1
import Material 0.3
import Material.ListItems 0.1
import "formHelper.js" as FormHelper

ScrollablePage {
    id:addRecipePage

    scrollableContent: mainLayout

    signal addIngredient();

    title: isEditing ? qsTr("Edit recipe") : qsTr("Add recipe")

    onGoBack: {
        recipeId = ""
        formValuesChanged();
    }

    property bool isEditing: recipeId.length > 0;
    property string recipeId;
    property var ingredients;
    property var formValues: isEditing ? dataManager.getRecipeValuesForForm(recipeId) : null

    onFormValuesChanged: {
        title.text = formValues ? formValues["Name"] : "";

        if (ingredients)
        {
            ingredients.clear();
        }
        else
        {
            ingredients = createModel(addRecipePage);
        }

        if (!formValues)
        {
            return;
        }

        var valueIngredients = formValues["Ingredients"];
        for (var i = 0; i < valueIngredients.length; ++i)
        {
            ingredients.append(valueIngredients[i]);
        }

    }

    onAddIngredient: {
        pageStack.push(chooseFoodForRecipe)
    }

    Component {
        id: modelComponent
        ListModel {
        }
    }

    function createModel(parent) {
        var newModel = modelComponent.createObject(parent);
        return newModel;
    }

    PageLoader {
        id: chooseFoodAmountForRecipe
        pagePath: "ChooseFoodAmount.qml"
        property var food;
        Connections {
            target: chooseFoodAmountForRecipe.item
            onConfirmed: {
                if (addRecipePage.ingredients === undefined)
                {
                    addRecipePage.ingredients = createModel(addRecipePage)
                }

                addRecipePage.ingredients.append({
                                     "FoodId": chooseFoodAmountForRecipe.food["Id"],
                                     "Amount": amount
                                 });
                pageStack.pop();
            }
        }
    }

    FoodList {
        id: chooseFoodForRecipe
        title: qsTr("Add food to recipe")
        model: dataManager.food

        onItemSelected: {
            console.log("search food in recipe item selected")
            chooseFoodAmountForRecipe.food = item;
            chooseFoodAmountForRecipe.loadPage({food: item });
        }
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
                var list = [];
                for (var i = 0; i < addRecipePage.ingredients.count; ++i) {
                    var ingredient = addRecipePage.ingredients.get(i);
                    list.push(ingredient);
                }

                data["Ingredients"] = list;
                if (isEditing) {
                    dataManager.editRecipe(recipeId, data)
                } else {
                    dataManager.addRecipe(data);
                }



                pageStack.pop();
            }
        }

    ]

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
                text: formValues ? formValues["Servings"] : "1"
                inputMethodHints: Qt.ImhFormattedNumbersOnly
            }
        }

        Subheader {
            text: qsTr("Ingredients")
        }



        Card {
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
                        modelItem: repeater.model.get(index);
                        food: {
                            modelItem ? dataManager.getFoodById(modelItem["FoodId"]) : undefined
                        }
                        onPressAndHold: {
                            deleteIngredientDialog.itemIndex = index;
                            deleteIngredientDialog.show();
                        }
                    }
                }

                Standard {
                    text: qsTr("Add ingredient")
                    iconName: "av/playlist_add"
                    onClicked: addIngredient()
                }
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
