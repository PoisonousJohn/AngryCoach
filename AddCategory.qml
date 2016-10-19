import QtQuick 2.0
import QtQuick.Layouts 1.1
import Material 0.3
import Material.ListItems 0.1 as ListItem

Page {
    id: addCategory
    title: qsTr("Add category")

    ColumnLayout {
        anchors.top: parent.top
        anchors.topMargin: dp(40)
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.margins: dp(20)
        TextField {
            placeholderText: qsTr("Enter category name")
            Layout.fillWidth: true
            height: dp(40)
        }
    }

    StandardActionButton {
        AwesomeIcon {
           name: "plus"
           color: Theme.dark.textColor
           anchors.centerIn: parent
        }

    }



}
