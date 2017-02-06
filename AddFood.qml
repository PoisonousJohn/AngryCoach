import QtQuick 2.5
import QtQuick.Layouts 1.1
import Material 0.3
import Material.ListItems 0.1
import Material.Extras 0.1
import "formHelper.js" as FormHelper
import 'stores'
import 'singletons'

ScrollablePage {
    property bool isEditing: MainStore.food.isEditing
    property var formValues: MainStore.food.food

    onFormValuesChanged: {
        console.log("form values changed: " + formValues)
        name.value = formValues ? formValues["Name"] : ""
        totalCalories.value = formValues ? formValues["TotalCalories"] : ""
        fats.value = formValues ? formValues["Fats"] : ""
        proteins.value = formValues ? formValues["Proteins"] : ""
        carbs.value = formValues ? formValues["Carbs"] : ""
        weight.value = formValues ? formValues["Weight"] : "100"
    }

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
        Qt.inputMethod.reset();
        Qt.inputMethod.hide()
//        foodId = ""
//        formValuesChanged();
        AppActions.cancelEditFood();
    }

    title: isEditing ? qsTr("Edit food") : qsTr("Add food");
       actions: [
           Action {
               name: "Done"
               iconName: "action/done"
                enabled: {
                    return  FormHelper.notEmpty([name]) &&
                            FormHelper.numberGreaterThanZero(
                                [totalCalories, weight]
                            ) &&
                            FormHelper.numberGreaterOrEqualsZero(
                                [carbs,
                                fats,
                                proteins]
                            )
                }
               onTriggered:  {
                    if (isEditing)
                    {
                        dataManager.editFood(formValues["Id"], getFormData());
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
