import QtQuick 2.0
import VPlay 2.0
import ".."

GameController {
    //levelName: "Level1"
    id: scene

    Lake {
        id: lake
        x: 200
        y: 200
        height: 1000
        width: 1000
        rotation: 0
        lakeBody.source: "../../assets/img/Lake.png"
    }


    Wall {
        id: wallTop
        height: 20
        anchors {
            left: parent.left
            right: parent.right
            top:parent.top
        }
    }

    Wall {
        id: wallBottom
        height: 20
        width: parent.width
        x: 0
        y: parent.height-height
    }

    Wall {
        id: wallLeft
        width: 20
        anchors {
            left: parent.left
            top: parent.top
            bottom: parent.bottom
        }
    }

    Wall {
        id: wallRight
        width: 20
        anchors {
            right: parent.right
            bottom: parent.bottom
            top: parent.top
        }
    }

    Ball {
        id: ball
        x: scene.width / 3
        y: scene.height / 2

        rotation: 0
        ballBody.source: "../../assets/img/Ball.png"
    }


/*
    //load controller-elements
    GameController {
        id: gameCtrl
    }
    focus: true
*/
}
