import QtQuick 2.0
import QtQuick.Layouts 1.0
import Material 0.3
import Material.ListItems 0.1

Standard {

    property alias label: textField.placeholderText
    property alias value: textField.text
    property alias displayValue: textField.displayText
    property alias validator: textField.validator
    property alias helperText: textField.helperText
    property alias suffixText: suffix.text
    property alias inputHint: textField.inputMethodHints
    onFocusChanged: {
        console.log("Focus changed: " + focus)
        textField.focus = focus
    }

    RowLayout {
        anchors {
            verticalCenter:  parent.verticalCenter
            margins: dp(10)
            left: parent.left
            right: parent.right
        }
        
//        Label {
//            id: formLabel
//            style: "body2"
//            Layout.minimumWidth: parent.width * 0.2
//        }
        TextField {
            id: textField
            focus: parent.focus
            floatingLabel: true
            height: dp(100)
            Layout.preferredWidth: parent.width - (suffix.visible ? suffix.width + parent.anchors.rightMargin : parent.anchors.rightMargin * 0.5)
            Layout.alignment: Qt.AlignRight
        }
        Label {
            id: suffix
            visible: text.length > 0
        }
        
    }

    onClicked: {
        textField.focus = true
    }
    
}
