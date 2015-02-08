import QtQuick 2.0
import VPlay 2.0
import ".."
import "../levels"

GameController {
    id: scene


    // Place lakes in vertical center, one on the left and one on the right side
    Lake {
        id: lake1
        x: - width / 3
        y: scene.height / 2 - height / 2

        rotation: 0
        lakeBody.source: "../../assets/img/final/Lake.png"
    }

    Lake {
        id: lake2
        x: scene.width - width / 3 * 2.3
        y: scene.height / 2 - height / 2

        rotation: 0
        lakeBody.source: "../../assets/img/final/Lake.png"
    }

    // Snowmen in upper and lower half, horizontally centered
    Opponents {
        id: opponentSnowman1
        x: scene.width / 2 - width / 2
        y: scene.height / 5 - height / 2

        rotation: 0
        opponentBody.source: "../../assets/img/final/Snowman.gif"
    }

    Opponents {
        id: opponentSnowman2
        x: scene.width / 2 - width / 2
        y: scene.height / 5 * 4 - height / 2

        rotation: 0
        opponentBody.source: "../../assets/img/final/Snowman.gif"
    }


    // Obstacles in 4 corners
    Obstacle {
        id: obstacle1
        x: scene.width / 4 - width / 2
        y: scene.height / 5 - height / 2

        rotation: 0
        obstacleBody.source: "../../assets/img/final/Obstacle.png"
    }

    Obstacle {
        id: obstacle2
        x: scene.width / 4 * 3 - width / 2
        y: scene.height / 5 - height / 2

        rotation: 0
        obstacleBody.source: "../../assets/img/final/Obstacle.png"
          }

    Obstacle {
        id: obstacle3
        x: scene.width / 4 - width / 2
        y: scene.height / 5 * 4 - height / 2

        rotation: 0
        obstacleBody.source: "../../assets/img/final/Obstacle.png"
           }

    Obstacle {
        id: obstalce4
        x: scene.width / 4 * 3 - width / 2
        y: scene.height / 5 * 4 - height / 2

        rotation: 0
        obstacleBody.source: "../../assets/img/final/Obstacle.png"
       }


    // Trees: plant a line of trees along the vertical center, between the lakes
    Tree {
        entityId: "tree1"
        id: tree1
        x: scene.width / 2 - width / 2
        y: scene.height / 2 - height / 2

        treeBody.source: "../../assets/img/final/Tree.png"
    }

    Tree {
        entityId: "tree2"
        id: tree2
        x: scene.width / 2 + 70
        y: scene.height / 2 - height / 2

        treeBody.source: "../../assets/img/final/Tree.png"
    }

    Tree {
        entityId: "tree3"
        id: tree3
        x: scene.width / 2 + 140
        y: scene.height / 2 - height / 2

        treeBody.source: "../../assets/img/final/Tree.png"
    }

    Tree {
        entityId: "tree4"
        id: tree4
        x: scene.width / 2 - 70
        y: scene.height / 2 - height / 2

        treeBody.source: "../../assets/img/final/Tree.png"
    }

    Tree {
        entityId: "tree5"
        id: tree5
        x: scene.width / 2 - 140
        y: scene.height / 2 - height / 2

        treeBody.source: "../../assets/img/final/Tree.png"
    }


    // Power up spawn in upper and lower half, horizontally centered
    PowerUpSpawn {
        entityId: "spawn1"
        id: spawn1
        x: scene.width / 2 - width / 2
        y: scene.height / 2 - 150

        spawnBody.source: "../../assets/img/final/PUSpawn.png"
    }

    PowerUpSpawn {
        entityId: "spawn2"
        id: spawn2
        x: scene.width / 2 - width / 2
        y: scene.height / 2 + 150

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

