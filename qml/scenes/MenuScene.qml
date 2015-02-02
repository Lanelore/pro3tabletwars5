import VPlay 2.0
import QtQuick 2.0
import QtMultimedia 5.0
import "../common"
import ".."

SceneBase {
    id: menuScene

    // signal indicating that the selectLevelScene should be displayed
    signal selectLevelPressed
    // signal indicating that the creditsScene should be displayed
    signal creditsPressed
    // signal indicating that the settingScene should be displayed
    signal settingsPressed

    property alias ambienceMusic: ambienceMusic
/*
    Text {
        z: 2
      id: textItem
      text: "Durdles"
      color: "black"
      font.family: titleFont.name
      font.pixelSize: 200

      anchors.top: parent.top
      anchors.topMargin: 100
      anchors.horizontalCenter: menuScene.horizontalCenter
    }
*/
    BackgroundMusic {
        loops: SoundEffect.Infinite
        volume: 0.2
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
        z: 0
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
        id: menuButton1
        z: 2
        x: menuScene.width / 2 * 1.1
        y: menuScene.height / 2
        rotation: 352

        text: "Play"
        onClicked: selectLevelPressed()
        //label.source: "../../assets/img/Board.png"
        color: "transparent"
        buttonText.color: "white"
        buttonText.opacity: 1//0.85
        buttonText.font.pointSize: 56
        buttonText.font.family: standardFont.name
    }

    MenuButton {
        z: 2
        x: menuScene.width / 2 * 1.1
        y: menuScene.height / 3 * 2
        rotation: 352

        text: "Settings"
        onClicked: settingsPressed()
        //label.source: "../../assets/img/Board.png"
        color: "transparent"
        buttonText.color: "white"
        buttonText.opacity: 1//0.85
        buttonText.font.pointSize: 56
        buttonText.font.family: standardFont.name
    }

    MenuButton {
        z: 2
        x: menuScene.width / 2 * 1.1
        y: menuScene.height / 6 * 5
        rotation: 352

        text: "Credits"
        onClicked: creditsPressed()
        //label.source: "../../assets/img/Board.png"
        color: "transparent"
        buttonText.color: "white"
        buttonText.opacity: 1//0.85
        buttonText.font.pointSize: 56
        buttonText.font.family: standardFont.name
    }
}
