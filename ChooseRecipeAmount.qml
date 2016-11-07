import QtQuick 2.0
import QtQuick.Layouts 1.1
import Material 0.3
import Material.ListItems 0.1
import "UIHelpers.js" as UIHelpers

Page {

    id: chooseRecipeAmount

    signal confirmed(double amount);

    property var recipe;
    property double totalNutritionWeight;
    property double totalRecipeWeight;
    property double totalCalories;
    property var nutritions;
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

        var stats = UIHelpers.getRecipeStats(recipe, dataManager, serving);

        totalNutritionWeight = stats["nutritionWeight"];
        totalCalories = stats["calories"];
        totalRecipeWeight = stats["recipeWeight"];
        chooseRecipeAmount.nutritions = stats["nutritions"];
    }

    onServingChanged: {
        updateStats();
    }

    onRecipeChanged: {
        updateStats();
    }


    title: qsTr("Choose serving")

    ColumnLayout {
        spacing: 0
        anchors {
            left: parent.left
            right: parent.right
        }
        Card {
            backgroundColor: Palette.colors["blue"]["300"]
            height: dp(140)
            anchors {
                left: parent.left
                right: parent.right
            }


            ColumnLayout {
                id: mainInfo


                spacing: dp(20)

                anchors {
                    left: parent.left
                    right: parent.right
                    top: parent.top
                    margins: dp(10)
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
                        text: "1"
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

            height: dp(200)

            ColumnLayout {
                anchors.fill: parent
                anchors.margins: dp(10)

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

                            width: dp(110)
                            height: dp(110)
                            dashThickness: dp(10)
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
            topMargin: dp(111)
            rightMargin: dp(10)
            verticalCenter: undefined
            horizontalCenter: undefined
        }

        enabled: Number.fromLocaleString(Qt.locale(), amount.displayText) > 0
        backgroundColor: enabled ? Palette.colors["green"]["A700"] : Palette.colors["grey"]["500"]
        onClicked: {
            confirmed(Number.fromLocaleString(Qt.locale(), amount.displayText));
            pageStack.pop();
        }

        AwesomeIcon {
            anchors.centerIn: parent
            name: "check"
        }

    }


}
