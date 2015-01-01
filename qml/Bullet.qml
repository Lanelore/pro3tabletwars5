import QtQuick 2.0
import VPlay 2.0
import "levels"
import ".."
import "../qml"


EntityBase {
    id: singleBullet
    entityType: "singleBullet"

    Rectangle {
        width: 10
        height: 10
        //anchors.fill: parent
        color: "#000000"
    }

    property point start
    property point velocity
    property int bulletType // 0 normal bullet, 1 strong bullet

    x: start.x
    y: start.y

    BoxCollider {
        id: boxCollider

        width: 10
        height: 10
        anchors.fill: parent
        collisionTestingOnlyMode: true

        density: 0
        friction: 0
        restitution: 0
        body.bullet: true
        body.fixedRotation: false // if set to true the physics engine will NOT apply rotation to it

        // handle the collision
        fixture.onBeginContact: {

            var fixture = other;
            var body = other.parent;
            var component = other.parent.parent;

            console.log("body.entityId: " + component.entityId);
            console.log("component.entityId: " + component.entityId);
            console.log("component.parent.entityId: " + component.parent.entityId); // tank_1
            console.log("Component.parent.parent.entityId: " + component.parent.parent.entityId); // playerRed / playerBlue

            var otherEntity = component.parent;
            var otherEntityId = component.parent.entityId;
            var otherEntityParent = otherEntity.parent;

            // destroy the bullet if it collided with anything but lake or powerup
            if (otherEntityId.substring(0, 3) !== "lak" && otherEntityId.substring(0, 3) !== "pow") {
                console.log("bullet collides with: " + otherEntityId);
                singleBullet.destroy();

                // check if it hit a player
                if (otherEntityParent.entityId.substring(0, 6) === "player") {

                    // call damage method on playerred/playerblue
                    otherEntityParent.onDamageWithBulletType(bulletType);
                }
            }
        }
    }

    MovementAnimation {
        target: singleBullet

        property: "x"
        velocity: singleBullet.velocity.x
        running: true
    }

    MovementAnimation {
        target: singleBullet

        property: "y"
        velocity: singleBullet.velocity.y
        running: true
        onStopped: {
            singleBullet.destroy()
        }
    }
}
