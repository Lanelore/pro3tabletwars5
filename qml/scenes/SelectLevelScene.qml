import VPlay 2.0
import QtQuick 2.0
import "../common"
import ".."

SceneBase {
    id: selectLevelScene

    // signal indicating that a level has been selected
    signal levelPressed(string selectedLevel)

    // background
    Image {
        anchors.fill: parent
        source: "../../assets/img/final/BG.png"
    }

    onLevelPressed: {
        GameInfo.powerUpCount=0;
        var toRemoveEntityTypes = ["powAccelerator", "powLifeUp", "powPowershot", "powShield"];
        entityManager.removeEntitiesByFilter(toRemoveEntityTypes);
        GameInfo.redOnLake = false;
        GameInfo.blueOnLake = false;
    }

    /*
    // back button to leave scene
    MenuButton {
        text: "Back"
        // anchor the button to the gameWindowAnchorItem to be on the edge of the screen on any device
        anchors.right: selectLevelScene.right
        anchors.rightMargin: 10
        anchors.top: selectLevelScene.top
        anchors.topMargin: 10
        onClicked: {
            GameInfo.redVictory=0
            GameInfo.blueVictory=0
            backPressed()
        }
        buttonText.font.pixelSize: 25
    }
    */

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
        buttonText.font.pixelSize: 25
    }

    // levels to be selected
    Grid {
        anchors.centerIn: parent
        spacing: 10
        columns: 5
        MenuButton {
            text: "1"
            width: 50
            height: 50
            onClicked: {
                levelPressed("Level1.qml")
            }
        }
        MenuButton {
            text: "2"
            width: 50
            height: 50
            onClicked: {
                levelPressed("Level2.qml")
            }
        }
        MenuButton {
            text: "3"
            width: 50
            height: 50
            onClicked: {
                levelPressed("Level3.qml")
            }
        }
    }
}

