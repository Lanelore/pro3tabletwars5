import QtQuick 2.0
import VPlay 2.0

EntityBase {
    id: entity
    entityType: "wall"

    Rectangle {
        anchors.fill: parent
        color: "brown"
        visible: true // set to 'true' for debugging
    }

    BoxCollider {
        id: boxCollider
        bodyType: Body.Static
        // the size of the collider is the same as the one from the entity by default        
    }
}
