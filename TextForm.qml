import QtQuick 2.0
import QtQuick.Layouts 1.1
import Material 0.3
import Material.ListItems 0.1


ColumnLayout {
    id: textForm
    property alias model: repeater.model

    function formData() {
        var data = {};
        for (var i = 0; i < model.count; ++i) {
            data[model.get(i).fieldName] = basicList.children[i].value;
        }

        return data;
    }

    Subheader {
        text: qsTr("Basic information")

    }

    Card {
        anchors { left: parent.left; right: parent.right }
        height: basicList.height

        ColumnLayout {
            id: basicList
            spacing: 0
            anchors { left: parent.left; right: parent.right }
            Repeater {
                id: repeater
                model: 4
                delegate: Standard {
                    elevation: 1
                    property alias value: textField.text
                    anchors.left: parent.left
                    anchors.right: parent.right
                    height: 100
                    text: model.name
                    secondaryItem: TextField {
                        id: textField
                        text: model.value
                        focus: model.index === 0
                        showBorder: false
                        horizontalAlignment: TextInput.AlignRight
                        placeholderText: model.hasOwnProperty("placeholder")
                                                ? model.placeholder
                                                : null
                        validator: model.hasOwnProperty("validator")
                                                ? model.validator
                                                : null

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
