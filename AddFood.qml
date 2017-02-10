import QtQuick 2.5
import QtQuick.Layouts 1.1
import Material 0.3
import Material.ListItems 0.1
import Material.Extras 0.1
import "formHelper.js" as FormHelper
import 'stores'
import 'singletons'

ScrollablePage {
    property bool isEditing: formValues["Id"] !== ""
    property var formValues: FoodStore.food

    onFormValuesChanged: {
        name.value = formValues["Name"]
        totalCalories.value = formValues["TotalCalories"]
        fats.value = formValues["Fats"]
        proteins.value = formValues["Proteins"]
        carbs.value = formValues["Carbs"]
        weight.value = formValues["Weight"]
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
//        AppActions.cancelEditFood();
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
                   AppActions.acceptFoodPageValues(getFormData());
                   pageStack.pop();
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
            value: formValues["TotalCalories"]
            inputHint: Qt.ImhFormattedNumbersOnly
        }

        StandardFormTextField {
            id: carbs
            label: qsTr("Carbs")
            value: formValues["Carbs"]
            validator: doubleValidator
            suffixText: qsTr("g")
            inputHint: Qt.ImhFormattedNumbersOnly
        }

        StandardFormTextField {
            id: proteins
            label: qsTr("Proteins")
            value: formValues["Proteins"]
            validator: doubleValidator
            suffixText: qsTr("g")
            inputHint: Qt.ImhFormattedNumbersOnly
        }

        StandardFormTextField {
            id: fats
            label: qsTr("Fats")
            value: formValues["Fats"]
            validator: doubleValidator
            suffixText: qsTr("g")
            inputHint: Qt.ImhFormattedNumbersOnly
        }

        StandardFormTextField {
            id: weight
            label: qsTr("Weight")
            value: formValues["Weight"]
            validator: doubleValidator
            suffixText: qsTr("g")
            inputHint: Qt.ImhFormattedNumbersOnly
        }

    }
}
