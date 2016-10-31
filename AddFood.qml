import QtQuick 2.5
import QtQuick.Layouts 1.1
import Material 0.3
import Material.ListItems 0.1
import Material.Extras 0.1

Page {
    title: qsTr("Add food")

    ListModel {
        id: fieldsModel
        ListElement {
            fieldName: "name"
            name: "Name"
            placeholder: "required"
            value: ""
        }
        ListElement {
            fieldName: "totalCalories"
            name: "Calories"
            placeholder: "required"
            value: ""
        }
        ListElement {
            fieldName: "proteins"
            name: "Proteins"
            placeholder: "required"
            value: ""
        }
        ListElement {
            fieldName: "carbs"
            name: "Carbs"
            placeholder: "required"
            value: ""
        }
        ListElement {
            fieldName: "fats"
            name: "Fats"
            placeholder: "required"
            value: ""
        }
    }

    data: Item {
        anchors.fill: parent
        TextForm {
            id: form
            model: fieldsModel
        }

        StandardActionButton {
            onClicked: {
                dataManager.addFood(form.formData());
                pageStack.pop()
            }

            AwesomeIcon {
                anchors.centerIn: parent
                name: "plus"
            }
        }
    }

}
