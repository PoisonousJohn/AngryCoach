import QtQuick 2.5
import QtQuick.Layouts 1.1
import Material 0.3

Card {
    Component.onCompleted: {
        var log = dataManager.todayLog;
        console.log(log);
    }

    anchors.left: parent.left
    anchors.right: parent.right
    height: stats.height + dp(40)
    ColumnLayout {
        id: stats
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        RowLayout {
            id: totalStats
            spacing: dp(50)
            anchors.horizontalCenter: parent.horizontalCenter
            Text {
                text: "0\n EATEN"
                horizontalAlignment: Text.AlignHCenter
            }
            Rectangle {
                radius: width * 0.5
                width: dp(100)
                height: dp(100)
                ProgressCircle {
                    width: dp(110)
                    height: dp(110)
                    Text {
                        text: "2401\nKCAL LEFT"
                        anchors.centerIn: parent
                        horizontalAlignment: Text.AlignHCenter
                    }
                    anchors.centerIn: parent
                    indeterminate: false
                    value: 1
                    dashThickness: dp(8)
                }
            }

            Text {
                width: 300
                text: "0\n BURNED"
                horizontalAlignment: Text.AlignHCenter
            }

        }
        RowLayout {
            id: parameters
            anchors.topMargin: dp(50)
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.leftMargin: dp(20)
            anchors.rightMargin: dp(20)
            spacing: 10
            Repeater {
                id: repeater
                model: dummyModel
                ColumnLayout {

                    Label {
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: name
                    }

                    ProgressBar {
                        implicitWidth: window.width / repeater.model.count - dp(parameters.spacing * 2)
                        indeterminate: false
                        value: model.value / model.maxValue
                    }

                    Label {
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: (model.maxValue - model.value) + " g left"
                    }
                }


            }

        }


        }

}
