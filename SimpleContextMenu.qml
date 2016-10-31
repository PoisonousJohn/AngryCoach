import QtQuick 2.5
import QtQuick.Layouts 1.1
import Material 0.3
import Material.ListItems 0.1

Dropdown {
    id: simpleContextMenu

    signal itemClicked(int itemIndex);

    property alias model: menuList.model
    property alias maxTextWidth: menuList.maxTextWidth

    height: menuList.height
    width: maxTextWidth

    SimpleList {
//        title: "test"
//        Rectangle {
//            anchors.fill: parent
//            color: "red"
//        }

        id: menuList
        height: maxHeight
        itemHeight: dp(30)
        interactive: false
        onItemClicked: {
            simpleContextMenu.itemClicked(modelIndex);
            simpleContextMenu.close();
        }
    }


}
