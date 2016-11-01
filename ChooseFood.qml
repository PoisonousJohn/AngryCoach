import QtQuick 2.5
import QtQuick.Layouts 1.1
import Material 0.3
import QtQuick.Controls.Styles.Material 0.1 as MaterialStyle

SearchList {
    id: searchFood
    title: qsTr("Choose food")
    visible: false
    model: dataManager.food
    defaultModelField: "Name"
    onItemSelected: {
        console.log("Adding food to log: " + item["Id"] + " for date " + dayLog.day);
        chooseFoodAmount.food = item;
        pageStack.push(chooseFoodAmount);
        //            dataManager.addFoodToLog(dayLog.day, item["Id"])
        //            pageStack.pop()
    }
    
    StandardActionButton {
        AwesomeIcon {
            anchors.centerIn: parent
            name: "plus"
        }
        
        onClicked: {
            pageStack.push(addFood)
        }
    }
}
