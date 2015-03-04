import QtQuick 2.0
import VPlay 2.0
import ".."
import "../levels"

GameController {
    id: scene


    // Ice-Obstacles from top left to bottom right
    Obstacle {
        id: obstacle1
        x: scene.width / 4
        y: scene.height / 6

        rotation: 0
        obstacleBody.source: "../../assets/img/final/Obstacle.png"
    }

    Obstacle {
        id: obstacle2
        x: scene.width / 4 * 3
        y: scene.height / 6

        rotation: 0
        obstacleBody.source: "../../assets/img/final/Obstacle.png"
    }

    Obstacle {
        id: obstacle3
        x: scene.width / 3
        y: scene.height / 6 * 2

        rotation: 0
        obstacleBody.source: "../../assets/img/final/Obstacle.png"
    }

    Obstacle {
        id: obstacle4
        x: scene.width / 3 * 2
        y: scene.height / 6 * 2

        rotation: 0
        obstacleBody.source: "../../assets/img/final/Obstacle.png"
    }

    Obstacle {
        id: obstacle5
        x: scene.width / 5
        y: scene.height / 6 * 3

        rotation: 0
        obstacleBody.source: "../../assets/img/final/Obstacle.png"
    }

    Obstacle {
        id: obstacle6
        x: scene.width / 5 * 4
        y: scene.height / 6 * 3

        rotation: 0
        obstacleBody.source: "../../assets/img/final/Obstacle.png"
    }

    Obstacle {
        id: obstacle7
        x: scene.width / 3
        y: scene.height / 6 * 4

        rotation: 0
        obstacleBody.source: "../../assets/img/final/Obstacle.png"
    }

    Obstacle {
        id: obstacle8
        x: scene.width / 3 * 2
        y: scene.height / 6 * 4

        rotation: 0
        obstacleBody.source: "../../assets/img/final/Obstacle.png"
    }

    Obstacle {
        id: obstacle9
        x: scene.width / 4
        y: scene.height / 6 * 5

        rotation: 0
        obstacleBody.source: "../../assets/img/final/Obstacle.png"
    }

    Obstacle {
        id: obstacle10
        x: scene.width / 4 * 3
        y: scene.height / 6 * 5

        rotation: 0
        obstacleBody.source: "../../assets/img/final/Obstacle.png"
    }







    // Power up spawns
    PowerUpSpawn {
        entityId: "spawn"
        id: spaw1
        x: scene.width / 2 - spaw1.width / 2
        y: scene.height / 2 - spaw1.height / 2

        spawnBody.source: "../../assets/img/final/PUSpawn.png"
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
