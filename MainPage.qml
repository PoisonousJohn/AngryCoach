import QtQuick 2.5
import QtQuick.Layouts 1.1
import Material 0.2
import QtQuick.Controls.Styles.Material 0.1 as MaterialStyle

Page {
    id: mainPage
    title: "Application Name"
    data: Item {
        anchors.fill: parent
        Card {
            anchors.left: parent.left
            anchors.right: parent.right
            height: stats.height + dp(40)
            ColumnLayout {
                id: stats
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                RowLayout {
                    id: totalStats
                    spacing: dp(50)
                    anchors.horizontalCenter: parent.horizontalCenter
                    Text {
                        text: "0\n EATEN"
                        horizontalAlignment: Text.AlignHCenter
                    }
                    Rectangle {
                        radius: width * 0.5
                        width: dp(100)
                        height: dp(100)
                        ProgressCircle {
                            width: dp(110)
                            height: dp(110)
                            Text {
                                text: "2401\nKCAL LEFT"
                                anchors.centerIn: parent
                                horizontalAlignment: Text.AlignHCenter
                            }
                            anchors.centerIn: parent
                            indeterminate: false
                            value: 1
                            dashThickness: dp(8)
                        }
                    }

                    Text {
                        width: 300
                        text: "0\n BURNED"
                        horizontalAlignment: Text.AlignHCenter
                    }

                }
                RowLayout {
                    id: parameters
                    anchors.topMargin: dp(50)
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.leftMargin: dp(20)
                    anchors.rightMargin: dp(20)
                    spacing: 10
                    Repeater {
                        id: repeater
                        model: dummyModel
                        ColumnLayout {

                            Label {
                                anchors.horizontalCenter: parent.horizontalCenter
                                text: name
                            }

                            ProgressBar {
                                implicitWidth: window.width / repeater.model.count - dp(parameters.spacing * 2)
                                indeterminate: false
                                value: model.value / model.maxValue
                                style: MaterialStyle.ProgressBarStyle {
                                    background: Rectangle {
                                       radius: 2
                                       color: "red"
                                       border.color: "gray"
                                       border.width: 1
                                       implicitWidth: 200000
                                       implicitHeight: 24
                                    }
                                }

                            }

                            Label {
                                anchors.horizontalCenter: parent.horizontalCenter
                                text: (model.maxValue - model.value) + " g left"
                            }
                        }


                    }

                }


                }

        }

        ActionButton {
            anchors.horizontalCenter: parent.right
            anchors.verticalCenter: parent.bottom
            anchors.horizontalCenterOffset: dp(-width)
            anchors.verticalCenterOffset: dp(-height)
            iconName: "plus"
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
