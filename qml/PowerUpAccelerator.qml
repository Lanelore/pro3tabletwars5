import QtQuick 2.0
import VPlay 2.0
import "."

EntityBase {
    id: powAccelerator
    entityType: "powAccelerator"
   // entityId: "powAccelerator"
    z: 1

    property var tankRed
    property var tankBlue
    property var playerRed
    property var playerBlue

    onEntityCreated: GameInfo.powerUpCount+=1

    width: 50
    height: 50

    AnimatedImage {
        id: powAcceleratorImage
        width: parent.width
        height: parent.height
        z: 1
        source: "../assets/img/final/PUAccelerator.gif"
        anchors.centerIn: parent
        playing: true
    }

    /*
    Rectangle {
        id: powAcceleratorBody
        width: 50
        height: 50
        rotation: 45
        color: "darkBlue"
        z: 1

        Rectangle {
            id: powAcceleratorBodyInner
            width: 30
            height: 30
            anchors.centerIn: powAcceleratorBody
            color: "lightBlue"
        }
    }
*/

    BoxCollider {
        id: boxCollider
        anchors.fill: powAcceleratorImage
        anchors.centerIn: parent
        sensor:true

        fixture.onBeginContact: {
            var collidedEntity = other.parent.parent.parent;
            //console.log("onBeginContact: " + collidedEntity.entityId)
            if(tankRed.entityId === collidedEntity.entityId){
                tankRed.plingSound.play();
                playerRed.activateAccelerator = true
                powAccelerator.destroy()
                GameInfo.powerUpCount-=1
            } else if(tankBlue.entityId === collidedEntity.entityId){
                tankBlue.plingSound.play();
                playerBlue.activateAccelerator = true
                powAccelerator.destroy()
                GameInfo.powerUpCount-=1
            }
        }
    }
}
