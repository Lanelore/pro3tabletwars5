import VPlay 2.0
import QtQuick 2.0
//import QtQuick.XmlListModel 2.0
//import QtQml.Models 2.1
import "../common"
import ".."

SceneBase {
    id:creditsScene

    // background
    Image {
        anchors.fill: parent
        source: "../../assets/img/final/BG.png" //Credits
    }

    // back button to leave scene
    MenuButton {
        label.height: 60
        label.width: 60
        label.source: "../../assets/img/final/Back.png"
        color: "transparent"
        z: 10
        anchors.right: parent.right
        anchors.rightMargin: 10
        anchors.verticalCenter: parent.verticalCenter
        onClicked: backPressed()
        buttonText.font.pointSize: 25
    }

    // credits
    /*
    Text {
        font.family: standardFont.name
        font.pointSize: 40
        text: "Christian Enengl\nBirgit Fritz\nFlorian Peinsold\nBianca Zankl"
        color: "black"
        anchors.left: parent.left
        anchors.leftMargin: 40
        anchors.verticalCenter: parent.verticalCenter
    }
    */

    Text {
        font.family: standardFont.name
        font.pointSize: 20
        text: "Christian Enengl\nBirgit Fritz\nFlorian Peinsold\nBianca Zankl"
        color: "black"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 60
        lineHeight: 1.1
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }

    Column {
        anchors.left: parent.left
        anchors.leftMargin: 30
        anchors.top: parent.top
        anchors.topMargin: parent.height/5*2
        spacing: 10
        Image {
            width: 336
            height: 140
            source: "../../assets/img/final/credits/1001Fonts.png"
        }
        Image {
            width: 336
            height: 140
            source: "../../assets/img/final/credits/FreeSound.png"
        }
        Image {
            width: 336
            height: 140
            source: "../../assets/img/final/credits/VPlay.png"
        }
        Image {
            width: 708
            height: 140
            source: "../../assets/img/final/credits/Hagenberg.png"
        }
    }
    Column {
        anchors.right: parent.right
        anchors.rightMargin: 30
        anchors.top: parent.top
        anchors.topMargin: parent.height/5*2
        spacing: 10
        Image {
            width: 336
            height: 140
            source: "../../assets/img/final/credits/OpenGameArt.png"
        }
        Image {
            width: 336
            height: 140
            source: "../../assets/img/final/credits/Qt.png"
        }
        Image {
            width: 336
            height: 140
            source: "../../assets/img/final/credits/GitHub.png"
        }
    }
}
