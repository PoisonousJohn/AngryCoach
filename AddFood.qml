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
            anchors { left: parent.left; right: parent.right }

            ColumnLayout {
                id: basicList
                anchors.fill: parent
                Repeater {
                    anchors.fill: parent
                    model: 3

//                    delegate:  Rectangle {
//                        color: "red"
//                        width: 100
//                        height: 100
//                    }
                     Standard {
                         anchors.left: parent.left
                         anchors.right: parent.right
                        height: 100
                        text: "test text" + model.index
                        valueText: "value text"
                    }
                }

            }


//            Repeater {
//                anchors {
//                    left: parent.left;
//                    right: parent.right;
//                }
//                model: 3
//                delegate:  Standard {
//                    text: "test text"
//                    valueText: "value text"
//                }
//            }

//            GridLayout {
//                id: grid
//                columns: 2
//                anchors {
//                    left: parent.left;
//                    right: parent.right;
//                    rightMargin: dp(20);
//                    leftMargin: dp(20);
//                }

//                Label {
//                    text: qsTr("Title")
//                    Layout.minimumWidth: parent.width * 0.3
//                }

//                TextField {
//                    Layout.alignment: Qt.AlignRight
//                    Layout.fillWidth: true
//                    placeholderText: qsTr("required")
//                    horizontalAlignment: TextInput.AlignRight
//                    showBorder: false
//                    style: GridTextFieldStyle{
//                        placeholderHorizontalAlignment: TextInput.AlignRight
//                    }

//                }


//            }

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
