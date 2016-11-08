
import QtQuick 2.5
import QtQuick.Layouts 1.1
import QtQml.Models 2.2
import Material 0.3
import Material.ListItems 0.1

ColumnLayout {
    id: simpleList

    property alias delegateModel: delegateModel
    property string defaultModelValue: "";
    property int itemHeight: 100
    property alias interactive: listView.interactive
    property alias title: header.text
    property alias delegate: listView.delegate
    property alias model: delegateModel.model
    property int maxTextWidth;
    property int maxHeight: listView.model.count * itemHeight
    signal itemClicked(int modelIndex);

    implicitHeight: maxHeight

    anchors.left: parent.left
    anchors.right: parent.right

    DelegateModel {
        id: delegateModel
        delegate: Standard {
            id: listDelegate
            property int modelIndex: index
            height: itemHeight
            onClicked: {
                itemClicked(modelIndex)
            }

            Text {
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.margins: 16 * Units.dp
                anchors.verticalCenter: parent.verticalCenter
                text: {
                    return defaultModelValue.length > 0 ? modelData[defaultModelValue] : modelData;
                }
                onContentWidthChanged: {
                    maxTextWidth = Math.max(contentWidth + 33 * Units.dp, maxTextWidth)
                }
            }
        }
    }

    Subheader {
        id: header
        visible: text.length > 0
    }

    ListView {
        id: listView
        model: delegateModel
        clip: true
        anchors {
           top: header.visible ? header.bottom : parent.top
           bottom: parent.bottom
           left: parent.left
           right: parent.right
        }
    }

}


