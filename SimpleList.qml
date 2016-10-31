
import QtQuick 2.5
import QtQuick.Layouts 1.1
import Material 0.3
import Material.ListItems 0.1

ColumnLayout {
    id: simpleList

    property string defaultModelValue: "";
    property int itemHeight: 100
    property alias interactive: listView.interactive
    property alias title: header.text
    property alias delegate: listView.delegate
    property alias model: listView.model
    property int maxTextWidth;
    property int maxHeight: listView.model.count * itemHeight
    signal itemClicked(int modelIndex);

    implicitHeight: maxHeight

    anchors.left: parent.left
    anchors.right: parent.right

    Subheader {
        id: header
        visible: text.length > 0
    }

    ListView {
        id: listView
        anchors {
           top: header.visible ? header.bottom : parent.top
           bottom: parent.bottom
           left: parent.left
           right: parent.right
        }

//        anchors.left: parent.left
//        anchors.right: parent.right
//        implicitHeight: count * itemHeight
//        height: parent.implicitHeight
        delegate: BaseListItem {
            id: listDelegate
            property int modelIndex: index
            height: itemHeight
            onClicked: {
//                console.log("current index " + modelIndex)
                itemClicked(modelIndex)
            }

            Text {
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.margins: 16 * Units.dp
                anchors.verticalCenter: parent.verticalCenter
                text: {
//                    console.log(modelData)
                    return defaultModelValue.length > 0 ? modelData[defaultModelValue] : modelData;
                }
                onContentWidthChanged: {
                    maxTextWidth = Math.max(contentWidth + 33 * Units.dp, maxTextWidth)
                }
            }
        }
    }

}


