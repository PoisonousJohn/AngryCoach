import QtQuick 2.5
import QtQuick.Layouts 1.1
import Material 0.2
import QtQuick.Controls.Styles.Material 0.1 as MaterialStyle

Page {
    AddFood {
        id: addFood
        visible: false
    }

    SearchList {
        id: searchFood
        title: qsTr("Choose food")
        visible: false
        model: dataManager.food
        defaultModelField: "Name"
        onItemSelected: {
            console.log("Adding food to log: " + item["Id"] + " for date " + dayLog.day);
            dataManager.addFoodToLog(dayLog.day, item["Id"])
            pageStack.pop()
        }

        StandardActionButton {
            AwesomeIcon {
                anchors.centerIn: parent
                name: "plus"
            }

            onClicked: {
                pageStack.push(addFood)
            }
        }
    }

    id: mainPage
    title: "Application Name"
    data: Item {
        anchors.fill: parent

        ColumnLayout {
//            anchors.fill: parent
            anchors {
                left: parent.left
                right: parent.right
            }

            DayStatsCard {}
            FoodDayLog {
                id: dayLog
            }
        }


        ActionButton {
            anchors.horizontalCenter: parent.right
            anchors.verticalCenter: parent.bottom
            anchors.horizontalCenterOffset: dp(-width)
            anchors.verticalCenterOffset: dp(-height)
            onClicked: {
                pageStack.push(searchFood)
            }

            AwesomeIcon {
                name: "plus"
                anchors.centerIn: parent
            }
        }

    }

    actions: [
        Action {
            name: "Menu"

            // Icon name from the Google Material Design icon pack
            iconName: "navigation/menu"
        }
    ]

//        actionBar {
//            // Set a custom background color, if you don't want to use
//            // the theme's primary color
////            backgroundColor: Palette.colors.red["500"]

//            // You can also set a custom content view instead of the title
//            customContent: TextField {
//                placeholderText: "Search..."
//                anchors {
//                    left: parent.left
//                    right: parent.right
//                    verticalCenter: parent.verticalCenter
//                }
//            }
//        }
}
