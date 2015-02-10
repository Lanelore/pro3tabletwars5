import QtQuick 2.0
import VPlay 2.0
import ".."
import "../levels"

GameController {
    id: scene


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





    // Trees: vertical line of 3 trees on left side, same on right side
    Tree {
        entityId: "tree1"
        id: tree1
        x: scene.width / 3 - width / 2
        y: scene.height / 4 - height / 2

        treeBody.source: "../../assets/img/final/Tree.png"
    }

    Tree {
        entityId: "tree2"
        id: tree2
        x: scene.width / 3 - width / 2
        y: scene.height / 4 * 2 - height / 2

        treeBody.source: "../../assets/img/final/Tree.png"
    }

    Tree {
        entityId: "tree3"
        id: tree3
        x: scene.width / 3 - width / 2
        y: scene.height / 4 * 3 - height / 2

        treeBody.source: "../../assets/img/final/Tree.png"
    }

    Tree {
        entityId: "tree4"
        id: tree4
        x: scene.width / 3 * 2 - width / 2
        y: scene.height / 4 * 1 - height / 2

        treeBody.source: "../../assets/img/final/Tree.png"
    }

    Tree {
        entityId: "tree5"
        id: tree5
        x: scene.width / 3 * 2 - width / 2
        y: scene.height / 4 * 2 - height / 2

        treeBody.source: "../../assets/img/final/Tree.png"
    }

    Tree {
        entityId: "tree6"
        id: tree6
        x: scene.width / 3 * 2 - width / 2
        y: scene.height / 4 * 3 - height / 2

        treeBody.source: "../../assets/img/final/Tree.png"
    }

    Tree {
        entityId: "tree7"
        id: tree7
        x: scene.width / 5 - width / 2
        y: scene.height / 7 * 3 - height / 2 - 50

        treeBody.source: "../../assets/img/final/Tree.png"
    }

    Tree {
        entityId: "tree8"
        id: tree8
        x: scene.width / 5 - width / 2
        y: scene.height / 7 * 5 - height / 2 - 90

        treeBody.source: "../../assets/img/final/Tree.png"
    }

    Tree {
        entityId: "tree9"
        id: tree9
        x: scene.width / 5 * 4 - width / 2
        y: scene.height / 7 * 3 - height / 2 - 50

        treeBody.source: "../../assets/img/final/Tree.png"
    }

    Tree {
        entityId: "tree10"
        id: tree10
        x: scene.width / 5 * 4 - width / 2
        y: scene.height / 7 * 5 - height / 2 - 90

        treeBody.source: "../../assets/img/final/Tree.png"
    }









    // Power up spawn horizontal center, two in upper half, two in lower half
    PowerUpSpawn {
        entityId: "spawn1"
        id: spawn1
        x: scene.width / 2 - width / 2
        y: scene.height / 5 - height / 2

        spawnBody.source: "../../assets/img/final/PUSpawn.png"
    }

    PowerUpSpawn {
        entityId: "spawn2"
        id: spawn2
        x: scene.width / 2 - width / 2
        y: scene.height / 5 * 2 - height / 2

        spawnBody.source: "../../assets/img/final/PUSpawn.png"
    }

    PowerUpSpawn {
        entityId: "spawn3"
        id: spawn3
        x: scene.width / 2 - width / 2
        y: scene.height / 5 * 3 - height / 2

        spawnBody.source: "../../assets/img/final/PUSpawn.png"
    }

    PowerUpSpawn {
        entityId: "spawn4"
        id: spawn4
        x: scene.width / 2 - width / 2
        y: scene.height / 5 * 4 - height / 2

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

