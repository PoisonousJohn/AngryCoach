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
    property alias delegateModel: delegateModel
    signal itemSelected(var item)

    DelegateModel {
        id: delegateModel

    }

    actions: [
        Action {
            name: "Search"
            iconName: "action/search"
        }
    ]

    actionBar {
       customContent: TextField {
           id: searchField
           color: Palette.colors["white"]["500"]
           textColor: Palette.colors["white"]["500"]
           placeholderText: qsTr("Search...")
//           onDisplayTextChanged: {
//               searchFilterGroup.filter = searchField.displayText
//               list.delegateModel.filterOnGroup = searchFilterGroup.filter.length > 0 ? "searchFilter" : "all"

//           }

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
//        delegateModel {
//            groups: [
//                DelegateModelGroup {
//                    id: searchFilterGroup
//                    includeByDefault: false
//                    name: "searchFilter"
//                    property string filter;
//                    onFilterChanged: {
//                        // remove all
//                        for (var i = 0; i < count; ++i)
//                        {
//                            remove(0);
//                        }
//                        var filterLowerCase = filter.toLowerCase();
//                        var isArray = Array.isArray(model);
//                        var modelCount = !isArray
//                                                ? searchList.model.count
//                                                : searchList.model.length;
//                        for (i = 0; i < modelCount; ++i)
//                        {
//                            var entry = isArray ? searchList.model[i] : searchList.model.get(i);
//    //                        if (entry[defaultModelField].toLowerCase().indexOf(filterLowerCase) >= 0)
//    //                        {
//                                insert(entry);
//    //                        }
//                        }
//                    }
//                },

//                DelegateModelGroup {
//                    name: "all"
//                    includeByDefault: true
//                }

//            ]
//        }

        anchors {
            bottom: parent.bottom
            top: parent.top
        }

        onItemClicked: {
            itemSelected(searchList.model[modelIndex])
        }
    }
}
