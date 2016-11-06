import QtQuick 2.5
import QtQuick.Layouts 1.1
import Material 0.2
import QtQuick.Controls.Styles.Material 0.1 as MaterialStyle

Item {
    property double radius: 100
    property string buttonsState: expanded ? "Shown" :  "Hidden"
    property bool expanded: false;
    property alias delegate: repeater.delegate
//    property alias model: repeater.model
    property var buttons;
    default property alias children: floatingMenuButton.children

    signal buttonClicked(int index);
    signal close();

    onClose: {
        expanded = false;
    }

    anchors.fill: parent

    MouseArea {
        enabled: expanded
        anchors.fill: parent
        onClicked: {
            expanded = false;
        }

    }

    onButtonClicked: {
        expanded = false
    }

    Repeater {
        id: repeater
        model: buttons
        delegate: Item {

            width: childrenRect.width
            height: childrenRect.height

            id: button
            property double step: Math.PI / (repeater.count + 1)
            property double startAngle: -Math.PI


            Component.onCompleted: {
                console.log("Model element: " + repeater.model[index])
                repeater.model[index].parent = button
            }

            state: buttonsState
            states: [
                State {
                    name: "Hidden"
                    PropertyChanges {
                        target: button
                        opacity: 0
                        anchors.horizontalCenterOffset: 0
                        anchors.verticalCenterOffset: 0
                    }
                    onCompleted: {
//                        button.visible = false
                    }
                },
                State {
                    name: "Shown"
                    PropertyChanges {
                        target: button
                        opacity: 1
                        visible: true
                        anchors.horizontalCenterOffset: radius * Math.cos(startAngle + step * index)
                        anchors.verticalCenterOffset: radius * Math.sin(startAngle + step * index)
                    }
                }

            ]

            transitions: [
                Transition {
                    from: "Hidden"
                    to: "Shown"
                    PropertyAnimation {
                        target: button
                        properties: "opacity,anchors.horizontalCenterOffset,anchors.verticalCenterOffset"
                        duration: 150
                    }
                },
                Transition {
                    from: "Shown"
                    to: "Hidden"
                    PropertyAnimation {
                        target: button
                        properties: "opacity,anchors.horizontalCenterOffset,anchors.verticalCenterOffset"
                        duration: 150
                    }
                }
            ]
            anchors {
                horizontalCenter: floatingMenuButton.horizontalCenter
                verticalCenter: floatingMenuButton.verticalCenter
            }

        }
    }

    StandardActionButton {
        id: floatingMenuButton
        backgroundColor: expanded ? Palette.colors["green"]["A700"] : Theme.accentColor

        onClicked: {
            expanded = !expanded
        }
    }
}

