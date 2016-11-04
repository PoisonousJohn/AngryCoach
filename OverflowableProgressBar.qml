import QtQuick 2.5
import Material 0.3

Item {
    id: overflowableProgressBar
    property double value;
    property color color: Theme.primaryColor;
    property color overflowColor: Theme.accentColor;
    property bool indeterminate: false;

    ProgressBar {
        id: mainProgressBar
        value: Math.min(overflowableProgressBar.value, 1.0)
        color: overflowableProgressBar.color
        width: overflowableProgressBar.width
        indeterminate: indeterminate
        maximumValue: 1.0
    }

    Rectangle {
        id: overflowRect
        anchors.right: mainProgressBar.right
        anchors.top: mainProgressBar.top
        anchors.bottom: mainProgressBar.bottom
        width: (overflowableProgressBar.value > 1 ? Math.min(overflowableProgressBar.value - 1, 1) : 0) * parent.width

        visible: overflowableProgressBar.value > 1.0
        color: overflowColor
    }

    Rectangle {
        color: overflowColor
        width: dp(3)
        height: mainProgressBar.height * 2
        anchors.verticalCenter: overflowRect.verticalCenter
        anchors.right: overflowRect.left
        visible: overflowRect.visible
    }

//    ProgressBar {
//        id: overflowProgressBar
//        visible: overflowableProgressBar.value > 1.0
//        value: overflowableProgressBar.value > 1 ? Math.min(overflowableProgressBar.value - 1, 1) : 0
//        color: overflowColor
//        width: overflowableProgressBar.width
//        indeterminate: indeterminate
//        maximumValue: 1.0
//        rotation: 180
//    }

}
