import QtQuick 2.0
import VPlay 2.0
import "."

EntityBase {
    id: powShield
    entityType: "powShield"
 //   entityId: "powShield"
    z: 1

    property var tankRed
    property var tankBlue
    property var playerRed
    property var playerBlue

    onEntityCreated: GameInfo.powerUpCount+=1

    width: 50
    height: 50

    AnimatedImage {
        id: powShieldImage
        width: parent.width
        height: parent.height
        z: 1
        source: "../assets/img/final/PUShield.gif"
        anchors.centerIn: parent
        playing: true
    }

/*
    Rectangle {
        id: powShieldBody
        width: 50
        height: 50
        rotation: 45
        color: "orange"
        z: 1

        Rectangle {
            id: powShieldBodyInner
            width: 30
            height: 30
            anchors.centerIn: powShieldBody
            color: "yellow"
        }
    }
*/
    BoxCollider {
        id: boxCollider
        anchors.fill: powShieldImage
        anchors.centerIn: parent
        sensor:true

        fixture.onBeginContact: {
            var collidedEntity = other.parent.parent.parent;

            if(tankRed.entityId === collidedEntity.entityId){
                tankRed.plingSound.play();
                playerRed.activateShield = true
                playerRed.activeShieldCounter = 0
                powShield.destroy()
                GameInfo.powerUpCount-=1
            } else if(tankBlue.entityId === collidedEntity.entityId){
                tankBlue.plingSound.play();
                playerBlue.activateShield = true
                playerBlue.activeShieldCounter = 0
                powShield.destroy()
                GameInfo.powerUpCount-=1
            }
        }
    }
}
