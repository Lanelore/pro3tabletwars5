import VPlay 2.0
import QtQuick 2.0
import "../common"

SceneBase {
    id:creditsScene

    // background
    Image {
        anchors.fill: parent
        source: "../../assets/img/credits.png"
    }

    // back button to leave scene
    MenuButton {
        label.height: 50
        label.width: 50
        label.source: "../../assets/img/final/Back.png"
        color: "transparent"
        z: 10
        anchors.right: parent.right
        anchors.rightMargin: 15
        anchors.verticalCenter: parent.verticalCenter
        onClicked: backPressed()
        buttonText.font.pointSize: 25
    }

    Text {
        font.family: standardFont.name
        font.pointSize: 170
        text: "Credits"
        color: "black"
        anchors.top: parent.top
        anchors.topMargin: 90
        anchors.horizontalCenter: parent.horizontalCenter
    }

    // credits
    Text {
        font.family: standardFont.name
        font.pointSize: 40
        text: "Christian Enengl\nBirgit Fritz\nFlorian Peinsold\nBianca Zankl"
        color: "black"
        anchors.left: parent.left
        anchors.leftMargin: 40
        anchors.verticalCenter: parent.verticalCenter
    }
}
