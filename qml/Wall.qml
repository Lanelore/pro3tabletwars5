import QtQuick 2.0
import VPlay 2.0

EntityBase {
    id: entity
    entityId: "Wall"
    entityType: "wall"
    property alias image: image

    /*
    Rectangle {
        anchors.fill: parent
        color: "brown"
        visible: true // set to 'true' for debugging
    }
*/
    Image {
        id: image
        anchors.fill: parent
    }

    BoxCollider {
        id: boxCollider
        bodyType: Body.Static
        // the size of the collider is the same as the one from the entity by default        
    }
}
