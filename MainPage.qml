import QtQuick 2.5
import QtQuick.Layouts 1.1
import Material 0.2
import QtQuick.Controls.Styles.Material 0.1 as MaterialStyle

ScrollablePage {

    AddFood {
        id: addFood
        visible: false
    }

    ChooseFoodAmount {
        id: chooseFoodAmount
        visible: false
        onConfirmed: {
            console.log("adding food confirmed "  + amount)
            dataManager.addFoodToLog(dayLog.day, food["Id"], amount);
            pageStack.pop();
        }
    }

    ChooseFood {
        id: searchFood
    }


//    scrollWith: parent.width
//    scrollHeight: column.implicitHeight

    id: mainPage
    title: "Application Name"
    scrollableContent: ColumnLayout {
        id: column
        anchors {
            left: parent.left
            right: parent.right
        }

        DayStatsCard {
        }

        FoodDayLog {
            id: dayLog
            day: dataManager.selectedDate
        }
    }

    StandardActionButton {
        onClicked: {
            pageStack.push(searchFood)
        }

        AwesomeIcon {
            color: Palette.colors.white["500"]
            name: "plus"
            anchors.centerIn: parent
        }
    }

}
