import QtQuick 2.5
import QtQuick.Layouts 1.1
import Material 0.2
import QtQuick.Controls.Styles.Material 0.1 as MaterialStyle

ScrollablePage {

    actions: [
        Action {
            name: qsTr("Choose day")
            iconName: "action/today"
            onTriggered: {
                datePickerPopup.open()
            }
        }

    ]

    PopupBase {
        id: datePickerPopup
        overlayLayer: "dialogOverlayLayer"
        overlayColor: Qt.rgba(0, 0, 0, 0.3)
        anchors.centerIn: parent

        opacity: showing ? 1 : 0
        visible: opacity > 0
        DatePicker {
           id: datePicker
           Component.onCompleted: dataManager.selectedDate = selectedDate
           selectedDate: new Date()
           anchors.centerIn: parent
           onSelectedDateChanged: {
               dataManager.selectedDate = selectedDate
           }
        }
    }


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

    FloatingMenuButton {
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
