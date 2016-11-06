import QtQuick 2.5
import QtQuick.Layouts 1.0
import Material 0.3
import Material.ListItems 0.1
import Fitness 0.1
import "formHelper.js" as FormHelper

Page {
    id: userProfilePage
    title: qsTr("User profile")
    property var userProfile: dataManager.userProfile
    property bool firstTimeLaunch: userProfile["Weight"] === 0
    signal updated();

    actions: [
        Action {
            iconName: "action/done"
            enabled: {
                return FormHelper.numberGreaterThanZero([weight, height, age]);
            }

            onTriggered: {
                var map = {};
                var locale = Qt.locale();
                map["Weight"] = Number.fromLocaleString(locale, weight.value);
                map["Height"] = Number.fromLocaleString(locale, height.value);
                map["Age"] = parseInt(age.value);
                map["Sex"] = sexMenu.selectedIndex;
                dataManager.updateUserProfile(map);
                updated();
                pageStack.pop()
            }
        }

    ]

//    StandardActionButton {
//        enabled: {
//            return FormHelper.numberGreaterThanZero([weight, height, age]);
//        }

//        onClicked: {
//            var map = {};
//            var locale = Qt.locale();
//            map["Weight"] = Number.fromLocaleString(locale, weight.value);
//            map["Height"] = Number.fromLocaleString(locale, height.value);
//            map["Age"] = parseInt(age.value);
//            map["Sex"] = sexMenu.selectedIndex;
//            dataManager.updateUserProfile(map);
//            updated();
//            pageStack.pop()
//        }

//        backgroundColor: enabled ? Palette.colors["green"]["A700"] : Palette.colors["grey"]["500"]
//        AwesomeIcon {
//            name: "check"
//            anchors.centerIn: parent
//        }
//    }

    ColumnLayout {
        spacing: 0
        anchors {
            left: parent.left
            right: parent.right
        }

        Card {
            visible: firstTimeLaunch
            backgroundColor: Palette.colors["purple"]["200"]
            height: dp(70)
            anchors {
                left: parent.left
                right: parent.right
            }

            Label {
                id: hint
                anchors {
                    top: parent.top
                    left: parent.left
                    right: parent.right
                    margins: dp(10)
                }
                style: "body2"
                wrapMode: Text.WordWrap
                text: qsTr("We see you the first time. We need to know a little bit more about you. Please fill out the form")
            }

        }

        Card {
            anchors {
                left: parent.left
                right: parent.right
            }


            ColumnLayout
            {
                anchors.top: parent.top
                anchors.topMargin: dp(10)
                spacing: dp(10)
                anchors {
                    left: parent.left
                    right: parent.right
                }

                DoubleValidator {
                    id: doubleValidator
                }

                StandardFormTextField {
                    id: weight
                    label: qsTr("Weight")
                    validator: doubleValidator
                    suffixText: qsTr("kg")
                    value: !firstTimeLaunch ? userProfile["Weight"] : ""
                    inputHint: Qt.ImhFormattedNumbersOnly
                }

                StandardFormTextField {
                    id: height
                    label: qsTr("Height")
                    validator: doubleValidator
                    suffixText: qsTr("cm")
                    value: !firstTimeLaunch ? userProfile["Height"] : ""
                    inputHint: Qt.ImhFormattedNumbersOnly
                }

                StandardFormTextField {
                    id: age
                    label: qsTr("Age")
                    value: !firstTimeLaunch ? userProfile["Age"] : ""
                    inputHint: Qt.ImhFormattedNumbersOnly
                    validator: IntValidator{}
                }

                Standard {

    //               action: Item {}

                   RowLayout {
                       anchors {
                           left: parent.left
                           right: parent.right
                           verticalCenter:  parent.verticalCenter
                           margins: dp(10)
                       }

                       Label {
                           Layout.alignment: Qt.AlignLeft
                           style: "body2"
                           text: qsTr("Sex")
                       }

                       MenuField {
                           id: sexMenu
                           Layout.alignment: Qt.AlignRight
                           Layout.preferredWidth: 0.8 * parent.width
                           selectedIndex: userProfile["Sex"]

                           model: ["Male", "Female"]
                       }
                   }
               }

            }

        }
    }


}
