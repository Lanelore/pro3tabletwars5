import VPlay 2.0
import QtQuick 2.0
import "../common"
import ".."

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
    }

    // game over
    Text {
        id: textWinner
        text: "The winner of the round is <b>" + winner + "</b>"
        color: GameInfo.winnerRed ? GameInfo.red : GameInfo.blue
        anchors.centerIn: parent
        font.pointSize: 15
    }

    // statistic
    Text {
        id: textStatistic
        text: "<b>Statistic</b><br>Blue Victories: " + GameInfo.blueVictory + "<br>Red Victories: " + GameInfo.redVictory
        font.pointSize: 13
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: gameOverScene.height/2-120
        horizontalAlignment:  Text.AlignHCenter
    }
}
