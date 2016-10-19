import QtQuick 2.5
import QtQuick.Layouts 1.1
import Material 0.3
import Material.ListItems 0.1

Page {
    id: categoriesList
    title: "Categories"

    actions: [
        Action {
            name: "Search"
            iconName: "action/search"
        }
    ]

    actionBar {
       customContent: TextField {
           color: Palette.colors["white"]["500"]
           textColor: Palette.colors["white"]["500"]
           placeholderText: "Search..."
           anchors {
               left: parent.left
               right: parent.right
               verticalCenter: parent.verticalCenter
           }
       }
    }

    ListModel {
        id: dummyCategories
        ListElement {
            name: "Category 1"
        }
        ListElement {
            name: "Category 2"
        }
        ListElement {
            name: "Category 3"
        }
        ListElement {
            name: "Category 4"
        }
    }

    ColumnLayout {
        anchors.left: parent.left
        anchors.right: parent.right

        Subheader {
            text: "Categories"
        }

        ListView {
            anchors.left: parent.left
            anchors.right: parent.right
            height: count * 100
            model: dummyCategories
            delegate: BaseListItem {
                Text {
                    anchors.verticalCenter: parent.verticalCenter
                    text: model.name
                }
            }
        }


    }


}
