import QtQuick 2.5
import QtQuick.Layouts 1.1
import Material 0.3
import Material.ListItems 0.1
import Material.Extras 0.1

Page {
    title: qsTr("Add food")

    IntValidator {
        id: intValidator
    }

    ListModel {
        id: dummyModel
        ListElement {
            name: "Calories"
            placeholder: "required"
//            validator: intValidator
        }
        ListElement {
            name: "Proteins"
            placeholder: "required"
//            validator: intValidator
        }
        ListElement {
            name: "Carbs"
            placeholder: "required"
//            validator: intValidator
        }
        ListElement {
            name: "Fats"
            placeholder: "required"
//            validator: intValidator
        }
    }

    TextForm {
        model: dummyModel
    }

    StandardActionButton {
        AwesomeIcon {
            anchors.centerIn: parent
            name: "plus"
        }
    }
}
