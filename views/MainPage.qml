import QtQuick 2.5
import QtQuick.Layouts 1.1
import Material 0.3
import QtQuick.Controls.Styles.Material 0.1 as MaterialStyle
import '../singletons'
import '../stores'

ScrollablePage {

    actions: [
        Action {
            name: qsTr("Choose day")
            iconName: "action/today"
            onTriggered: {
                AppActions.openDaySelectionPopup();
//                datePickerLoader.load()
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
            day: dayLogStore.day
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
                    AppActions.openRecipeList();
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
                    AppActions.openFoodList();
                    floatingMenu.close()
                }

            }
        }

        buttons: [button1,button2]

    }

    PageLoaders {}


}
