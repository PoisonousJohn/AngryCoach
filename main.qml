import QtQuick 2.5
//import QtQuick.Controls 1.4
import QtQuick.Layouts 1.1
import QtQuick.Controls.Styles 1.4
import Material 0.3
import "./singletons"

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
    function delay(delayTime, cb) {
        timer = new Timer();
        timer.interval = delayTime;
        timer.repeat = false;
        timer.triggered.connect(cb);
        timer.start();
    }

    visible: false
    signal initialLoaded;
    contentItem {
        opacity: 0
        Behavior on opacity {
            NumberAnimation {
                duration: 500
            }
        }
    }

//    Rectangle {
//        id: colorRect
//        anchors.fill: parent
//        color: "red"
//        Behavior on opacity {
//            NumberAnimation {
//                duration:  10000
//            }
//        }
//    }

    style: ApplicationWindowStyle {

        background: Rectangle {
            anchors.fill: parent
            color: Palette.colors["indigo"]["500"]
        }
    }

//    backgroundColor: Palette.colors["deepBlue"]["500"]

    PageLoader {
        id:userProfile
        pagePath: "UserProfile.qml"
    }

    id: window
    theme.primaryColor: "indigo"

    Loader {
        id: initialPageLoader
        asynchronous: true
//        sourceComponent: MainPage{
//            visible: false
//            canGoBack: false
//        }
        focus: true
        anchors.fill: parent
        onLoaded: {
            initialLoaded();
        }
    }

    initialPage: Page {}

    width: 480
    height: 852

    onInitialLoaded: {
        console.log("loaded")
        window.visible = true
        window.contentItem.opacity = 1
        pageStack.clear()
        pageStack.push(initialPageLoader.item)
        initialPageLoader.item.canGoBack = false
        MainPageStack.pageStack = pageStack
        if (dataManager.userProfile["Weight"] === 0)
        {
            userProfile.loadPage()
            userProfile.item.canGoBack = false
        }
    }

    Component.onCompleted: {
        initialPageLoader.setSource("MainPage.qml", {canGoBack: false})
    }


}
