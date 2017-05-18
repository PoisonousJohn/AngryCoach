import QtQuick 2.0
import QtQuick.Layouts 1.1
import Material 0.3
import '../stores'
import '../singletons'

Card {
    property alias backgroundImage: bg.source
    property alias text: title.text

    height: dp(120)
    anchors {
        left: parent.left
        right: parent.right
    }
    
    Rectangle {
        anchors.fill: parent
        color: Palette.colors["grey"]["900"]
    }
    
    Image {
        id: bg
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        source: "/images/free-food-photo20.png"
    }
    
    
    Rectangle {
        anchors.verticalCenter: title.verticalCenter
        anchors.left: parent.left
        anchors.right: parent.right
        //                anchors.margins: dp(-20)
        height: title.height + dp(20)
        color: "white"
        opacity: 0.5
    }
    Label {
        id: title
        x: dp(20)
        anchors.bottom: parent.bottom
        anchors.bottomMargin: dp(20)
        font.pixelSize: dp(20)
    }
    
    
    
}
