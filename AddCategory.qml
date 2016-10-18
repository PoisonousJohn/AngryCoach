import QtQuick 2.0
import QtQuick.Layouts 1.1
import Material 0.3
import Material.ListItems 0.1 as ListItem

Page {
    id: addCategory
    title: qsTr("Add category")


    ColumnLayout {
        anchors.verticalCenterOffset: dp(20)
        anchors.verticalCenter: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.margins: dp(20)
        TextField {
            Layout.fillWidth: true
            height: dp(40)
            helperText: qsTr("Enter category name")
        }
    }


    ActionButton {
        anchors.horizontalCenter: parent.right
        anchors.verticalCenter: parent.bottom
        anchors.horizontalCenterOffset: dp(-height)
        anchors.verticalCenterOffset: dp(-width)
    }



}
