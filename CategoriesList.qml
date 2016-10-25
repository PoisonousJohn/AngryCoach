import QtQuick 2.5
SearchList {
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
    id: categoriesList
    title: qsTr("Categories")
    model: dummyCategories
}
