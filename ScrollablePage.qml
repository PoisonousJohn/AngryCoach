import QtQuick 2.5
import Material 0.3

Page {
    property var scrollableContent;
//    onContentChanged: {
//        console.log(content)
//        content.parent = flickable.contentItem
//        flickable.contentHeight = content.implicitHeight
//        flickable.contentWidth = content.implicitWidth
//    }

    data: Flickable {
        id: flickable
        anchors.fill: parent
        contentWidth: parent.width;
        contentHeight: scrollableContent.implicitHeight;
        boundsBehavior: Flickable.StopAtBounds
//        contentHeight: dp(1000);
        Item {
            data: scrollableContent
            id: flickableContent
            anchors.fill: parent
        }
    }

}
