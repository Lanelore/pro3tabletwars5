import QtQuick 2.0
import VPlay 2.0
import ".."
import "../levels"

GameController {
    id: scene

    // Place Iglu at top center
    /*
    Iglu {
        igluCount: 2
        entityId: "iglu1"
        id: iglu1
        x: scene.width / 2 + iglu1.igluBody.width / 2
        y: iglu1.igluBody.height * 1.5
        z: 2
        igluBody.source: "../../assets/img/final/Iglu.png"

        rotation: 180
    }

    // place iglu at bottom center
    Iglu {
        igluCount: 2
        entityId: "iglu2"
        id: iglu2
        x: scene.width / 2 - iglu2.igluBody.width / 2
        y: scene.height - iglu2.igluBody.height * 1.5
        z: 2
        igluBody.source: "../../assets/img/final/Iglu.png"
        rotation: 0
    }*/


    // Snowmen in upper left und lower right corner
    Opponents {
        id: opponentSnowman1
        x: scene.width / 3
        y: scene.height / 4

        rotation: 0
        opponentBody.source: "../../assets/img/final/Snowman.gif"
    }

    Opponents {
        id: opponentSnowman2
        x: scene.width / 3 * 2
        y: scene.height / 4

        rotation: 0
        opponentBody.source: "../../assets/img/final/Snowman.gif"
    }

    Opponents {
        id: opponentSnowman3
        x: scene.width / 3
        y: scene.height / 4 * 2

        rotation: 0
        opponentBody.source: "../../assets/img/final/Snowman.gif"
    }

    Opponents {
        id: opponentSnowman4
        x: scene.width / 3 * 2
        y: scene.height / 4 * 2

        rotation: 0
        opponentBody.source: "../../assets/img/final/Snowman.gif"
    }

    Opponents {
        id: opponentSnowman5
        x: scene.width / 3
        y: scene.height / 4 * 3

        rotation: 0
        opponentBody.source: "../../assets/img/final/Snowman.gif"
    }

    Opponents {
        id: opponentSnowman6
        x: scene.width / 3 * 2
        y: scene.height / 4 * 3

        rotation: 0
        opponentBody.source: "../../assets/img/final/Snowman.gif"
    }


    // obstacles
    Obstacle {
        id: obstacle1
        x: scene.width / 6
        y: scene.height / 4

        rotation: 0
        obstacleBody.source: "../../assets/img/final/Obstacle.png"
    }

    Obstacle {
        id: obstacle2
        x: scene.width / 6 * 5
        y: scene.height / 4

        rotation: 0
        obstacleBody.source: "../../assets/img/final/Obstacle.png"
    }

    Obstacle {
        id: obstacle3
        x: scene.width / 6
        y: scene.height / 4 * 3

        rotation: 0
        obstacleBody.source: "../../assets/img/final/Obstacle.png"
    }

    Obstacle {
        id: obstacle4
        x: scene.width / 6 * 5
        y: scene.height / 4 * 3

        rotation: 0
        obstacleBody.source: "../../assets/img/final/Obstacle.png"
    }


    // Tree on the left side
    Tree {
        entityId: "tree1"
        id: tree1
        x: scene.width / 6
        y: scene.height / 2

        treeBody.width: 60
        treeBody.height: 60
        circleCollider.radius: 28
        treeBody.source: "../../assets/img/final/Tree.png"
    }

    // Power up spawn right side
    PowerUpSpawn {
        entityId: "spawn1"
        id: spawn1
        x: scene.width / 6 * 5
        y: scene.height / 2

        spawnBody.width: 60
        spawnBody.height: 60
        circleCollider.radius: 28
        minSpawnRadius: 50
        spawnRadiusDelta: 0

        spawnBody.source: "../../assets/img/final/PUSpawn.png"
    }

/*
    // Obstacles in upper right and lower left corner (2 each)


    Obstacle {
        id: obstacle2
        x: scene.width / 4 * 3
        y: scene.height / 6 + 45

        rotation: 0
        obstacleBody.source: "../../assets/img/final/Obstacle.png"
    }
*/
/*

*/
/*

*/


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
