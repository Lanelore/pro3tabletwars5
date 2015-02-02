import VPlay 2.0
import QtQuick 2.0
import "../common"
import ".."

SceneBase {
    id:settingScene

    // background
    Image {
        anchors.fill: parent
        source: "../../assets/img/final/BG.png"
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
/*
    Text {
        font.family: standardFont.name
        font.pointSize: 170
        text: "Credits"
        color: "black"
        anchors.top: parent.top
        anchors.topMargin: 90
        anchors.horizontalCenter: parent.horizontalCenter
    }
*/

    Text {
        font.family: standardFont.name
        font.pointSize: 40
        text: "Advanced Controls"
        color: "black"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: parent.height/4
    }

    Text {
        font.family: standardFont.name
        font.pointSize: 15
        text: "Extra Controls to aim at your target"
        color: "black"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: parent.height/3 + 50
    }

    AudioButton {
        source: active? "../../assets/img/final/On.png" : "../../assets/img/final/Off.png"
        active: !GameInfo.easyMode
        opacity: active? 0.5 : 1
        onClicked: {
            GameInfo.easyMode ^= true
        }
        width: 100
        height: 80
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: parent.height/2
    }
}
