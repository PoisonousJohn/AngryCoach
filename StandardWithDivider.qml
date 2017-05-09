import QtQuick 2.5
import QtQuick.Layouts 1.1
import QtQml.Models 2.2
import Material 0.3
import Material.ListItems 0.1

Standard {
    id: listDelegate
    property int modelIndex: index
    property alias textItem: textItem
    property alias text: textItem.text
    height: itemHeight

    ThinDivider {
        anchors.bottom: parent.bottom
//        anchors.bottomMargin: dp(-0.5)
        color: Qt.rgba(0,0,0,0.05)

    }
    
    Text {
        id: textItem
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.margins: 16 * Units.dp
        anchors.verticalCenter: parent.verticalCenter
    }
}
