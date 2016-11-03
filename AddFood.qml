import QtQuick 2.5
import QtQuick.Layouts 1.1
import Material 0.3
import Material.ListItems 0.1
import Material.Extras 0.1

Page {
    property bool isEditing: foodId.length > 0
    property string foodId;

    title: isEditing ? qsTr("Edit food") : qsTr("Add food");
    DoubleValidator {
        id: doubleValidator
        bottom: 0.1
        decimals: 2
//        notation: DoubleValidator.StandardNotation
    }

    onGoBack: form.clear();

    ListModel {
        id: fieldsModel
        Component.onCompleted: {
            fieldsModel.append(
                {
                    fieldName: "Name",
                    name: qsTr("Title"),
                    placeholder: qsTr("required")
                }
            );
            fieldsModel.append(
                {
                    fieldName: "TotalCalories",
                    name: qsTr("Total calories"),
                    placeholder: qsTr("required"),
                    validator: doubleValidator,
                }
            );
            fieldsModel.append(
                {
                    fieldName: "Carbs",
                    name: qsTr("Carbs"),
                    validator: doubleValidator,
                    placeholder: qsTr("required")
                }
            );
            fieldsModel.append(
                {
                    fieldName: "Proteins",
                    name: qsTr("Proteins"),
                    validator: doubleValidator,
                    placeholder: qsTr("required")
                }
            );
            fieldsModel.append(
                {
                    fieldName: "Fats",
                    name: qsTr("Fats"),
                    validator: doubleValidator,
                    placeholder: qsTr("required")
                }
            );
            fieldsModel.append(
                {
                    fieldName: "Weight",
                    name: qsTr("Weight"),
                    postfix: qsTr("g"),
                    validator: doubleValidator,
                    placeholder: qsTr("required")
                }
            );
        }
    }

    data: Item {
        anchors.fill: parent
        TextForm {
            id: form
            model: fieldsModel
            valuesModel: {
                console.log("values model changed");
                return isEditing ? dataManager.getFoodValuesForForm(foodId) : undefined;
            }
        }

        StandardActionButton {
            backgroundColor: isEditing ? Palette.colors["green"]["A700"] : Theme.accentColor
            onClicked: {
                if (isEditing)
                {
                    dataManager.editFood(foodId, form.formData());
                }
                else
                {
                    dataManager.addFood(form.formData());
                }

                pageStack.pop()
            }

            AwesomeIcon {
                anchors.centerIn: parent
                name: isEditing ? "check" : "plus"
            }
        }
    }

}
