import VPlay 2.0
import QtQuick 2.0
import "../common"
import ".."

SceneBase {
    id:gameScene
    // the filename of the current level gets stored here, it is used for loading the
    property string activeLevelFileName
    // the currently loaded level gets stored here
    property var activeLevel
    // countdown shown at level start
    property int countdown: 0


    property string winner: GameInfo.winnerRed ? "Rot" : "Blau";
    property alias victory: victory


    // set the name of the current level, this will cause the Loader to load the corresponding level
    function setLevel(fileName) {
        activeLevelFileName = fileName
    }

    // physics world for collision detection
    PhysicsWorld {
        id: world
        debugDrawVisible: false
        updatesPerSecondForPhysics: 10
        z: 1110
    }

    // back button to leave scene
    MenuButton {
        rotation: 90
        z: 1
        text: "Back"
        // anchor the button to the gameWindowAnchorItem to be on the edge of the screen on any device
        anchors.right: gameScene.right
        anchors.rightMargin: -15
        anchors.verticalCenter: parent.verticalCenter
        onClicked: {
            backPressed()
            activeLevelFileName = ""
            GameInfo.gameOver = false
            GameInfo.gamePaused = false
        }
        buttonText.font.pixelSize: 25
    }

    Connections {
        target: gameScene.activeLevel || null
        onGameOver: activeLevelFileName = ""
    }

    // name of the current level
    Text {
        anchors.left: gameScene.gameWindowAnchorItem.left
        anchors.leftMargin: 10
        anchors.top: gameScene.gameWindowAnchorItem.top
        anchors.topMargin: 10
        color: "white"
        font.pixelSize: 20
        text: activeLevel ? activeLevel.levelName : ""
    }

    // load levels at runtime
    Loader {
        id: loader
        source: activeLevelFileName ? "../levels/" + activeLevelFileName : ""
        onLoaded: {
            // store the loaded level as activeLevel for easier access
            activeLevel = item
            // restarts the countdown
            countdown = 3
            GameInfo.gamePaused = true
        }
    }

    // game over
    Text {
        id: victory
        text: "Game Over, der Gewinner ist " + winner
        color: GameInfo.winnerRed ? "red" : "blue"
        anchors.centerIn: parent
        visible: GameInfo.victory ? true : false

    }

    // text displaying either the countdown or ""
    Text {
        anchors.centerIn: parent
        color: "blue"
        font.pixelSize: countdown > 0 ? 160 : 18
        text: countdown > 0 ? countdown : ""
    }

    // if the countdown is greater than 0, this timer is triggered every second, decreasing the countdown (until it hits 0 again)
    Timer {
        repeat: true
        running: countdown > 0
        onTriggered: {
            countdown--
            if(countdown==0) GameInfo.gamePaused = false
        }
    }
}
