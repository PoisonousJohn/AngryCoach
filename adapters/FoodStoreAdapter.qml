import QtQuick 2.0
import '../stores'

Item {
    Component.onCompleted: {
        FoodStore.waitFor = [DayLogStore.listenerId];
    }

}
