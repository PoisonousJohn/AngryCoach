import QtQuick 2.5
import QtQuick.Layouts 1.1
import Material 0.3

ColumnLayout {
    id: progressBarWithNameAndDesc

    property alias progressBarValue: progressBar.value
    property alias name: nameLabel.text
    property alias description: descLabel.text
    property alias color: progressBar.color
    property alias overflowColor: progressBar.overflowColor

    spacing: dp(10)

    Label {
        id: nameLabel
        anchors.horizontalCenter: parent.horizontalCenter
//        text: name
    }
    
    OverflowableProgressBar {
        id: progressBar
        implicitWidth: parent.width
    }
    
    Label {
        id: descLabel
        anchors.horizontalCenter: parent.horizontalCenter
        //                        text: (model.maxValue - model.value) + " g left"
//        text: card["carbs"] + " g left"
    }
}
