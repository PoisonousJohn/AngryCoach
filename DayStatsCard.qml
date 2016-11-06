import QtQuick 2.5
import QtQuick.Layouts 1.1
import Material 0.3
import Material.ListItems 0.1
import "fitnessFormula.js" as Formula
import Fitness 0.1

Card {

    id: card
    property var __model: dataManager.getDayLog(dataManager.selectedDate);
    property double totalCalories;
    property double carbs;
    property double fats;
    property double proteins;

    property double maxTotalCalories;
    property double maxCarbs;
    property double maxFats;
    property double maxProteins;

    function getNutritionDesc(max, curr, unit)
    {
        var result = max - curr;
        return Math.abs(result).toFixed(2) + qsTr(unit) + " " + (result > 0 ? qsTr("left") : qsTr("over"));
    }

    function updateStats()
    {
        var userProfile = dataManager.userProfile;
        totalCalories = 0;
        carbs = 0;
        fats = 0;
        proteins = 0;

        maxTotalCalories = Formula.getDailyCaloriesNorm(
                    userProfile["Weight"],
                    userProfile["Height"],
                    userProfile["Age"],
                    userProfile["Sex"] === AppData.Male
                                                ? "Male"
                                                : "Female"
        ) * userProfile["MassModifierFactor"];

        console.log("Mass modifier: " + userProfile["MassModifier"]);

        // hardcoded physical activity factor
        maxTotalCalories *= 1.2;

        var nutrition = Formula.getNutritionNorm(maxTotalCalories);
        maxCarbs = nutrition["Carbs"] * userProfile["MassModifierFactor"];
        maxFats = nutrition["Fats"] * userProfile["MassModifierFactor"];
        maxProteins = nutrition["Proteins"] * userProfile["MassModifierFactor"];


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
        onFoodChanged: {
            updateStats();
        }

        onUserProfileChanged: {
            updateStats();
        }

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
                Name: qsTr("Edit profile")
            }
        }

        onItemClicked: {
            if (itemIndex === 0)
            {
                pageStack.push(userProfile);
            }

//            console.log("menu clicked " + itemIndex)
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
//                color: Palette.colors["grey"]["300"]
                radius: width * 0.5
                width: dp(100)
                height: dp(100)
                OverflowableProgressCircle {
                    overflowColor: Palette.colors["red"]["A200"]
                    width: dp(110)
                    height: dp(110)
                    Text {
                        text: getNutritionDesc(maxTotalCalories, totalCalories, "\nKCAL")
                        anchors.centerIn: parent
                        horizontalAlignment: Text.AlignHCenter
                    }
                    anchors.centerIn: parent
                    indeterminate: false
                    value: totalCalories / maxTotalCalories
                    dashThickness: dp(8)
                }
            }
        }
        RowLayout {
            property int itemWidth: mainPage.width / 3 -spacing

            id: parameters
            anchors.topMargin: dp(100)
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.leftMargin: dp(20)
            anchors.rightMargin: dp(20)
            spacing: dp(20)


            ProgressBarWithNameAndDesc {
                width: parameters.itemWidth
                name: "Carbs"
                progressBarValue: carbs / maxCarbs
                description: getNutritionDesc(maxCarbs, carbs, "g")
                overflowColor: Palette.colors["red"]["A400"]
            }
            ProgressBarWithNameAndDesc {
                width: parameters.itemWidth
                name: "Proteins"
                progressBarValue: proteins / maxProteins
                description: getNutritionDesc(maxProteins, proteins, "g")
                overflowColor: Palette.colors["red"]["A400"]
            }
            ProgressBarWithNameAndDesc {
                width: parameters.itemWidth
                name: "Fats"
                progressBarValue: fats / maxFats
                description: getNutritionDesc(maxFats, fats, "g")
                overflowColor: Palette.colors["red"]["A400"]
            }

        }


        }

}
