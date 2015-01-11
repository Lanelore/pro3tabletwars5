import VPlay 2.0
import QtQuick 2.0
import "../common"

SceneBase {
    id:creditsScene

    // background
    Image {
        anchors.fill: parent
        source: "../../assets/img/final/BG.png"
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
        buttonText.font.pixelSize: 25
    }

    // credits
    Text {
        text: "Credits to: YOU :)"
        color: "black"
        anchors.centerIn: parent
    }
}
