import QtQuick 2.0
import QtQuick.Layouts 1.1
import Material 0.3
import Material.ListItems 0.1
import '../stores'
import '../singletons'

ScrollablePage {
    property double totalNutritionWeight
    property double totalRecipeWeight
    property double totalCalories
    property var nutritions

    property string recipeId
    property int recipeAmount
    property var recipe
    property var ingredients
    property int recipeAmountIndex


    property double serving: {
        if (amount.value.length === 0)
        {
            return 0;
        }

        return Number.fromLocaleString(Qt.locale(), amount.value);
    }

    function updateStats() {
        var stats = recipesStore.getRecipeAmountViewModel(-1, recipeId, serving);

        totalNutritionWeight = stats.NutritionsWeight;
        totalCalories = stats.TotalCalories;
        totalRecipeWeight = stats.Weight;
        chooseRecipeAmount.nutritions = stats;

        recipe = stats.Recipe;
        ingredients = stats.Ingredients;
    }

    Component.onCompleted: {
        if (!dayLogStore.recipeAmount)
        {
            recipeId = null;
            return;
        }

        recipeId = dayLogStore.recipeAmount.Recipe.Id;
        recipeAmount = dayLogStore.recipeAmount.Amount
        recipeAmountIndex = dayLogStore.recipeAmount.Index
    }

    scrollableContent: mainColumn

    id: chooseRecipeAmount
    title: recipeAmountIndex >= 0 ? qsTr("Edit serving") : qsTr("Choose serving")

    onServingChanged: {
        updateStats();
    }

    onRecipeIdChanged: {
        updateStats();
        console.log("Recipe id changed " + recipeId);
    }


    ColumnLayout {
        id: mainColumn
        spacing: dp(10)
        anchors {
            left: parent.left
            right: parent.right
        }
        InfoHeader {
            text: recipe ? recipe.Name : ""
            backgroundImage: "/images/serving.png"
            height: dp(200)
        }

        ServingInput {
            id: amount
            defaultValue: recipeAmount
        }

        Subheader {
            text: qsTr("Nutrition information")
        }

        Card {
            anchors {
                left: parent.left
                right: parent.right
            }

            height: Units.dp * 240

            ColumnLayout {
                anchors.fill: parent
                anchors.margins: Units.dp * 10

                Label {
                    height: 40
                    Layout.alignment: Qt.AlignCenter
                    text: {
                        return totalCalories.toFixed(2) + qsTr(" kcal")
                    }
                    font.pixelSize: dp(40)
                }


                RowLayout {
                    anchors.horizontalCenter: parent.horizontalCenter
                    Repeater {
                        model: ListModel {
                            id: nutritionModel
                            ListElement {
                                name: "Carbs"
                            }
                            ListElement {
                                name: "Fats"
                            }
                            ListElement {
                                name: "Proteins"
                            }
                        }

                        delegate: TwoColorProgressCircle {
                            property double percent: {
                                if (totalNutritionWeight === 0 || !nutritions)
                                {
                                    return 0;
                                }

                                var result = nutritions[modelData] / totalNutritionWeight;
                                return Math.min(1.0, result);
                            }

                            width: Units.dp * 110
                            height: Units.dp * 110
                            dashThickness: Units.dp * 10
                            value: percent
                            Label {
                                text: qsTr(modelData)
                                style: "body2"
                                anchors.bottom: parent.top
                                anchors.horizontalCenter: parent.horizontalCenter
                            }
                            Label {
                                text: {
                                    var result = Math.round(percent * 100);
                                    return result + "%"
                                }
                                style: "headline"
                                anchors.centerIn: parent
                            }
                            Label {
                                text: nutritions ? nutritions[modelData].toFixed(2) + qsTr(" g") : ""
                                style: "body2"
                                anchors.top: parent.bottom
                                anchors.horizontalCenter: parent.horizontalCenter
                            }
                        }
                    }

                }

            }
        }

        Subheader {
            text: qsTr("Ingredients")
        }

        RecipeIngredients {
            ingredients: chooseRecipeAmount.ingredients
        }

        FoodAmountRow {
            text: qsTr("Total")
            valueText: recipe.Weight.toFixed(2) + qsTr(" g")
            subText: recipe.TotalCalories.toFixed(2) + qsTr(" kcal")

        }
        StandardActionButton {
            anchors {
                right: parent.right
                top: parent.top
                topMargin: Units.dp * 140
                rightMargin: Units.dp * 10
                verticalCenter: undefined
                horizontalCenter: undefined
            }

            backgroundColor: enabled ? Palette.colors["green"]["A700"] : Palette.colors["grey"]["500"]
            enabled: Number.fromLocaleString(Qt.locale(), amount.value) > 0
            onClicked: {
                var amountNumber = Number.fromLocaleString(Qt.locale(), amount.value);
                AppActions.acceptRecipeAmount(recipe ? recipe.Id : null, amountNumber);
                pageStack.pop();
            }

            AwesomeIcon {
                anchors.centerIn: parent
                name: "check"
            }

        }
    }




}
