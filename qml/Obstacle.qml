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

            var collidedEntity = other.parent.parent.parent;
            //console.log("bullet collides with something:" + collidedEntity.entityId)

            if(!playerRed.activateHitShield && tankRed.entityId===collidedEntity.entityId){
                if(!playerRed.activateShield && !playerRed.activateHitShield) {
                    playerRed.life=playerRed.life-GameInfo.normalDamage
                    playerRed.activateHitShield = true
                    damage()
                }
            }
            if(!playerBlue.activateHitShield && tankBlue.entityId===collidedEntity.entityId){
                if(!playerBlue.activateShield && !playerBlue.activateHitShield) {
                    playerBlue.life=playerBlue.life-GameInfo.normalDamage
                    playerBlue.activateHitShield = true
                    damage()
                }
            }
        }
    }
}
