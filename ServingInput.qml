import QtQuick 2.0
import QtQuick.Layouts 1.1
import Material 0.3
import 'stores'
import 'singletons'

Card {
    property string defaultValue
    property alias value: amount.displayText

    id: servingInput

    anchors {
        left: parent.left
        right: parent.right
    }
    
    height: servingLayout.implicitHeight + dp(20)
    
    RowLayout {
        id: servingLayout
        x: dp(10)
        anchors.verticalCenter: parent.verticalCenter
        Label {
            style: "body2"
            text: qsTr("Serving: ")
        }
        
        TextField {
            id: amount
            text: defaultValue
            implicitWidth: dp(50)
            maximumLength: 9
            inputMethodHints: Qt.ImhFormattedNumbersOnly
            validator: DoubleValidator {
                decimals: 2
                bottom: 0
            }
        }
        
        Label {
            text: qsTr("g")
        }
    }
}
