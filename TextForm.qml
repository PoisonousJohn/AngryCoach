import QtQuick 2.0
import QtQuick.Layouts 1.1
import Material 0.3
import Material.ListItems 0.1


ColumnLayout {
    id: textForm
    property alias model: repeater.model

    Subheader {
        text: qsTr("Basic information")

    }

    Card {
        anchors { left: parent.left; right: parent.right }
        height: basicList.height

        ColumnLayout {
            id: basicList
            anchors { left: parent.left; right: parent.right }
            Repeater {
                id: repeater
                model: 4
                Standard {
                    anchors.left: parent.left
                    anchors.right: parent.right
                    height: 100
                    text: model.name
                    secondaryItem: TextField {
                        text: model.value
                        focus: model.index === 0
                        showBorder: false
                        horizontalAlignment: TextInput.AlignRight
                        placeholderText: model.hasOwnProperty("placeholder")
                                                ? model.placeholder
                                                : undefined
                        width: basicList.width * 0.5
                        anchors.verticalCenter: parent.verticalCenter
                        style: GridTextFieldStyle {
                            placeholderHorizontalAlignment: TextInput.AlignRight
                        }
                    }
                }
            }

        }


    }


    anchors { left: parent.left; right: parent.right }


}
