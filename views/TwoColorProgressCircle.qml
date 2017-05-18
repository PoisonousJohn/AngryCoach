import QtQuick 2.0
import Material 0.3


Item {
    id: twoColorProgressCircle


    property alias value: mainCircle.value
    property int dashThickness: 8;
    property color mainColor: Theme.primaryColor;
    property color bgColor: Theme.backgroundColor;


    StaticProgressCircle {
        id: bgCircle
        color: bgColor
        anchors.fill: parent
        anchors.centerIn: parent
        indeterminate: false
        value: 1
        dashThickness: twoColorProgressCircle.dashThickness
    }

    StaticProgressCircle {
        id: mainCircle
        color: mainColor
        anchors.fill: parent
        anchors.centerIn: parent
        indeterminate: false
        dashThickness: twoColorProgressCircle.dashThickness
    }

}
