import QtQuick 2.5
//import QtQuick.Controls 1.4
import QtQuick.Layouts 1.1
import Material 0.3

/**
  * todo:
  * 1. Amount of food when adding to log -- Done
  * 2. Editing of food item
  * 3. Deleting of food item
  * 4. Day switching
  * 5. Body index formula
  * 6. Search by food name
  * 7. Field validation on adding food
  * 8. Field validation on adding log
  */

ApplicationWindow {
    id: window
    theme.primaryColor: "indigo"
    initialPage: MainPage {}
    visible: true
    width: 480
    height: 852
    title: qsTr("Hello World")


}
