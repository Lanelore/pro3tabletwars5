import QtQuick 2.0
import VPlay 2.0
import "."

EntityBase {
    id: powShield
    entityType: "powShield"
    z: 1

    property var tankRed
    property var tankBlue
    property var playerRed
    property var playerBlue

    onEntityCreated: GameInfo.powerUpCount+=1

    Rectangle {
        id: powShieldBody
        width: 50
        height: 50
        rotation: 45
        color: "orange"
        Rectangle {
            id: powShieldBodyInner
            width: 30
            height: 30
            anchors.centerIn: powShieldBody
            color: "yellow"
        }
    }

    BoxCollider {
        id: boxCollider
        anchors.fill: powShieldBody
        anchors.centerIn: parent
        sensor:true

        fixture.onBeginContact: {

            var collidedEntity = other.parent.parent.parent;

            //console.log("onBeginContact: " + collidedEntity.entityId)
            if(tankRed.entityId === collidedEntity.entityId){
                playerRed.activateShield = true
                powShield.destroy()
                GameInfo.powerUpCount-=1
            } else if(tankBlue.entityId === collidedEntity.entityId){
                playerBlue.activateShield = true
                powShield.destroy()
                GameInfo.powerUpCount-=1
            }
        }
    }
}
