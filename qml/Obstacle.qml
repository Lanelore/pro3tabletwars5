import QtQuick 2.0
import VPlay 2.0
import "."

EntityBase {
    id: obstacle
    entityType: "obstacle"
    entityId: "obstacle"

    property alias obstacleBody: obstacleBody
    property alias circleCollider: circleCollider

    Image {
        id: obstacleBody
        width: 50
        height: 50
        //rotation: 0
        anchors.centerIn: parent
    }

    CircleCollider {
        id: circleCollider

        radius: obstacleBody.width/2
        x: radius
        y: radius

        // the image and the physics will use this size
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
            if (otherEntityId.substring(0, 4) === "tank") {

                // call damage method on playerred/playerblue
                otherEntityParent.onDamage();
            }
        }
    }
}
