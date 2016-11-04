import QtQuick 2.5
//import QtQuick.Controls 1.4
import QtQuick.Layouts 1.1
import Material 0.3

/**
  * todo:
  * 1. Amount of food when adding to log -- Done
  * 2. Editing of food item -- Done
  * 3. Deleting of food item -- Done
  * 4. Day switching
  * 5. Body index formula -- Done
  * 6. Search by food name
  * 7. Field validation on adding food -- Done
  * 8. Field validation on adding log -- Done
  * 9. ProgressCircle overflow -- Done
  * 10. Food categories
  * 11. Separate log by breakfast/lunch/dinner/snack
  * 12. Localization
  * 13. Custom servings
  */


ApplicationWindow {
    UserProfile {
        id: userProfile
    }
    id: window
    theme.primaryColor: "indigo"
    initialPage: MainPage {}
    visible: true
    width: 480
    height: 852

    Component.onCompleted: {
        if (dataManager.userProfile["Weight"] === 0)
        {
            pageStack.push(userProfile)
        }
    }


}
