import QtQuick 2.0
import QtQuick.Layouts 1.1
import Material 0.3
import Material.ListItems 0.1

Card {
    property date day: new Date()
    height: content.implicitHeight
    anchors {
        left: parent.left
        right: parent.right
    }

    Connections {
        target: dataManager
        onDayLogChanged: {
            repeater.model = dataManager.getDayLog(date)
        }
    }

    ColumnLayout {
        id: content

        anchors {
            left: parent.left
            right: parent.right
        }

        Subheader {
            text: qsTr("Eaten today")
        }

        Repeater {
            id: repeater
            model: dataManager.getDayLog(day)
            delegate: Standard {
                text: modelData["Name"]
            }
        }

        Standard {
            text: qsTr("Looks like you eat nothing");
            visible: repeater.count == 0
        }
    }


}
