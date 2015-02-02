import VPlay 2.0
import QtQuick 2.0
import "../common"
import ".."

SceneBase {
    id:settingScene

    // background
    Image {
        anchors.fill: parent
        source: "../../assets/img/final/Credits.png" //BG
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
        text: "Advanced\nControls"
        color: "black"
        anchors.left: parent.left
        anchors.leftMargin: 30
        anchors.top: parent.top
        anchors.topMargin: -10
        lineHeight: 0.5
    }

    Text {
        font.family: standardFont.name
        font.pointSize: 15
        text: "Additional controls to aim\nat your target"
        color: "black"
        anchors.left: parent.left
        anchors.leftMargin: 30
        anchors.top: parent.top
        anchors.topMargin: 170
        lineHeight: 0.8
    }

    AudioButton {
        source: active? "../../assets/img/final/On.png" : "../../assets/img/final/Off.png"
        active: !GameInfo.easyMode
        opacity: 1
        onClicked: {
            GameInfo.easyMode ^= true
        }
        width: 150
        height: 110
        anchors.left: parent.left
        anchors.leftMargin: 30
        anchors.top: parent.top
        anchors.topMargin: 275
    }
}
