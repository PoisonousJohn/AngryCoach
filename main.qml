import QtQuick 2.5
//import QtQuick.Controls 1.4
import QtQuick.Layouts 1.1
import Material 0.2

ApplicationWindow {
    id: window
    theme.primaryColor: "indigo"
    initialPage: AddCategory {}
    ListModel {
        id: dummyModel
        ListElement {
            name: "carbs"
            value: 100
            maxValue: 300
        }
        ListElement {
            name: "protein"
            value: 50
            maxValue: 300
        }
        ListElement {
            name: "fat"
            value: 200
            maxValue: 300
        }
    }

    visible: true
    width: 480
    height: 852
    title: qsTr("Hello World")


}
