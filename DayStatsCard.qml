import QtQuick 2.5
import QtQuick.Layouts 1.1
import Material 0.3
import Material.ListItems 0.1

Card {

    id: card
    property var model;
    property int totalCalories;
    property int carbs;
    property int fats;
    property int proteins;

    property int maxTotalCalories: 100;
    property int maxCarbs: 100;
    property int maxFats: 100;
    property int maxProteins: 100;

    onModelChanged: {

        totalCalories = 0;
        carbs = 0;
        fats = 0;
        proteins = 0;

        for (var i = 0; i < model.length; ++i)
        {
            console.log(model[i]);
            totalCalories += model[i]["FoodCalories"]["TotalCalories"];
            carbs += model[i]["FoodCalories"]["Carbs"];
            fats += model[i]["FoodCalories"]["Fats"];
            proteins += model[i]["FoodCalories"]["Proteins"];
        }
    }

    anchors.left: parent.left
    anchors.right: parent.right
    height: stats.height + dp(40)

    SimpleContextMenu {
        id: dayStatsMenu
        model: ListModel {
            ListElement
            {
                name: qsTr("Setup day goal")
            }
        }

        onItemClicked: {
            console.log("menu clicked " + itemIndex)
        }
    }

    Button {
        id: moreButton
        onClicked: {
            dayStatsMenu.open(moreButton, -dp(16))
        }

        implicitWidth: buttonIcon.width
        implicitHeight: buttonIcon.height
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.rightMargin: dp(10)
        anchors.topMargin: dp(10)
        Icon {
            id: buttonIcon
            name: "navigation/more_vert"
        }
    }


    ColumnLayout {
        id: stats
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        spacing: dp(20)
        RowLayout {
            id: totalStats
            spacing: dp(50)
            anchors.horizontalCenter: parent.horizontalCenter
//            Text {
//                text: totalCalories + "\n EATEN"
//                horizontalAlignment: Text.AlignHCenter
//            }
            Rectangle {
                color: Palette.colors["grey"]["300"]
                radius: width * 0.5
                width: dp(100)
                height: dp(100)
                ProgressCircle {
                    width: dp(110)
                    height: dp(110)
                    Text {
                        text: totalCalories + "\nKCAL Total"
                        anchors.centerIn: parent
                        horizontalAlignment: Text.AlignHCenter
                    }
                    anchors.centerIn: parent
                    indeterminate: false
                    value: totalCalories / maxTotalCalories
                    dashThickness: dp(8)
                }
            }

//            Text {
//                width: 300
//                text: "0\n BURNED"
//                horizontalAlignment: Text.AlignHCenter
//            }

        }
        RowLayout {
            property int itemWidth: card.width / 3 -spacing

            id: parameters
            anchors.topMargin: dp(100)
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.leftMargin: dp(20)
            anchors.rightMargin: dp(20)
            spacing: dp(20)

            ProgressBarWithNameAndDesc {
                width: parameters.itemWidth
                name: "Carbs"
                progressBarValue: card.carbs / maxCarbs
                description: " g"
            }
            ProgressBarWithNameAndDesc {
                width: parameters.itemWidth
                name: "Proteins"
                progressBarValue: card.proteins / maxProteins
                description: " g"
            }
            ProgressBarWithNameAndDesc {
                width: parameters.itemWidth
                name: "Fats"
                progressBarValue: card.fasts / maxFats
                description: " g"
            }

        }


        }

}
