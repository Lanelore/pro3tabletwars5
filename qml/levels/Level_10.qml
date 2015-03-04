import QtQuick 2.0
import VPlay 2.0
import ".."
import "../levels"

GameController {
    id: scene


    // Ice-Obstacle on top right side
    Obstacle {
        id: obstacle1
        x: scene.width / 6 * 5
        y: scene.height / 8

        rotation: 0
        obstacleBody.source: "../../assets/img/final/Obstacle.png"
    }

    // Snowman on top left
    Opponents {
        id: opponentSnowman1
        x: scene.width / 6
        y: scene.height / 6

        rotation: 0
        opponentBody.source: "../../assets/img/final/Snowman.gif"
    }

    // Iglu on upper third, left side
    Iglu {
        igluCount: 3
        entityId: "iglu1"
        id: iglu1
        x: 150
        y: scene.height / 3 - 50

        rotation: 90
        igluBody.source: "../../assets/img/final/Iglu.png"
    }

    // Christmas Tree on same height, but right side
    PowerUpSpawn {
        entityId: "spawn"
        id: spaw1
        x: scene.width / 6 * 5
        y: scene.height / 3

        spawnBody.source: "../../assets/img/final/PUSpawn.png"
    }


    // Obstacle in left-right-center, slightly below christmas tree in y-direction
    Obstacle {
        id: obstacle4
        x: scene.width / 2
        y: scene.height / 3 + 20

        rotation: 0
        obstacleBody.source: "../../assets/img/final/Obstacle.png"
    }

    // Christmas Tree y-center, left side
    PowerUpSpawn {
        entityId: "spawn"
        id: spaw2
        x: scene.width / 5
        y: scene.height / 2

        spawnBody.source: "../../assets/img/final/PUSpawn.png"
    }

    // lake on lower half, left side
    Lake {
        id: lake
        x: 0
        y: scene.height / 2 + 30

        rotation: 0
        lakeBody.source: "../../assets/img/final/Lake.png"
    }

    // 2 Iglus on right side
    Iglu {
        igluCount: 3
        entityId: "iglu2"
        id: iglu2
        x: scene.width / 7 * 4 - 20
        y: scene.height / 3 * 2 - 60

        rotation: 0
        igluBody.source: "../../assets/img/final/Iglu.png"
    }

    Iglu {
        igluCount: 3
        entityId: "iglu3"
        id: iglu3
        x: scene.width - 10
        y: scene.height / 3 * 2 + 20

        rotation: 180
        igluBody.source: "../../assets/img/final/Iglu.png"
    }

    // Christmas tree in lower right corner
    PowerUpSpawn {
        entityId: "spawn"
        id: spaw3
        x: scene.width / 5 * 4
        y: scene.height / 7 * 6

        spawnBody.source: "../../assets/img/final/PUSpawn.png"
    }

    // obstacle in lower right corner
    Obstacle {
        id: obstacle3
        x: scene.width / 7
        y: scene.height / 10 * 9

        rotation: 0
        obstacleBody.source: "../../assets/img/final/Obstacle.png"
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
