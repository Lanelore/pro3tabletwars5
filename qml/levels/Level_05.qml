import QtQuick 2.0
import VPlay 2.0
import ".."
import "../levels"

GameController {
    id: scene

    // iglu in upper right corner
    Iglu {
        igluCount: 2
        entityId: "iglu1"
        id: iglu1

        x: scene.width - iglu1.igluBody.width / 2
        y: iglu1.igluBody.height
        z: 2

        igluBody.source: "../../assets/img/final/Iglu.png"
        rotation: 225
    }

    // Iglu in lower left corner
    Iglu {
        igluCount: 2
        entityId: "iglu2"
        id: iglu2

        x: iglu2.igluBody.width / 2
        y: scene.height - iglu2.igluBody.height
        z: 2

        igluBody.source: "../../assets/img/final/Iglu.png"
        rotation: 45
    }

    // Plant a row of trees at bottom
    // from left to right
    Tree {
        entityId: "tree1"
        id: tree1
        x: 40
        y: scene.height / 3 * 2
        treeBody.source: "../../assets/img/final/Tree.png"
    }

    Tree {
        entityId: "tree2"
        id: tree2
        x: 40 + tree2.treeBody.width
        y: scene.height / 3 * 2
        treeBody.source: "../../assets/img/final/Tree.png"
    }

    Tree {
        entityId: "tree3"
        id: tree3
        x: 40 + tree3.treeBody.width * 2
        y: scene.height / 3 * 2
        treeBody.source: "../../assets/img/final/Tree.png"
    }

    Tree {
        entityId: "tree4"
        id: tree4
        x: 40 + tree4.treeBody.width * 3
        y: scene.height / 3 * 2
        treeBody.source: "../../assets/img/final/Tree.png"
    }

    Tree {
        entityId: "tree5"
        id: tree5
        x: 40 + tree5.treeBody.width * 4
        y: scene.height / 3 * 2
        treeBody.source: "../../assets/img/final/Tree.png"
    }

    Tree {
        entityId: "tree6"
        id: tree6
        x: 40 + tree6.treeBody.width * 5
        y: scene.height / 3 * 2
        treeBody.source: "../../assets/img/final/Tree.png"
    }

    Tree {
        entityId: "tree7"
        id: tree7
        x: 40 + tree7.treeBody.width * 6
        y: scene.height / 3 * 2
        treeBody.source: "../../assets/img/final/Tree.png"
    }



    // Plant a row of trees at top
    // from right to left
    Tree {
        entityId: "tree8"
        id: tree8
        x: scene.width - tree8.treeBody.width
        y: scene.height / 3
        treeBody.source: "../../assets/img/final/Tree.png"
    }

    Tree {
        entityId: "tree9"
        id: tree9
        x: scene.width - tree9.treeBody.width * 2
        y: scene.height / 3
        treeBody.source: "../../assets/img/final/Tree.png"
    }

    Tree {
        entityId: "tree10"
        id: tree10
        x: scene.width - tree10.treeBody.width * 3
        y: scene.height / 3
        treeBody.source: "../../assets/img/final/Tree.png"
    }

    Tree {
        entityId: "tree11"
        id: tree11
        x: scene.width - tree11.treeBody.width * 4
        y: scene.height / 3
        treeBody.source: "../../assets/img/final/Tree.png"
    }

    Tree {
        entityId: "tree12"
        id: tree12
        x: scene.width - tree12.treeBody.width * 5
        y: scene.height / 3
        treeBody.source: "../../assets/img/final/Tree.png"
    }

    Tree {
        entityId: "tree13"
        id: tree13
        x:scene.width - tree13.treeBody.width * 6
        y: scene.height / 3
        treeBody.source: "../../assets/img/final/Tree.png"
    }

    Tree {
        entityId: "tree14"
        id: tree14
        x: scene.width - tree14.treeBody.width * 7
        y: scene.height / 3
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
}
