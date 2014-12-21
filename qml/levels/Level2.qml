import QtQuick 2.0
import VPlay 2.0
import ".."

GameController {
    //levelName: "Level1"
    id: scene

    property alias opponentSnowman: opponentSnowman

    PowerUpLifeUp {
        id: powLifeUp
        x: 50
        y: 400
        tankRed: parent.tankRed
        tankBlue: parent.tankBlue
        playerRed: parent.playerRed
        playerBlue: parent.playerBlue
        onEnabledChanged: {
            console.debug("Counter Yay!")
        }
    }

    Opponents {
        id: opponentSnowman
        x: scene.width / 2
        y: scene.height - 520

        rotation: 0
        opponentBody.source: "../../assets/img/opponentSnowman.png"
        /*
        MovementAnimation {
            target: Tank
            property: "x"
            running: true

            // the starting velocity
            velocity: 960

            // this forces the rectangle to move to the left (against the velocity direction), but it doesnt get faster than -20 px/second!
            acceleration: -260
            minVelocity: -20
            // limits the initial velocity set to 960, now to 500
            maxVelocity: 500

            // limits the x property between a border of 10 and 100
            minPropertyValue: 10
            maxPropertyValue: 100

            // never change the x value by more than 50 pixels in one step
            // this is useful for example to limit the rotation from MoveToPointHelper
            maxPropertyValueDifference: 50

            // this is the same as setting running to true, only for demonstration purpose
            Component.onCompleted: movement.start()
          }
*/
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

    Obstacle {
        id: obstacleMiddle
        x: scene.width / 2
        y: scene.height - 700

        rotation: 0
        obstacleBody.source: "../../assets/img/Obstacle.jpg"
    }

    Ball {
        id: ball
        x: scene.width / 3
        y: scene.height / 2

        rotation: 0
        ballBody.source: "../../assets/img/Ball.png"
    }

    Iglu {
        igluCount: 2
        entityId: "iglu1"
        id: iglu1
        x: scene.width / 3 *2
        y: scene.height / 3 *2

        rotation: 145
        igluBody.source: "../../assets/img/Iglu.png"
    }

    Iglu {
        igluCount: 2
        entityId: "iglu2"
        id: iglu2
        x: scene.width / 7 *2
        y: scene.height / 7 *5

        rotation: 90
        igluBody.source: "../../assets/img/Iglu.png"
    }

    PowerUpSpawn {
        entityId: "spawn"
        id: spawn
        x: scene.width / 7 *2
        y: scene.height / 7 *2

        spawnBody.source: "../../assets/img/Spawn.png"
    }

    PowerUpSpawn {
        entityId: "spawn2"
        id: spawn2
        x: scene.width / 7 *5
        y: scene.height / 7 *2

        spawnBody.source: "../../assets/img/Spawn.png"
    }

/*
    //load controller-elements
    GameController {
        id: gameCtrl
    }
    focus: true
*/
}
