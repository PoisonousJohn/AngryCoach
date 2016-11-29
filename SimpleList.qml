
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

    signal itemClicked(int modelIndex)
    signal itemPressAndHold(int modelIndex)

    implicitHeight: maxHeight

    anchors.left: parent.left
    anchors.right: parent.right

    DelegateModel {
        id: delegateModel
        delegate: StandardWithDivider {
            id: listDelegate

            textItem.onContentWidthChanged: {
                maxTextWidth = Math.max(textItem.contentWidth + 33 * Units.dp, maxTextWidth)
            }
            text: {
                return defaultModelValue.length > 0 ? modelData[defaultModelValue] : modelData;
            }
            onClicked: {
                itemClicked(modelIndex);
            }
            onPressAndHold: {
                itemPressAndHold(modelIndex)
            }
        }
    }


    Subheader {
        id: header
        visible: text.length > 0
    }

    Rectangle {
        color: "white"
        anchors {
           top: header.visible ? header.bottom : parent.top
           bottom: parent.bottom
           left: parent.left
           right: parent.right
        }
        ListView {
            id: listView
            model: delegateModel
            clip: true
            anchors {
                fill: parent
            }
        }

    }

}


