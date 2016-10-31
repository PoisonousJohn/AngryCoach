
import QtQuick 2.5
import QtQuick.Layouts 1.1
import Material 0.3
import Material.ListItems 0.1

ColumnLayout {
    id: simpleList

    property string defaultModelValue: "name"
    property int itemHeight: 100
    property alias title: header.text
    property alias delegate: listView.delegate
    property alias model: listView.model
    signal itemClicked(int modelIndex);

    anchors.left: parent.left
    anchors.right: parent.right

    Subheader {
        id: header
        text: "Categories"
        visible: text.length > 0
    }

    ListView {
        id: listView
        anchors.left: parent.left
        anchors.right: parent.right
        height: count * itemHeight
        delegate: BaseListItem {
            id: listDelegate
            property int modelIndex: index
            implicitHeight: 100
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
                    return modelData[defaultModelValue];
                }
            }
        }
    }

}


