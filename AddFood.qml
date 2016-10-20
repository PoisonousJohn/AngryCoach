import QtQuick 2.5
import QtQuick.Layouts 1.1
import Material 0.3
import Material.ListItems 0.1
import Material.Extras 0.1

Page {
    title: qsTr("Add food")

    ListModel {
        id: dummyModel
        ListElement {
            name: "Calories"
            placeholder: "required"
        }
        ListElement {
            name: "Proteins"
            placeholder: "required"
        }
        ListElement {
            name: "Carbs"
            placeholder: "required"
        }
        ListElement {
            name: "Fats"
            placeholder: "required"
        }
    }

    TextForm {
        model: dummyModel
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
