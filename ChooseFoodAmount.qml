import QtQuick 2.0
import QtQuick.Layouts 1.1
import Material 0.3

Page {

    signal confirmed(double amount);

    property var food:  {
        "Id": "testId",
        "Name": "Test name",
        "FoodCalories" : {
            "TotalCalories" : 100,
            "Carbs" : 10,
            "Proteins" : 20,
            "Fats" : 30,
        },
    }

    property double totalWeight;

    onFoodChanged: {
        console.log("Food changed: " + food["Name"]);
        totalWeight = 0;
        for (var i = 0; i < nutritionModel.count; ++i)
        {
            totalWeight += food["FoodCalories"][nutritionModel.get(i).name];
        }
    }

    StandardActionButton {
        enabled: Number.fromLocaleString(Qt.locale(), amount.text) > 0
        backgroundColor: enabled ? Palette.colors["green"]["A700"] : Palette.colors["grey"]["500"]
        onClicked: {
            confirmed(Number.fromLocaleString(Qt.locale(), amount.text));
            pageStack.pop();
        }

        AwesomeIcon {
            anchors.centerIn: parent
            name: "check"
        }

    }

    title: qsTr("How much food?")

    ColumnLayout {
        spacing: dp(20)
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
                    text: food.FoodCalories.TotalCalories.toFixed(2) + qsTr(" kkcal")
                    style: "title"
                }

                RowLayout {
                    Layout.alignment: Qt.AlignCenter
                    Repeater {
                        model: nutritionModel
                        delegate:  Label {
                            text: qsTr(modelData) + ": " + food["FoodCalories"][modelData].toFixed(2) + qsTr(" g")
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
                    text: food["Name"]
                    style: "title"
                }

                RowLayout {
                    Label {
                        style: "body2"
                        text: qsTr("Serving: ")
                    }

                    TextField {
                        id: amount
                        text: "100"
                        implicitWidth: dp(50)
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

                                var result = food["FoodCalories"][modelData] / totalWeight;
                                return Math.min(1.0, result);
                            }

                            width: dp(110)
                            height: dp(110)
                            dashThickness: dp(10)
                            value: percent
                            Label {
                                text: {
                                    return percent.toFixed(2) * 100 + "%"
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


}
