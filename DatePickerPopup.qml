import QtQuick 2.5
import QtQuick.Layouts 1.1
import Material 0.2
import QtQuick.Controls.Styles.Material 0.1 as MaterialStyle

PopupBase {
    id: datePickerPopup
    overlayLayer: "dialogOverlayLayer"
    overlayColor: Qt.rgba(0, 0, 0, 0.3)
    anchors.centerIn: parent
    
    opacity: showing ? 1 : 0
    visible: opacity > 0
    DatePicker {
        id: datePicker
        Component.onCompleted: dataManager.selectedDate = selectedDate
        selectedDate: new Date()
        anchors.centerIn: parent
        onSelectedDateChanged: {
            dataManager.selectedDate = selectedDate
        }
    }
}
