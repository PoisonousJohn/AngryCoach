import QtQuick 2.5
import QtQuick.Layouts 1.1
import QtQml.Models 2.2
import Material 0.3
import Material.ListItems 0.1

Page {
    id: searchList

    property alias model: list.model
    property alias defaultModelField: list.defaultModelValue
    property alias listView: list
    property alias delegateModel: list.delegateModel
    property alias delegate: list.delegate
    property alias searchGroup: searchFilterGroup
    property alias searchField: searchField
    signal itemSelected(var item)

//    DelegateModel {
//        id: delegateModel

//    }

    onItemSelected: {
        clearSearch();
    }

    function clearSearch() {
        Qt.inputMethod.reset()
    }

    actions: [
        Action {
            name: "Search"
            iconName: "content/clear"
            visible: searchField.displayText.length > 0
            onTriggered: {
                clearSearch();
            }
        }
    ]

    actionBar {
       customContent: TextField {
           id: searchField
           height: Units.dp * 40
           color: Palette.colors["white"]["500"]
           textColor: Palette.colors["white"]["500"]
           placeholderText: qsTr("Search...")
           onDisplayTextChanged: {
               searchFilterGroup.filter = searchField.displayText
               list.delegateModel.filterOnGroup = searchFilterGroup.filter.length > 0 ? "searchFilter" : "items"

           }

           anchors {
               left: parent.left
               right: parent.right
               verticalCenter: parent.verticalCenter
           }
       }
    }

    SimpleList {
        id: list
        title: searchList.title

        delegateModel {
            groups: [
                DelegateModelGroup {
                    id: searchFilterGroup
                    includeByDefault: false
                    name: "searchFilter"
                    property string filter;
                    onFilterChanged: {

                        // remove all
                        var filterLowerCase = filter.toLowerCase();
                        var isArray = Array.isArray(model);
                        var modelCount = !isArray
                                                ? searchList.model.count
                                                : searchList.model.length;
                        for (var i = 0; i < modelCount; ++i)
                        {
                            var entry = !isArray ? list.model.get(i) : list.model[i];
                            var fits = filterLowerCase.length === 0 || entry[defaultModelField].toLowerCase().indexOf(filterLowerCase) >= 0;
                            list.delegateModel.items.setGroups(i, 1, ['items', fits ? "searchFilter" : "dummy"]);
                        }
                    }
                }

            ]
            filterOnGroup: "items"
        }

        anchors {
            bottom: parent.bottom
            top: parent.top
        }

        onItemClicked: {
            itemSelected(searchList.model[modelIndex])
        }
    }
}
