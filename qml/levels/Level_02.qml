import QtQuick 2.0
import VPlay 2.0
import ".."
import "../levels"

GameController {
    id: scene

    //property alias opponentSnowman: opponentSnowman
    //property alias powShield: powShield
    //property alias powAccelerator: powAccelerator

    // Place 4 iglus in each corner
    Iglu {
        igluCount: 4
        entityId: "iglu1"
        id: iglu1
        x: 160
        y:  60
        z: 2
        igluBody.source: "../../assets/img/final/Iglu.png"

        rotation: 135
    }


    Iglu {
        igluCount: 4
        entityId: "iglu2"
        id: iglu2
        x: scene.width - 60
        y: 160
        z: 2
        igluBody.source: "../../assets/img/final/Iglu.png"
        rotation: 225
    }

    Iglu {
        igluCount: 4
        entityId: "iglu3"
        id: iglu3
        x: 60
        z: 2
        y: scene.height - 160
        rotation: 45
        igluBody.source: "../../assets/img/final/Iglu.png"
    }

    Iglu {
        igluCount: 4
        entityId: "iglu4"
        id: iglu4
        x: scene.width - 160
        y: scene.height - 60
        z:2
        rotation: 315
        igluBody.source: "../../assets/img/final/Iglu.png"
    }


    // Place the Lake in the middle
    Lake {
        id: lake
        x: scene.width / 2 - lake.width / 2 - 20
        y: scene.height / 2 - lake.height / 2 + 30

        rotation: 0
        lakeBody.source: "../../assets/img/final/Lake.png"
    }


    // Snowmen in upper left und lower right corner
    Opponents {
        id: opponentSnowman1
        x: scene.width / 4 * 3
        y: scene.height / 3 * 2

        rotation: 0
        opponentBody.source: "../../assets/img/final/Snowman.gif"
    }

    Opponents {
        id: opponentSnowman2
        x: scene.width / 4
        y: scene.height / 3

        rotation: 0
        opponentBody.source: "../../assets/img/final/Snowman.gif"
    }


    // Obstacles in upper right and lower left corner (2 each)
    Obstacle {
        id: obstacle1
        x: scene.width / 4 * 3 - 45
        y: scene.height / 6

        rotation: 0
        obstacleBody.source: "../../assets/img/Obstacle.jpg"
    }

    Obstacle {
        id: obstacle2
        x: scene.width / 4 * 3
        y: scene.height / 6 + 45

        rotation: 0
        obstacleBody.source: "../../assets/img/Obstacle.jpg"
    }

    Obstacle {
        id: obstacle3
        x: scene.width / 4 + 45
        y: scene.height / 6 * 5

        rotation: 0
        obstacleBody.source: "../../assets/img/Obstacle.jpg"
    }

    Obstacle {
        id: obstalce4
        x: scene.width / 4
        y: scene.height / 6 * 5 - 45

        rotation: 0
        obstacleBody.source: "../../assets/img/Obstacle.jpg"
    }



/*
    Ball {
        id: ball
        x: scene.width / 4
        y: scene.height / 4

        rotation: 0
        ballBody.source: "../../assets/img/final/SnowballBig.png"
    }
*/


    // Trees: two on the left side of like, one on right side
    Tree {
        entityId: "tree1"
        id: tree1
        x: scene.width / 2 - lake.width / 3
        y: scene.height / 2

        treeBody.source: "../../assets/img/final/Tree.png"
    }

    Tree {
        entityId: "tree2"
        id: tree2
        x: scene.width / 2 - lake.width / 3 - 65
        y: scene.height / 2

        treeBody.source: "../../assets/img/final/Tree.png"
    }


    // Power up spawn right of the lake
    PowerUpSpawn {
        entityId: "spawn1"
        id: spawn1
        x: scene.width / 2 + lake.width / 2
        y: scene.height / 2

        spawnBody.source: "../../assets/img/final/PUSpawn.png"
    }



    // place the 4 walls
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
}
