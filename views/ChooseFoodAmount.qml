import QtQuick 2.0
import QtQuick.Layouts 1.1
import Material 0.3
import '../stores'
import '../singletons'

Page {
    id: chooseFoodAmount
    property bool isEditing: foodAmountModel && foodAmountModel.Index >= 0

    property var foodAmountModel: !recipesStore.recipe ? dayLogStore.foodAmount : recipesStore.foodAmount
    property var food: foodAmountModel && foodAmountModel.Food ? foodAmountModel.Food : null
    property double totalWeight;
    property double foodAmount: {
        if (amount.value.length === 0 || !food)
        {
            return 0.000001;
        }

        var amountNumber = Number.fromLocaleString(Qt.locale(), amount.value);
        return Math.max(0.000001, amountNumber / food["Weight"]);
    }

    function updateStats() {
        if (!food)
        {
            return;
        }

        totalWeight = 0;
        for (var i = 0; i < nutritionModel.count; ++i)
        {
            totalWeight += food[nutritionModel.get(i).name] * foodAmount;
        }
    }

    onGoBack: {
        Qt.inputMethod.reset();
        Qt.inputMethod.hide()
    }

    onFoodAmountChanged: {
        updateStats();
    }

    onFoodChanged: {
        updateStats();
    }


    title: isEditing ? qsTr("Edit food amount") : qsTr("How much food?")

    ColumnLayout {
        anchors {
            left: parent.left
            right: parent.right
        }
        InfoHeader {
            text: food ? food["Name"] : ""
        }

        ServingInput {
            id: amount
            defaultValue: foodAmountModel ? foodAmountModel.Amount : "100"
            focus: !isEditing
        }

        Card {
            anchors {
                left: parent.left
                right: parent.right
            }

            height: dp(320)

            ColumnLayout {
                id: nutritionLayout
                anchors.fill: parent
                anchors.margins: dp(10)
                Label {
                    text: qsTr("Nutrition information")
                    style: "title"
                }

                Label {
                    Layout.alignment: Qt.AlignCenter
                    text: {
                        return (food ? food.TotalCalories * foodAmount : 0).toFixed(2) + qsTr(" kcal")
                    }
                    font.pixelSize: dp(40)
                }

                RowLayout {
                    anchors.horizontalCenter: parent.horizontalCenter
                    Repeater {
                        id: nutritionRepeater
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
                                if (!food || totalWeight === 0)
                                {
                                    return 0;
                                }

                                var result = food[modelData] * foodAmount / totalWeight;
                                return Math.min(1.0, result);
                            }

                            width: dp(110)
                            height: dp(110)
                            dashThickness: dp(10)
                            value: percent
                            Label {
                                text: {
                                    var result = Math.round(percent * 100);
                                    return result + "%"
                                }
                                style: "headline"
                                anchors.centerIn: parent
                            }
                            Label {
                                text: qsTr(modelData) + "\n" + (
                                   food
                                        ? (food[modelData] * foodAmount).toFixed(2) + qsTr(" g")
                                        : ""
                                )
                                style: "body2"
                                horizontalAlignment: Text.AlignHCenter
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
            topMargin: dp(120)
            rightMargin: dp(10)
            verticalCenter: undefined
            horizontalCenter: undefined
        }

        enabled: Number.fromLocaleString(Qt.locale(), amount.value) > 0
        backgroundColor: enabled ? Palette.colors["green"]["A700"] : Palette.colors["grey"]["500"]
        onClicked: {
            AppActions.acceptFoodAmount(food.Id, amount.value);
            pageStack.pop();
        }

        AwesomeIcon {
            anchors.centerIn: parent
            name: "check"
        }

    }


}
