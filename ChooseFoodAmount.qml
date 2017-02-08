import QtQuick 2.0
import QtQuick.Layouts 1.1
import Material 0.3
import 'stores'
import 'singletons'

Page {
    property bool isEditing: food !== null && food !== undefined

    property var food: FoodStore.selectedFood
    property double totalWeight;
    property double foodAmount: {
        if (!isEditing || amount.displayText.length === 0)
        {
            return 0.000001;
        }

        var amountNumber = Number.fromLocaleString(Qt.locale(), amount.displayText);
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
        spacing: dp(10)
        anchors {
            left: parent.left
            right: parent.right
        }
        Card {
            height: dp(120)
            anchors {
                left: parent.left
                right: parent.right
            }

            ColumnLayout {
                anchors.right: parent.right
                anchors.rightMargin: dp(10)
                anchors.top: parent.top
                anchors.topMargin: dp(50)

                Label {
                    Layout.alignment: Qt.AlignCenter
                    text: (isEditing ? food.TotalCalories * foodAmount : 0).toFixed(2) + qsTr(" kcal")
                    style: "title"
                }

                RowLayout {
                    Layout.alignment: Qt.AlignCenter
                    Repeater {
                        model: nutritionModel
                        delegate:  Label {
                            text: isEditing
                                    ? qsTr(modelData) + ": " + (food[modelData] * foodAmount).toFixed(2) + qsTr(" g")
                                    : ""
                        }
                    }

                }

            }


            ColumnLayout {
                id: mainInfo

                anchors {
                    left: parent.left
//                    right: parent.right
                    top: parent.top
                    margins: dp(10)
                }
                Label {
                    text: isEditing ? food["Name"] : ""
                    style: "title"
                }

                RowLayout {
                    Label {
                        style: "body2"
                        text: qsTr("Serving: ")
                    }

                    TextField {
                        id: amount
                        text: isEditing ? food["Amount"] : "100"
                        implicitWidth: dp(50)
                        maximumLength: 9
                        focus: !isEditing
                        inputMethodHints: Qt.ImhFormattedNumbersOnly
                        validator: DoubleValidator {
                            decimals: 2
                            bottom: 0
                        }
                    }

                    Label {
                        text: qsTr("g")
                    }
                }

            }


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
                Label {
                    text: qsTr("Nutrition information")
                    style: "title"
                }

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
                                if (totalWeight === 0)
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
                                text: qsTr(modelData)
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
            topMargin: dp(100)
            rightMargin: dp(10)
            verticalCenter: undefined
            horizontalCenter: undefined
        }

        enabled: Number.fromLocaleString(Qt.locale(), amount.displayText) > 0
        backgroundColor: enabled ? Palette.colors["green"]["A700"] : Palette.colors["grey"]["500"]
        onClicked: {
            AppActions.addFoodAmount(amount.displayText);
            pageStack.pop();
        }

        AwesomeIcon {
            anchors.centerIn: parent
            name: "check"
        }

    }


}
