import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles.Material 0.1 as Material

Material.ProgressBarStyle {
    id: roundedProgressBarStyle

    Component.onCompleted: {
        backgroundLoader.visible = false;
    }
}
