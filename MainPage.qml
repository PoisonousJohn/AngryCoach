import QtQuick 2.5
import QtQuick.Layouts 1.1
import Material 0.3
import QtQuick.Controls.Styles.Material 0.1 as MaterialStyle

ScrollablePage {

    actions: [
        Action {
            name: qsTr("Choose day")
            iconName: "action/today"
            onTriggered: {
                datePickerLoader.load()
            }
        }

    ]

    id: mainPage
    title: "PigSum"
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
        id: floatingMenu
        AwesomeIcon {
            color: Palette.colors.white["500"]
            name: "plus"
            anchors.centerIn: parent
        }
        ActionButton {
            id: button1
            action: Action {
                iconName: "maps/local_dining"
                tooltip: qsTr("Recipe")
                onTriggered: {
                    recipeListLoader.loadPage()
                    floatingMenu.close()
                }
            }

        }
        ActionButton {
            id: button2
            action: Action {
                iconName: "food"
                tooltip: qsTr("Food")
                onTriggered: {
                    addFoodToLogLoader.loadPage()
                    floatingMenu.close()
                }

            }
        }

        buttons: [button1,button2]

    }

    Loader {
        id:datePickerLoader
        function load() {
            source = "DatePickerPopup.qml"
            item.open();
        }
    }

    Loader {
        id: newPage
    }

    PageLoader {
        id: recipeListLoader
        pagePath: "RecipesList.qml"
    }
    PageLoader {
        id: addFoodToLogLoader
        pagePath: "AddFoodToLog.qml"
    }

}
