import QtQuick 2.0
import QtQuick.Layouts 1.0
import Material 0.3
import Material.ListItems 0.1

Standard {

    property alias label: formLabel.text
    property alias value: textField.text
    property alias validator: textField.validator
    property alias helperText: textField.helperText
    property alias suffixText: suffix.text

    RowLayout {
        anchors {
            verticalCenter:  parent.verticalCenter
            margins: dp(10)
            left: parent.left
            right: parent.right
        }
        
        Label {
            id: formLabel
            style: "body2"
            Layout.minimumWidth: parent.width * 0.2
        }
        TextField {
            id: textField
            height: dp(100)
            Layout.preferredWidth: 0.8 * parent.width - suffix.width - (suffix.visible ? parent.anchors.rightMargin : 0)
            placeholderText: qsTr("required")
            Layout.alignment: Qt.AlignRight
        }
        Label {
            id: suffix
            visible: text.length > 0
        }
        
    }
    
}
