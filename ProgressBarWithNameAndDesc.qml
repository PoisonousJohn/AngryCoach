import QtQuick 2.5
import QtQuick.Layouts 1.1
import Material 0.3

ColumnLayout {
    id: progressBarWithNameAndDesc

    property alias progressBarValue: progressBar.value
    property alias name: nameLabel.text
    property alias description: descLabel.text

    Label {
        id: nameLabel
        anchors.horizontalCenter: parent.horizontalCenter
//        text: name
    }
    
    ProgressBar {
        id: progressBar
        implicitWidth: parent.width
        indeterminate: false
        //                        value: model.value / model.maxValue
//        value: card[key] / 100
    }
    
    Label {
        id: descLabel
        anchors.horizontalCenter: parent.horizontalCenter
        //                        text: (model.maxValue - model.value) + " g left"
//        text: card["carbs"] + " g left"
    }
}
