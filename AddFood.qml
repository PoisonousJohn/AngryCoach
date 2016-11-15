import QtQuick 2.5
import QtQuick.Layouts 1.1
import Material 0.3
import Material.ListItems 0.1
import Material.Extras 0.1
import "formHelper.js" as FormHelper

ScrollablePage {
    property bool isEditing: foodId.length > 0
    property string foodId;
    property var formValues: isEditing ? dataManager.getFoodValuesForForm(foodId) : null

    function getFormData() {
        return {
            "Name": name.value,
            "TotalCalories": totalCalories.value,
            "Carbs": carbs.value,
            "Proteins": proteins.value,
            "Fats": fats.value,
            "Weight": weight.value,
        };
    }

    onGoBack: {
        foodId = ""
    }

    title: isEditing ? qsTr("Edit food") : qsTr("Add food");
       actions: [
           Action {
               name: "Done"
               iconName: "action/done"
                enabled: {
                    return  FormHelper.notEmpty([name]) &&
                            FormHelper.numberGreaterThanZero(
                                [totalCalories,
                                carbs,
                                fats,
                                proteins,
                                weight]
                            )
                }
               onTriggered:  {
                    if (isEditing)
                    {
                        dataManager.editFood(foodId, getFormData());
                    }
                    else
                    {
                        dataManager.addFood(getFormData());
                    }

                    pageStack.pop()
               }
           }
       ]

    DoubleValidator {
        id: doubleValidator
        bottom: 0.1
        decimals: 2
    }

    scrollableContent:  ColumnLayout {
        id: formLayout
        anchors.topMargin: dp(10)
        spacing: dp(10)
        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
        }

        StandardFormTextField {
            id: name
            label: qsTr("Name")
            value: formValues !== null ? formValues["Name"] : ""
        }

        StandardFormTextField {
            id: totalCalories
            label: qsTr("Total Calories")
            validator: doubleValidator
            suffixText: qsTr("kcal")
            value: formValues !== null ? formValues["TotalCalories"] : ""
            inputHint: Qt.ImhFormattedNumbersOnly
        }

        StandardFormTextField {
            id: carbs
            label: qsTr("Carbs")
            value: formValues !== null ? formValues["Carbs"] : ""
            validator: doubleValidator
            suffixText: qsTr("g")
            inputHint: Qt.ImhFormattedNumbersOnly
        }

        StandardFormTextField {
            id: proteins
            label: qsTr("Proteins")
            value: formValues !== null ? formValues["Proteins"] : ""
            validator: doubleValidator
            suffixText: qsTr("g")
            inputHint: Qt.ImhFormattedNumbersOnly
        }

        StandardFormTextField {
            id: fats
            label: qsTr("Fats")
            value: formValues !== null ? formValues["Fats"] : ""
            validator: doubleValidator
            suffixText: qsTr("g")
            inputHint: Qt.ImhFormattedNumbersOnly
        }

        StandardFormTextField {
            id: weight
            label: qsTr("Weight")
            value: formValues !== null ? formValues["Weight"] : "100"
            validator: doubleValidator
            suffixText: qsTr("g")
            inputHint: Qt.ImhFormattedNumbersOnly
        }

    }
}
