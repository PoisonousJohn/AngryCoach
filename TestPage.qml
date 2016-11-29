import QtQuick 2.5
import QtQuick.Controls 2.0
//import Material 0.3
//import Material.ListItems 0.1

Page {
    property bool canGoBack;

    ListView {
        anchors.fill: parent
        model: 50
        delegate: Item {
            clip: true
            height: 50
            anchors {
                left: parent.left
                right: parent.right
            }

            Rectangle {
                color: "red"
                anchors.fill: parent
            }
            Label {
                text: index
            }

        }
    }

}




