import QtQuick 2.0
import QtQuick.Layouts 1.1
import Material 0.3
import Material.ListItems 0.1


ColumnLayout {
    id: textForm
    property alias model: repeater.model
    property var valuesModel;

    signal clear();

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
                    secondaryItem:  RowLayout {
                        anchors.verticalCenter: parent.verticalCenter
                        width: basicList.width * 0.5

                        TextField {
                            Connections {
                                target: textForm
                                onClear: {
                                    textField.text = ""
                                }
                            }

                            Layout.alignment: Qt.AlignRight
                            id: textField
                            text: {
                                if (valuesModel === undefined)
                                {
                                    return ""
                                }


                                var modelData = textForm.model.get(index);
                                var value = valuesModel[modelData["fieldName"]];
                                return value !== undefined ? value : ""
                            }

                            focus: model.index === 0
                            showBorder: false
                            horizontalAlignment: TextInput.AlignRight
                            placeholderText: model.hasOwnProperty("placeholder")
                                                    ? model.placeholder
                                                    : null
                            validator: {
                                var validator = textForm.model.get(index).validator;
                                return validator !== undefined ? validator : null
                            }

                            implicitWidth: basicList.width * 0.5 - postfix.implicitWidth
                            anchors.verticalCenter: parent.verticalCenter
                            style: GridTextFieldStyle {
                                placeholderHorizontalAlignment: TextInput.AlignRight
                            }

                        }

                        Label {
                            id: postfix
                            text: {
                                var postfix = textForm.model.get(index)["postfix"];
                                return postfix !== undefined ? postfix :  ""
                            }

                            visible: text.length > 0
                        }

                    }
                }
            }

        }


    }


    anchors { left: parent.left; right: parent.right }


}
