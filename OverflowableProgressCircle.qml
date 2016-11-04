import QtQuick 2.5
import Material 0.3

Item {
    id: overflowableProgressCircle

    property color backgroundColor: Theme.backgroundColor
    property color overflowColor: Theme.accentColor
    property alias indeterminate: mainProgress.indeterminate
    property alias color: mainProgress.color
    property alias dashThickness: mainProgress.dashThickness
    property double value;

    StaticProgressCircle {
        anchors.centerIn: parent
        color: backgroundColor
        width: parent.width
        height: parent.height
        dashThickness: overflowableProgressCircle.dashThickness
        indeterminate: false
        value: 1
        visible: overflowableProgressCircle.value <= 1
    }

    StaticProgressCircle {
        id: mainProgress

        width: parent.width;
        height: parent.height;
        value: Math.min(1, overflowableProgressCircle.value)

    }

    StaticProgressCircle {
        anchors.centerIn: parent
        color: overflowColor
        width: parent.width
        height: parent.height
        dashThickness: parent.dashThickness
        indeterminate: false
        value: overflowableProgressCircle.value > 1 ? Math.min(1, overflowableProgressCircle.value - 1) : 0
        visible: overflowableProgressCircle.value > 1
    }

}
