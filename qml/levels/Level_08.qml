import QtQuick 2.0
import VPlay 2.0
import ".."
import "../levels"

GameController {
    id: scene


    // Ice-Obstacles: horizontal line in vertical center
    Obstacle {
        id: obstacle1
        x: scene.width / 2
        y: scene.height / 2 - height / 2

        rotation: 0
        obstacleBody.source: "../../assets/img/final/Obstacle.png"
    }

    Obstacle {
        id: obstacle2
        x: scene.width / 2 + 40
        y: scene.height / 2 - height / 2

        rotation: 0
        obstacleBody.source: "../../assets/img/final/Obstacle.png"
    }

    Obstacle {
        id: obstacle3
        x: scene.width / 2 + 40 * 2
        y: scene.height / 2 - height / 2

        rotation: 0
        obstacleBody.source: "../../assets/img/final/Obstacle.png"
    }

    Obstacle {
        id: obstacle4
        x: scene.width / 2 + 40 * 3
        y: scene.height / 2 - height / 2

        rotation: 0
        obstacleBody.source: "../../assets/img/final/Obstacle.png"
    }

    Obstacle {
        id: obstacle5
        x: scene.width / 2 + 40 * 4
        y: scene.height / 2 - height / 2

        rotation: 0
        obstacleBody.source: "../../assets/img/final/Obstacle.png"
    }

    Obstacle {
        id: obstacle6
        x: scene.width / 2 + 40 * 5
        y: scene.height / 2 - height / 2

        rotation: 0
        obstacleBody.source: "../../assets/img/final/Obstacle.png"
    }

    Obstacle {
        id: obstacle7
        x: scene.width / 2 + 40 * 6
        y: scene.height / 2 - height / 2

        rotation: 0
        obstacleBody.source: "../../assets/img/final/Obstacle.png"
    }

    Obstacle {
        id: obstacle8
        x: scene.width / 2 + 40 * 7
        y: scene.height / 2 - height / 2

        rotation: 0
        obstacleBody.source: "../../assets/img/final/Obstacle.png"
    }

    Obstacle {
        id: obstacle9
        x: scene.width / 2 + 40 * 8
        y: scene.height / 2 - height / 2

        rotation: 0
        obstacleBody.source: "../../assets/img/final/Obstacle.png"
    }

    Obstacle {
        id: obstacle10
        x: scene.width / 2 + 40 * 9
        y: scene.height / 2 - height / 2

        rotation: 0
        obstacleBody.source: "../../assets/img/final/Obstacle.png"
    }

    Obstacle {
        id: obstacle11
        x: scene.width / 2 - 40 * 1
        y: scene.height / 2 - height / 2

        rotation: 0
        obstacleBody.source: "../../assets/img/final/Obstacle.png"
    }

    Obstacle {
        id: obstacle12
        x: scene.width / 2 - 40 * 2
        y: scene.height / 2 - height / 2

        rotation: 0
        obstacleBody.source: "../../assets/img/final/Obstacle.png"
    }

    Obstacle {
        id: obstacle13
        x: scene.width / 2 - 40 * 3
        y: scene.height / 2 - height / 2

        rotation: 0
        obstacleBody.source: "../../assets/img/final/Obstacle.png"
    }

    Obstacle {
        id: obstacle14
        x: scene.width / 2 - 40 * 4
        y: scene.height / 2 - height / 2

        rotation: 0
        obstacleBody.source: "../../assets/img/final/Obstacle.png"
    }

    Obstacle {
        id: obstacle15
        x: scene.width / 2 - 40 * 5
        y: scene.height / 2 - height / 2

        rotation: 0
        obstacleBody.source: "../../assets/img/final/Obstacle.png"
    }

    Obstacle {
        id: obstacle16
        x: scene.width / 2 - 40 * 6
        y: scene.height / 2 - height / 2

        rotation: 0
        obstacleBody.source: "../../assets/img/final/Obstacle.png"
    }

    Obstacle {
        id: obstacle17
        x: scene.width / 2 - 40 * 7
        y: scene.height / 2 - height / 2

        rotation: 0
        obstacleBody.source: "../../assets/img/final/Obstacle.png"
    }

    Obstacle {
        id: obstacle18
        x: scene.width / 2 - 40 * 8
        y: scene.height / 2 - height / 2

        rotation: 0
        obstacleBody.source: "../../assets/img/final/Obstacle.png"
    }

    Obstacle {
        id: obstacle19
        x: scene.width / 2 - 40 * 9
        y: scene.height / 2 - height / 2

        rotation: 0
        obstacleBody.source: "../../assets/img/final/Obstacle.png"
    }





    // Iglus
    Iglu {
        igluCount: 8
        entityId: "iglu1"
        id: iglu1
        x: 20
        y: scene.height / 2 - 180

        rotation: 0
        igluBody.source: "../../assets/img/final/Iglu.png"
    }

    Iglu {
        igluCount: 8
        entityId: "iglu2"
        id: iglu2
        x: 170
        y: scene.height / 2 + 180

        rotation: 180
        igluBody.source: "../../assets/img/final/Iglu.png"
    }

    Iglu {
        igluCount: 8
        entityId: "iglu3"
        id: iglu3
        x: scene.width - width - 20
        y: scene.height / 2 - 180

        rotation: 0
        igluBody.source: "../../assets/img/final/Iglu.png"
    }

    Iglu {
        igluCount: 8
        entityId: "iglu4"
        id: iglu4
        x: scene.width - width + 130
        y: scene.height / 2 + 180

        rotation: 180
        igluBody.source: "../../assets/img/final/Iglu.png"
    }

    Iglu {
        igluCount: 8
        entityId: "iglu5"
        id: iglu5
        x: scene.width - width - 210
        y: scene.height / 2 - 180

        rotation: 0
        igluBody.source: "../../assets/img/final/Iglu.png"
    }

    Iglu {
        igluCount: 8
        entityId: "iglu6"
        id: iglu6
        x: scene.width - width - 60
        y: scene.height / 2 + 180

        rotation: 180
        igluBody.source: "../../assets/img/final/Iglu.png"
    }

    Iglu {
        igluCount: 8
        entityId: "iglu7"
        id: iglu7
        x: 210
        y: scene.height / 2 - 180

        rotation: 0
        igluBody.source: "../../assets/img/final/Iglu.png"
    }

    Iglu {
        igluCount: 8
        entityId: "iglu8"
        id: iglu8
        x: 360
        y: scene.height / 2 + 180

        rotation: 180
        igluBody.source: "../../assets/img/final/Iglu.png"
    }






    // Snowmen in the 4 centers
    Opponents {
        id: opponentSnowman1
        x: scene.width / 6 - width / 2
        y: scene.height / 6 - height / 2

        rotation: 0
        opponentBody.source: "../../assets/img/final/Snowman.gif"
    }

    Opponents {
        id: opponentSnowman2
        x: scene.width / 6 * 5 - width / 2
        y: scene.height / 6 - height / 2

        rotation: 0
        opponentBody.source: "../../assets/img/final/Snowman.gif"
    }

    Opponents {
        id: opponentSnowman3
        x: scene.width / 6 - width / 2
        y: scene.height / 6 * 5 - height / 2

        rotation: 0
        opponentBody.source: "../../assets/img/final/Snowman.gif"
    }

    Opponents {
        id: opponentSnowman4
        x: scene.width / 6 * 5 - width / 2
        y: scene.height / 6 * 5 - height / 2

        rotation: 0
        opponentBody.source: "../../assets/img/final/Snowman.gif"
    }








    // Power up spawns
    PowerUpSpawn {
        entityId: "spawn"
        id: spaw1
        x: scene.width / 2
        y: scene.height / 3 - 110

        spawnBody.source: "../../assets/img/final/PUSpawn.png"
    }

    // Power up spawns
    PowerUpSpawn {
        entityId: "spawn"
        id: spawn2
        x: scene.width / 2
        y: scene.height / 3 * 2 + 110

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
