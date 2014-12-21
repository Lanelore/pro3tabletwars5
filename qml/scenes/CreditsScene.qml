import VPlay 2.0
import QtQuick 2.0
import "../common"

SceneBase {
    id:creditsScene

    // background
    Rectangle {
        anchors.fill: parent
        color: "#49a349"
    }

    // back button to leave scene
    MenuButton {
        text: "Back"
        // anchor the button to the gameWindowAnchorItem to be on the edge of the screen on any device
        anchors.right: creditsScene.right
        anchors.rightMargin: 10
        anchors.top: creditsScene.top
        anchors.topMargin: 10
        onClicked: backPressed()
    }

    // credits
    Text {
        text: "Credits to: YOU :)"
        color: "white"
        anchors.centerIn: parent
    }
}
