import QtQuick 2.0
import QtQuick.Layouts 1.1
import Material 0.3
import 'stores'
import 'singletons'

Page {
    property bool isEditing: food !== null && food !== undefined

    property var foodAmountModel: dayLogStore.foodAmount
    property var food: foodAmountModel ? foodAmountModel.Food : null
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

            Rectangle {
                anchors.fill: parent
                color: Palette.colors["grey"]["900"]
            }

            Image {
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                source: "images/free-food-photo20.png"
            }


            Rectangle {
                anchors.verticalCenter: foodName.verticalCenter
                anchors.left: parent.left
                anchors.right: parent.right
//                anchors.margins: dp(-20)
                height: foodName.height + dp(20)
                color: "white"
                opacity: 0.5
            }
            Label {
                id: foodName
                x: dp(20)
                anchors.bottom: parent.bottom
                anchors.bottomMargin: dp(20)
                text: isEditing ? food["Name"] : ""
                font.pixelSize: dp(20)
            }



        }

        Card {
            anchors {
                left: parent.left
                right: parent.right
            }

            height: servingLayout.implicitHeight + dp(20)

            RowLayout {
                id: servingLayout
                x: dp(10)
                anchors.verticalCenter: parent.verticalCenter
                Label {
                    style: "body2"
                    text: qsTr("Serving: ")
                }

                TextField {
                    id: amount
                    text: isEditing ? foodAmountModel.Amount : "100"
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
                    text: (isEditing ? food.TotalCalories * foodAmount : 0).toFixed(2) + qsTr(" kcal")
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
                                if (!isEditing || totalWeight === 0)
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
                                    isEditing
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

        enabled: Number.fromLocaleString(Qt.locale(), amount.displayText) > 0
        backgroundColor: enabled ? Palette.colors["green"]["A700"] : Palette.colors["grey"]["500"]
        onClicked: {
            AppActions.acceptFoodAmount(food.Id, amount.displayText);
            pageStack.pop();
        }

        AwesomeIcon {
            anchors.centerIn: parent
            name: "check"
        }

    }


}
