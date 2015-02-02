import QtQuick 2.0
import VPlay 2.0
import ".."
import "../levels"

GameController {
    id: scene

    property alias opponentSnowman: opponentSnowman
    //property alias powShield: powShield
    //property alias powAccelerator: powAccelerator
    //property alias lake: lake
/*
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
        x: scene.width / 10
        y: scene.height / 10 * 8.8
        tankRed: parent.tankRed
        tankBlue: parent.tankBlue
        playerRed: parent.playerRed
        playerBlue: parent.playerBlue
    }

*/
    Iglu {
        igluCount: 3
        entityId: "iglu1"
        id: iglu1
        x: scene.width / 2 + iglu1.igluBody.width / 2
        y: scene.height / 2 - 10

        rotation: 180
        igluBody.source: "../../assets/img/final/Iglu.png"
    }


    Iglu {
        igluCount: 3
        entityId: "iglu2"
        id: iglu2
        x: scene.width / 7 * 4.2
        y: scene.height / 7 * 5

        rotation: 300
        igluBody.source: "../../assets/img/final/Iglu.png"
    }

    Iglu {
        igluCount: 3
        entityId: "iglu3"
        id: iglu3
        x: scene.width /7 * 1.9
        y: scene.height / 2 + iglu3.igluBody.height / 2 - 10

        rotation: 60
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

        x: scene.width / 5
        y: scene.height / 2 - opponentSnowman.opponentBody.height * 2

        rotation: 0
        opponentBody.source: "../../assets/img/final/Snowman.gif"
    }

    Obstacle {
        id: obstacleMiddle
        x: scene.width / 2
        y: scene.height / 2 + obstacleMiddle.obstacleBody.height * 2.6

        rotation: 0
        obstacleBody.source: "../../assets/img/final/Obstacle.png"
    }


    Ball {
        id: ball
        x: scene.width / 4
        y: scene.height / 4

        rotation: 0
        ballBody.source: "../../assets/img/final/SnowballBig.png"
    }


    // Planet trees and power up spawners

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
        y: scene.height / 2 - tree.treeBody.height / 2

        treeBody.source: "../../assets/img/final/Tree.png"
    }


    // Place the 4 walls

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
        z:1
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
        z:1
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
        z:1
    }

    Wall {
        id: wallBottom
        height: 30
        width: parent.width
        x: 0
        y: parent.height-height
        image.source: "../../assets/img/final/Wall.png"
        z:1
    }
}
