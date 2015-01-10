import QtQuick 2.0
import VPlay 2.0
import ".."
import "../levels"

GameController {
    id: scene

    property alias opponentSnowman: opponentSnowman
    property alias powShield: powShield
    property alias powAccelerator: powAccelerator
    //property alias lake: lake

    PowerUpShield {
        id: powShield
        x: 50
        y: 700
        tankRed: parent.tankRed
        tankBlue: parent.tankBlue
        playerRed: parent.playerRed
        playerBlue: parent.playerBlue
    }

    PowerUpAccelerator {
        id: powAccelerator
        x: 50
        y: 600
        tankRed: parent.tankRed
        tankBlue: parent.tankBlue
        playerRed: parent.playerRed
        playerBlue: parent.playerBlue
    }

    PowerUpPowershot {
        id: powPowershot
        x: 50
        y: 500
        tankRed: parent.tankRed
        tankBlue: parent.tankBlue
        playerRed: parent.playerRed
        playerBlue: parent.playerBlue
    }

    PowerUpLifeUp {
        id: powLifeUp
        x: 50
        y: 400
        tankRed: parent.tankRed
        tankBlue: parent.tankBlue
        playerRed: parent.playerRed
        playerBlue: parent.playerBlue
    }

    Iglu {
        igluCount: 3
        entityId: "iglu1"
        id: iglu1
        x: scene.width / 3 *2
        y: scene.height / 3 *2

        rotation: 145
        igluBody.source: "../../assets/img/final/Iglu.png"
    }


    Iglu {
        igluCount: 3
        entityId: "iglu2"
        id: iglu2
        x: scene.width / 7 *2
        y: scene.height / 7 *5.5

        rotation: 90
        igluBody.source: "../../assets/img/final/Iglu.png"
    }

    Iglu {
        igluCount: 3
        entityId: "iglu3"
        id: iglu3
        x: scene.width /7*6
        y: scene.height / 2

        rotation: 90
        igluBody.source: "../../assets/img/final/Iglu.png"
    }

    Lake {
        id: lake
        x: 200 - width/2
        y: 200 - height/2

        rotation: 0
        lakeBody.source: "../../assets/img/final/Lake.png"
    }

    Opponents {
        id: opponentSnowman
        x: scene.width / 2
        y: scene.height - 520

        rotation: 0
        opponentBody.source: "../../assets/img/opponentSnowman.png"
    }

    Wall {
        id: wallLeft
        width: 30
        anchors {
            left: parent.left
            top: parent.top
            bottom: parent.bottom
        }
        image.source: "../../assets/img/final/Wall2.png"
        image.rotation: 180
    }

    Wall {
        id: wallRight
        width: 30
        anchors {
            right: parent.right
            bottom: parent.bottom
            top: parent.top
        }
        image.source: "../../assets/img/final/Wall2.png"
    }

    Wall {
        id: wallTop
        height: 30
        anchors {
            left: parent.left
            right: parent.right
            top:parent.top
        }
        image.source: "../../assets/img/final/Wall.png"
        image.rotation: 180
    }

    Wall {
        id: wallBottom
        height: 30
        width: parent.width
        x: 0
        y: parent.height-height
        image.source: "../../assets/img/final/Wall.png"
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
        x: scene.width / 4
        y: scene.height / 4

        rotation: 0
        ballBody.source: "../../assets/img/Ball.png"
    }

    PowerUpSpawn {
        entityId: "spawn"
        id: spawn
        x: scene.width / 7 *5.3
        y: scene.height / 7 *2

        spawnBody.source: "../../assets/img/final/PUSpawn.png"
    }

    Tree {
        entityId: "tree"
        id: tree
        x: scene.width / 7 *5.3
        y: scene.height / 7 *5.2

        treeBody.source: "../../assets/img/final/Tree.png"
    }
}
