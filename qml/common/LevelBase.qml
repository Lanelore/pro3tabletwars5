import QtQuick 2.0
import VPlay 2.0
import ".."

Item {
    id: levelBaseScene
    width: 768
    height: 1024

    //signal result
    //signal gameOver
    signal damage

    //signal redOnLake
    signal redOffLake
    //signal blueOnLake
    signal blueOffLake

    // this will be displayed in the GameScene
    property string levelName
    // this is emitted whenever the rectangle has been tapped successfully, the GameScene will listen to this signal and increase the score


    property string winner: GameInfo.winnerRed ? "Red" : "Blue" ;

    /*
    Rectangle {
        id: background
        color: Qt.lighter("lightblue", 1.3)
        anchors.fill: parent
    }
    */
    Image {
        id: background
        anchors.fill: parent
        source: "../../assets/img/final/BG.png"
    }

    Rectangle {
        z:5
        id: gameOver
        color: "white"
        anchors.centerIn: parent
        width: 400
        height: 200
        radius: 20
        border.width: GameInfo.border
        border.color: "lightgrey"
        opacity: GameInfo.gameOver ? 100 : 0

        // game over
        Text {
            id: textWinner
            text: "The winner of the round is <b>" + winner + "</b>"
            color: GameInfo.winnerRed ? GameInfo.red : GameInfo.blue
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 30
            font.pointSize: 15
        }

        // statistic
        Text {
            id: textStatistic
            text: "<b>Statistic</b><br>Blue: " + GameInfo.blueVictory + "<br>Red: " + GameInfo.redVictory
            font.pointSize: 13
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 30
            horizontalAlignment:  Text.AlignHCenter
        }
    }
}
