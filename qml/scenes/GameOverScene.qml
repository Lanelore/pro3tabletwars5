import VPlay 2.0
import QtQuick 2.0
import "../common"
import ".."


////////////////////////////////////////////////////////////
// class is not used anymore!
////////////////////////////////////////////////////////////

SceneBase {
    id:gameOverScene
    z: 1

    property string winner: GameInfo.winnerRed ? "Red" : "Blue" ;

    // background
    Rectangle {
        anchors.fill: parent
        color: "turquoise"
    }

    // back button to leave scene
    MenuButton {
        text: "Back"
        // anchor the button to the gameWindowAnchorItem to be on the edge of the screen on any device
        anchors.right: gameOverScene.right
        anchors.rightMargin: 10
        anchors.top: gameOverScene.top
        anchors.topMargin: 10
        onClicked: {
            backPressed()
        }
        buttonText.font.pixelSize: 25
    }

    // game over
    Text {
        id: textWinner
        text: "The winner of the round is <b>" + winner + "</b>"
        color: GameInfo.winnerRed ? GameInfo.red : GameInfo.blue
        anchors.centerIn: parent
        font.pixelSize: 15
    }

    // statistic
    Text {
        id: textStatistic
        text: "<b>Statistic</b><br>Blue: " + GameInfo.blueVictory + "<br>Red: " + GameInfo.redVictory
        font.pixelSize: 13
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: gameOverScene.height/2-120
        horizontalAlignment:  Text.AlignHCenter
    }
}
