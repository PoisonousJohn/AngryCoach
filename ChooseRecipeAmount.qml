import QtQuick 2.0
import QtQuick.Layouts 1.1
import Material 0.3
import Material.ListItems 0.1
import "UIHelpers.js" as UIHelpers
import "stores"
import "singletons"

Page {

    id: chooseRecipeAmount

    property double totalNutritionWeight;
    property double totalRecipeWeight;
    property double totalCalories;
    property var nutritions;

    property var recipeAmount: dayLogStore.recipeAmount
    property var recipe: recipeAmount ? recipeAmount.Recipe : null

    property double serving: {
        if (amount.displayText.length === 0)
        {
            return 0;
        }

        return Number.fromLocaleString(Qt.locale(), amount.displayText);
    }

    function updateStats() {
        if (!recipe)
        {
            return;
        }

        var stats = recipesStore.getRecipeAmountViewModel(-1, recipe.Id, serving);

        totalNutritionWeight = stats.NutritionsWeight;
        totalCalories = stats.TotalCalories;
        totalRecipeWeight = stats.Weight;
        chooseRecipeAmount.nutritions = stats;
    }

    onServingChanged: {
        updateStats();
    }

    onRecipeChanged: {
//        updateStats();
    }


    title: recipeAmount ? qsTr("Edit serving") : qsTr("Choose serving")

    ColumnLayout {
        spacing: 0
        anchors {
            left: parent.left
            right: parent.right
        }
        Card {
            backgroundColor: Palette.colors["blue"]["300"]
            height: Units.dp * 140
            anchors {
                left: parent.left
                right: parent.right
            }


            ColumnLayout {
                id: mainInfo


                spacing: Units.dp * 20

                anchors {
                    left: parent.left
                    right: parent.right
                    top: parent.top
                    margins: Units.dp * 10
                }
                Label {
                    color: Palette.colors["indigo"]["900"]
                    text: recipe ? recipe["Name"] : ""
                    style: "display2"
                }


                RowLayout {

                    anchors {
                        left: parent.left
                        right: parent.right
                    }
                    TextField {
                        id: amount
                        text: recipeAmount ? recipeAmount["Amount"] : "1"
                        focus: true
                        color: Palette.colors["indigo"]["700"]
                        floatingLabel: true
                        implicitWidth: parent.width * 0.5
                        font.pointSize: 20
                        placeholderText: qsTr("Serving")
                        maximumLength: 9
                        inputMethodHints: Qt.ImhFormattedNumbersOnly
                        validator: DoubleValidator {
                            decimals: 2
                            bottom: 0
                        }
                    }

                    Label {
                        Layout.alignment: Qt.AlignCenter
                        text: totalCalories.toFixed(2) + qsTr(" kcal")
                        color: Palette.colors["indigo"]["700"]
                        style: "title"
                    }
                }


            }


        }

        Subheader {
            text: qsTr("Nutrition information")
        }

        Card {
            anchors {
                left: parent.left
                right: parent.right
            }

            height: Units.dp * 200

            ColumnLayout {
                anchors.fill: parent
                anchors.margins: Units.dp * 10

                RowLayout {
                    anchors.centerIn: parent
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
                                text: nutritions ? nutritions[modelData] + qsTr(" g") : ""
                                style: "body2"
                                anchors.top: parent.bottom
                                anchors.horizontalCenter: parent.horizontalCenter
                            }
                        }
                    }

                }

            }
        }
    }

    StandardActionButton {
        anchors {
            right: parent.right
            top: parent.top
            topMargin: Units.dp * 111
            rightMargin: Units.dp * 10
            verticalCenter: undefined
            horizontalCenter: undefined
        }

        enabled: Number.fromLocaleString(Qt.locale(), amount.displayText) > 0
        backgroundColor: enabled ? Palette.colors["green"]["A700"] : Palette.colors["grey"]["500"]
        onClicked: {
            var amountNumber = Number.fromLocaleString(Qt.locale(), amount.displayText);
            AppActions.acceptRecipeAmount(recipe ? recipe.Id : null, amountNumber);
            pageStack.pop();
        }

        AwesomeIcon {
            anchors.centerIn: parent
            name: "check"
        }

    }


}
