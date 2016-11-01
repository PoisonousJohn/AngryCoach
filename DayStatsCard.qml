import QtQuick 2.5
import QtQuick.Layouts 1.1
import Material 0.3
import Material.ListItems 0.1

Card {

    id: card
    property var __model: dataManager.getDayLog(dataManager.selectedDate);
    property int totalCalories;
    property int carbs;
    property int fats;
    property int proteins;

    property int maxTotalCalories: 100;
    property int maxCarbs: 100;
    property int maxFats: 100;
    property int maxProteins: 100;

    function updateStats()
    {
        totalCalories = 0;
        carbs = 0;
        fats = 0;
        proteins = 0;

        for (var i = 0; i < __model.length; ++i)
        {
            var foodId = __model[i]["FoodId"];
            var food = dataManager.getFoodById(foodId);
            var amountFactor = __model[i]["Amount"] / 100;
            totalCalories += food["FoodCalories"]["TotalCalories"] * amountFactor;
            carbs += food["FoodCalories"]["Carbs"] * amountFactor;
            fats += food["FoodCalories"]["Fats"] * amountFactor;
            proteins += food["FoodCalories"]["Proteins"] * amountFactor;
        }
    }

    Connections {
        target: dataManager
        onDayLogChanged: {
            if (date.getTime() !== dataManager.selectedDate.getTime())
            {
                return;
            }

            __model = dataManager.getDayLog(dataManager.selectedDate);
            updateStats();
        }
    }

    on__ModelChanged: {
        updateStats();
    }

    anchors.left: parent.left
    anchors.right: parent.right
    height: stats.height + dp(40)

    SimpleContextMenu {
        id: dayStatsMenu
        model: ListModel {
            ListElement
            {
                Name: qsTr("Setup day goal")
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
                    value: Math.min(totalCalories / maxTotalCalories, 1)
                    dashThickness: dp(8)
                }
            }
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
                progressBarValue: Math.min(1, carbs / maxCarbs)
                description: " g"
            }
            ProgressBarWithNameAndDesc {
                width: parameters.itemWidth
                name: "Proteins"
                progressBarValue: Math.min(1, proteins / maxProteins)
                description: " g"
            }
            ProgressBarWithNameAndDesc {
                width: parameters.itemWidth
                name: "Fats"
                progressBarValue: Math.min(1, fats / maxFats)
                description: " g"
            }

        }


        }

}
