import QtQuick 2.0
import VPlay 2.0
import "."

EntityBase {
    id: obstacle
    entityType: "obstacle"

    property alias obstacleBody: obstacleBody
    property alias boxCollider: boxCollider

    Image {
        id: obstacleBody
        width: 40
        height: 40
        //rotation: 0
        anchors.centerIn: parent
    }

    BoxCollider {
        id: boxCollider

        // the image and the physics will use this size
        anchors.fill: obstacleBody
        anchors.centerIn: parent

        //density: 100000000
        bodyType: Body.Static

        fixture.onBeginContact: {
            // handle the collision and make the image semi-transparent

            var fixture = other;
            var body = other.parent;
            var component = other.parent.parent;

            var otherEntity = component.parent;
            var otherEntityId = component.parent.entityId;
            var otherEntityParent = otherEntity.parent;


            // check if it hit a player
            if (otherEntityParent.entityId.substring(0, 6) === "player") {

                // call damage method on playerred/playerblue
                otherEntityParent.onDamage();
            }
        }
    }
}
