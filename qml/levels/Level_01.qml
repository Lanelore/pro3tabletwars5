import QtQuick 2.0
import VPlay 2.0
import ".."
import "../levels"

GameController {
    id: scene

    // Plant a little forest in the middle
    // from left to right
    Tree {
        entityId: "tree5"
        id: tree5
        x: tree5.treeBody.width - 18
        y: scene.height / 2 - 17
        treeBody.source: "../../assets/img/final/Tree.png"
        onEnabledChanged: GameInfo.testLevel = true
    }

    Tree {
        entityId: "tree2"
        id: tree2
        x: scene.width / 2 - tree2.treeBody.width * 2
        y: scene.height / 2 - 5
        treeBody.source: "../../assets/img/final/Tree.png"
    }

    Tree {
        entityId: "tree1"
        id: tree1
        x: scene.width / 2 - tree1.treeBody.width - 15
        y: scene.height / 2 + 5
        treeBody.source: "../../assets/img/final/Tree.png"
    }

    Tree {
        entityId: "tree3"
        id: tree3
        x: scene.width / 2 + 10
        y: scene.height / 2 - 15
        treeBody.source: "../../assets/img/final/Tree.png"
    }

    Tree {
        entityId: "tree4"
        id: tree4
        x: scene.width / 2 + tree4.treeBody.width * 2
        y: scene.height / 2 + 25
        treeBody.source: "../../assets/img/final/Tree.png"
    }

    Tree {
        entityId: "tree7"
        id: tree7
        x: scene.width - tree6.treeBody.width + 18 - tree7.treeBody.width  + 18
        y: scene.height / 2 - 4
        treeBody.source: "../../assets/img/final/Tree.png"
    }

    Tree {
        entityId: "tree6"
        id: tree6
        x: scene.width - tree6.treeBody.width + 18
        y: scene.height / 2 + 19
        treeBody.source: "../../assets/img/final/Tree.png"
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

    PowerUpAccelerator {
        id: powLifeUp
        x: scene.width / 3 * 2
        y: scene.height / 3
        tankRed: parent.tankRed
        tankBlue: parent.tankBlue
        playerRed: parent.playerRed
        playerBlue: parent.playerBlue
    }

    PowerUpLifeUp {
        id: powAccelerator
        x: scene.width / 3 - width / 2
        y: scene.height / 3 - height / 2
        tankRed: parent.tankRed
        tankBlue: parent.tankBlue
        playerRed: parent.playerRed
        playerBlue: parent.playerBlue
    }

    PowerUpPowershot {
        id: poPowershot
        x: scene.width/3 - width/2
        y: scene.height/3*2 - height/2
        tankRed: parent.tankRed
        tankBlue: parent.tankBlue
        playerRed: parent.playerRed
        playerBlue: parent.playerBlue
    }

    PowerUpPowershot {
        id: powShield
        x: scene.width/3*2 - width/2
        y: scene.height/3*2 - height/2
        tankRed: parent.tankRed
        tankBlue: parent.tankBlue
        playerRed: parent.playerRed
        playerBlue: parent.playerBlue
    }
}
