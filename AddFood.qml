import QtQuick 2.5
import QtQuick.Layouts 1.1
import Material 0.3
import Material.Extras 0.1

Page {
    id: addFood
    title: qsTr("Add food product")


    ColumnLayout {
        anchors { left: parent.left; right: parent.right }
        Card {
            height: dp(80)
            anchors { left: parent.left; right: parent.right }

            ColumnLayout {

                Label {
                    text: qsTr("Name")
                }
                TextField {
                    Layout.fillWidth: true;
                    placeholderText: qsTr("Meat")
                }
            }

        }

        Card {
            height: dp(100)
            anchors { left: parent.left; right: parent.right }
            RowLayout {

                anchors.horizontalCenter: parent.horizontalCenter
                ColumnLayout {

                    Label {
                        text: qsTr("Calories")
                    }
                    TextField {
                        implicitWidth: dp(40)
                    }
                }
                ColumnLayout {

                    Label {
                        text: qsTr("Calories")
                    }
                    TextField {
                        implicitWidth: dp(20)
                    }
                }
                ColumnLayout {

                    Label {
                        text: qsTr("Calories")
                    }
                    TextField {
                        implicitWidth: dp(20)
                    }
                }
                ColumnLayout {

                    Label {
                        text: qsTr("Calories")
                    }
                    TextField {
                        implicitWidth: dp(20)
                    }
                }

            }

        }

    }


    StandardActionButton {
        onClicked: {
           nav.open()
        }

        AwesomeIcon {
            anchors.centerIn: parent
            name: "plus"
        }
    }
}
