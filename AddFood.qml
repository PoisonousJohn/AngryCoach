import QtQuick 2.5
import QtQuick.Layouts 1.1
import Material 0.3
import Material.ListItems 0.1
import Material.Extras 0.1

Page {
    id: addFood
    title: qsTr("Add food product")


    ColumnLayout {
        Subheader {
            text: qsTr("Basic information")

        }

        Card {
            height: grid.height
            anchors { left: parent.left; right: parent.right }
            GridLayout {
                id: grid
                columns: 2
                anchors {
                    left: parent.left;
                    right: parent.right;
                    rightMargin: dp(20);
                    leftMargin: dp(20);
                }

                Label {
                    text: qsTr("Title")
                    Layout.minimumWidth: parent.width * 0.3
                }

                TextField {
                    Layout.alignment: Qt.AlignRight
                    Layout.fillWidth: true
                    placeholderText: qsTr("required")
                    horizontalAlignment: TextInput.AlignRight
                    showBorder: false
                    style: GridTextFieldStyle{
                        placeholderHorizontalAlignment: TextInput.AlignRight
                    }

                }
                Label {
                    text: qsTr("Title")
                    Layout.minimumWidth: parent.width * 0.3
                }

                TextField {
                    Layout.alignment: Qt.AlignRight
                    Layout.fillWidth: true
                    placeholderText: qsTr("required")
                    horizontalAlignment: TextInput.AlignRight
                    showBorder: false
                    style: GridTextFieldStyle{
                        placeholderHorizontalAlignment: TextInput.AlignRight
                    }

                }

            }

        }


        anchors { left: parent.left; right: parent.right }

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
