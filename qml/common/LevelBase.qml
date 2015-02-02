import QtQuick 2.0
import VPlay 2.0
import ".."

Item {
    id: levelBaseScene
    width: 768
    height: 1024

    //signal replay
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
            font.pointSize: 13
            font.family: standardFont.name
        }

        // statistic
        Text {
            id: textStatistic
            text: "Blue: " + GameInfo.blueVictory + "<br>Red: " + GameInfo.redVictory
            font.pointSize: 13
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 40

            horizontalAlignment:  Text.AlignHCenter
            font.family: standardFont.name
        }




            AudioButton {
                source: "../../assets/img/final/Play2.png"
                onClicked: {
                    backPressed()
                    activeLevelFileName = ""
                    GameInfo.gameOver = false
                    GameInfo.gamePaused = false
                }
                width: 50
                height: 50

                anchors.bottom: parent.bottom
                anchors.bottomMargin: height/2*(-1)
                anchors.horizontalCenter: parent.horizontalCenter
            }



    }


    // place the 4 Borders around the playing field
    Border {
        id: borderLeft
        width: 100
        anchors {
            right: parent.left
            top: parent.top
            bottom: parent.bottom
        }
    }

    Border {
        id: borderRight
        width: 100
        anchors {
            left: parent.right
            bottom: parent.bottom
            top: parent.top
        }
    }

    Border {
        id: borderTop
        height: 100
        anchors {
            left: parent.left
            right: parent.right
            bottom:parent.top
        }
    }

    Border {
        id: borderBottom
        height: 100
        width: parent.width
        x: 0
        y: parent.height //-height
    }
}
