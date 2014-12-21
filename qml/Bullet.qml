import QtQuick 2.0
import VPlay 2.0
import "levels"


Component {
/*
    id: bullet

    EntityBase {
        id: singleBullet
        entityType: "singleBullet"
        entityId: eIdSingleBullet

        //onWidthChanged: console.log("from x: " + start.x + " to x: " + destination.x + " Duration: " + moveDuration)

        Rectangle {
            width: 10
            height: 10
            //anchors.fill: parent
            color: "#000000"
        }

        property point start
        property point destination
        property int moveDuration

        BoxCollider {
            id: boxCollider

            width: 10
            height: 10
            anchors.centerIn: parent
            collisionTestingOnlyMode: true

            density: 0
            friction: 0
            restitution: 0
            body.bullet: true
            body.fixedRotation: false // if set to true the physics engine will NOT apply rotation to it
        }

        PropertyAnimation on x {
            from: start.x + start.width / 2
            to: destination.x
            duration: moveDuration
        }

        PropertyAnimation on y {
            from: start.y + start.height / 2 - 4
            to: destination.y
            duration: moveDuration

            onStopped: {
                console.log("did Destroy")
                bullet.destroy()
            }
        }
    }
*/
}
