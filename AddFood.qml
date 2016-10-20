import QtQuick 2.5
import QtQuick.Layouts 1.1
import Material 0.3
import Material.ListItems 0.1
import Material.Extras 0.1

Page {

    TextForm {
        model: 3
    }

    StandardActionButton {
        onClicked: {
           nav.open()
        }

        AwesomeIcon {
            anchors.centerIn: parent
            name: "plus"
        }
    }
}
