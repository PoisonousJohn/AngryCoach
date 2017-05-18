import QtQuick 2.5
import QtQuick.Layouts 1.0
import Material 0.3
import Material.ListItems 0.1
import Fitness 0.1
import "formHelper.js" as FormHelper

Standard {
    property alias label: standardLabel.text
    property alias menuModel: menu.model
    property alias selectedIndex: menu.selectedIndex
    RowLayout {
        anchors {
            left: parent.left
            right: parent.right
            verticalCenter:  parent.verticalCenter
            margins: dp(10)
        }
        
        Label {
            id: standardLabel
            Layout.alignment: Qt.AlignLeft
            style: "body2"
        }
        
        MenuField {
            id: menu
            Layout.alignment: Qt.AlignRight
            Layout.preferredWidth: 0.8 * parent.width
        }
    }
}
