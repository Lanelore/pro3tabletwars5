import VPlay 2.0
import QtQuick 2.0
import "../common"
import ".."

SceneBase {
    id:settingScene

    // background
    Image {
        anchors.fill: parent
        source: "../../assets/img/final/Credits2.png" //BG
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
        font.pixelSize: 70
        text: "Settings"
        color: "black"
        anchors.left: parent.left
        anchors.leftMargin: 30
        anchors.top: parent.top
        anchors.topMargin: 40
        //lineHeight: 0.5
    }

    Text {
        font.family: standardFont.name
        font.pixelSize: 40
        text: "Shoot-Control"
        color: "black"
        anchors.left: parent.left
        anchors.leftMargin: 50
        anchors.top: parent.top
        anchors.topMargin: 170
        //lineHeight: 0.8
    }

    Text {
        font.family: standardFont.name
        font.pixelSize: 40
        text: "Background music"
        color: "black"
        anchors.left: parent.left
        anchors.leftMargin: 50
        anchors.top: parent.top
        anchors.topMargin: 270
        //lineHeight: 0.8
    }

    Text {
        font.family: standardFont.name
        font.pixelSize: 40
        text: "Sound effects"
        color: "black"
        anchors.left: parent.left
        anchors.leftMargin: 50
        anchors.top: parent.top
        anchors.topMargin: 370
        //lineHeight: 0.8
    }

    AudioButton {
        source: active ? "../../assets/img/final/Switch_Hard.png" : "../../assets/img/final/Switch_Easy.png"
        active: !GameInfo.easyMode
        opacity: 1
        onClicked: {
            GameInfo.easyMode ^= true
        }
        width: 180
        height: 80
        anchors.right: parent.right
        anchors.rightMargin: 50
        anchors.top: parent.top
        anchors.topMargin: 150
    }

    AudioButton {
        anchors.right: parent.right
        anchors.rightMargin: 50
        anchors.top: parent.top
        anchors.topMargin: 250
        width: 180
        height: 80

        source: active ? "../../assets/img/final/Switch_Off.png" : "../../assets/img/final/Switch_On.png"
        active: ! settings.musicEnabled
        opacity: 1
        onClicked:  {
            settings.musicEnabled ^= true
        }
    }

    AudioButton {
        anchors.right: parent.right
        anchors.rightMargin: 50
        anchors.top: parent.top
        anchors.topMargin: 350
        width: 180
        height: 80

        source: active ? "../../assets/img/final/Switch_Off.png" : "../../assets/img/final/Switch_On.png"
        active: ! settings.soundEnabled
        opacity: 1
        onClicked: {
            settings.soundEnabled ^= true
        }
    }
/*
    Row {
        anchors.right: parent.right
        anchors.rightMargin: 12
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 15
        spacing: 10
        AudioButton {
            source: "../../assets/img/final/Music.png"
            active: !settings.musicEnabled
            opacity: active? 0.5 : 1
            onClicked: {
                settings.musicEnabled ^= true
            }
        }
        AudioButton {
            source: "../../assets/img/final/Sound.png"
            active: !settings.soundEnabled
            opacity: active? 0.5 : 1
            onClicked: {
                settings.soundEnabled ^= true
            }
        }
        *//*
        AudioButton {
            source: "../../assets/img/final/Settings.png"
            active: !GameInfo.easyMode
            opacity: active? 0.5 : 1
            onClicked: {
                GameInfo.easyMode ^= true
            }
            width: 80
            height: 80
        }*//*

    }
    */
}
