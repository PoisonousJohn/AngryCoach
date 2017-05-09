import QtQuick 2.5
//import QtQuick.Controls 1.4
import QtQuick.Layouts 1.1
import QtQuick.Controls.Styles 1.4
import Material 0.3
import './singletons'
import './adapters'
import './stores'

/**
  * todo:
  * 1. Amount of food when adding to log -- Done
  * 2. Editing of food item -- Done
  * 3. Deleting of food item -- Done
  * 4. Day switching -- Done
  * 5. Body index formula -- Done
  * 6. Search by food name -- Done
  * 7. Field validation on adding food -- Done
  * 8. Field validation on adding log -- Done
  * 9. ProgressCircle overflow -- Done
  * 10. Food categories
  * 11. Separate log by breakfast/lunch/dinner/snack
  * 12. Localization
  * 13. Custom servings
  */


ApplicationWindow {
    signal initialLoaded;

    function delay(delayTime, cb) {
        timer = new Timer();
        timer.interval = delayTime;
        timer.repeat = false;
        timer.triggered.connect(cb);
        timer.start();
    }

    //contextual stores

    FoodStore {
        id: foodStore
    }
    RecipesStore {
        id: recipesStore
    }
    DayLogStore {
        id: dayLogStore
    }
    UserProfileStore {
        id: userProfileStore
    }

    Component {
        id: modelComponent
        ListModel {
        }
    }

    function createListModel(parent) {
        var newModel = modelComponent.createObject(parent);
        return newModel;
    }

    visible: false
    contentItem {
        opacity: 0
        Behavior on opacity {
            NumberAnimation {
                duration: 500
            }
        }
    }

    style: ApplicationWindowStyle {

        background: Rectangle {
            anchors.fill: parent
            color: Palette.colors["indigo"]["500"]
        }
    }

    id: window
    theme.primaryColor: "indigo"


    initialPage: Page {}

    width: 480
    height: 852

    onInitialLoaded: {
        console.log("loaded")
        window.visible = true
        window.contentItem.opacity = 1
        pageStack.clear()
        pageStack.push(initialPageLoader.item)
        MainPageStack.pageStack = pageStack
        if (dataManager.userProfile["Weight"] === 0)
        {
            AppActions.openUserProfile();
            AppActions.lockUserProfilePage();
//            userProfile.loadPage()
//            userProfile.item.canGoBack = false
        }
    }

    Component.onCompleted: {
        initialPageLoader.setSource("MainPage.qml", {canGoBack: false})
    }


    Loader {
        id: initialPageLoader
        asynchronous: false
        focus: true
        anchors.fill: parent
        onLoaded: {
            initialLoaded();
        }
    }

    FoodStoreAdapter {}

}
