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
        text: "Back to menu"
        // anchor the button to the gameWindowAnchorItem to be on the edge of the screen on any device
        anchors.right: gameScene.right
        anchors.rightMargin: -15
        anchors.verticalCenter: parent.verticalCenter
        onClicked: {
            backPressed()
            activeLevelFileName = ""
        }
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
}
