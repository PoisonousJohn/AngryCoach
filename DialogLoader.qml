import QtQuick 2.5
import QtQuick.Layouts 1.1
import Material 0.2
import QtQuick.Controls.Styles.Material 0.1 as MaterialStyle

Loader {
    signal accepted;
    signal rejected;
    id: dialogLoader
    function show(dialogTitle, dialogText) {
        setSource("Material/Dialog.qml", { title: dialogTitle, text: dialogText})
        item.open();
    }
    
    Connections {
        target: dialogLoader.item
        onRejected: {
            dialogLoader.rejected();
            dialogLoader.source = ""
        }
        onAccepted: {
            dialogLoader.accepted();
            dialogLoader.source = ""
        }
    }
    
}
