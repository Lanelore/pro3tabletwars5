import VPlay 2.0
import QtQuick 2.0
import QtMultimedia 5.0
import "../common"

SceneBase {
    id: menuScene

    // signal indicating that the selectLevelScene should be displayed
    signal selectLevelPressed
    // signal indicating that the creditsScene should be displayed
    signal creditsPressed
    property alias ambienceMusic: ambienceMusic



    BackgroundMusic {
        loops: SoundEffect.Infinite
        volume: 0.3
        id: ambienceMusic
        // an ogg file is not playable on windows, because the extension is not supported!
        source: "../../assets/snd/BG.wav"
    }

    Timer {
        id: timerBlue
        interval: 100; running: true; repeat: true;

        //enable or disable powerUps for 5 seconds
        onTriggered: {
            ambienceMusic.play()
            running = false
        }
    }


    // background
    Image {
        anchors.fill: parent
        source: "../../assets/img/final/Menu.png"
    }
    /*
    Text {
        anchors.horizontalCenter: parent.horizontalCenter
        y: 30
        font.pixelSize: 30
        color: "#e9e9e9"
        text: "MultiSceneMultiLevel"
    }

    // menu
    Column {
        anchors.centerIn: parent
        spacing: 10
        rotation: 350
        MenuButton {
            text: "Levels"
            onClicked: selectLevelPressed()
            //label.source: "../../assets/img/Board.png"
            color: "transparent"
            buttonText.color: "white"
        }
        MenuButton {
            text: "Credits"
            onClicked: creditsPressed()
            //label.source: "../../assets/img/Board.png"
            color: "transparent"
            buttonText.color: "white"
        }
    }
*/
    MenuButton {
        anchors.top: parent.top
        anchors.topMargin: 403
        anchors.left: parent.left
        anchors.leftMargin: 380
        rotation: 353

        text: "Levels"
        onClicked: selectLevelPressed()
        //label.source: "../../assets/img/Board.png"
        color: "transparent"
        buttonText.color: "white"
        buttonText.font.pixelSize: 80
    }

    MenuButton {
        anchors.top: parent.top
        anchors.topMargin: 583
        anchors.left: parent.left
        anchors.leftMargin: 388
        rotation: 353

        text: "Credits"
        onClicked: creditsPressed()
        //label.source: "../../assets/img/Board.png"
        color: "transparent"
        buttonText.color: "white"
        buttonText.font.pixelSize: 80
    }


    Row {
        anchors.left: parent.left
        anchors.leftMargin: 12
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
    }
}
