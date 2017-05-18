import QtQuick 2.5
import QtQuick.Layouts 1.1
import QtMultimedia 5.0
import Material 0.3
import Material.ListItems 0.1
import Fitness 0.1
import '../singletons'

Card {

    id: card
    property var __model;
    property double totalCalories: dayLogStore.log.TotalCalories;
    property double carbs: dayLogStore.log.Carbs;
    property double proteins: dayLogStore.log.Proteins;
    property double fats: dayLogStore.log.Fats;

    property double maxTotalCalories: userProfileStore.profile.MaxCalories
    property double maxCarbs: userProfileStore.profile.MaxCarbs
    property double maxProteins: userProfileStore.profile.MaxProteins
    property double maxFats: userProfileStore.profile.MaxFats

    function getNutritionDesc(max, curr, unit)
    {
        var result = max - curr;
        return Math.abs(result).toFixed(2) + qsTr(unit) + " " + (result > 0 ? qsTr("left") : qsTr("over"));
    }

    Connections {
        target: dataManager

        onSelectedDateChanged: {
            __model = null;
            __model = dataManager.getDayLog(dataManager.selectedDate);
        }

        onDayLogChanged: {
            if (date.getTime() !== dataManager.selectedDate.getTime())
            {
                return;
            }

            __model = dataManager.getDayLog(dataManager.selectedDate);
            if (totalStatsCircle.value > 1.0)
            {
                overdoseEffect.play();
            }
            else
            {
                eatEffect.play();
            }

        }
    }

    SoundEffect {
        id: eatEffect
        source: "pig/eat.wav"
    }

    SoundEffect {
        id: overdoseEffect
        source: "pig/overdose.wav"
    }


    anchors.left: parent.left
    anchors.right: parent.right
    height: dp(240)

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
                AppActions.openUserProfile();
            }
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
                    id: totalStatsCircle
                    overflowColor: Palette.colors["red"]["A200"]
                    width: dp(150)
                    height: dp(150)
                    Text {
                        text: getNutritionDesc(maxTotalCalories, totalCalories, "\nKCAL")
                        anchors.centerIn: parent
                        horizontalAlignment: Text.AlignHCenter
                    }
                    anchors.centerIn: parent
                    indeterminate: false
                    value: totalCalories / maxTotalCalories
                    dashThickness: dp(10)
                }
            }
        }
        RowLayout {
            property int itemWidth: mainPage.width / 3 -spacing

            id: parameters
            anchors.top: totalStats.bottom
            anchors.topMargin: dp(40)
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
