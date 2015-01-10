import QtQuick 2.0
import VPlay 2.0
import "."

EntityBase {
    id: powPowershot
    entityType: "powPowershot"
    z: 1

    property var tankRed
    property var tankBlue
    property var playerRed
    property var playerBlue

    onEntityCreated: GameInfo.powerUpCount+=1

    width: 50
    height: 50

    AnimatedImage {
        id: powPowershotImage
        width: parent.width
        height: parent.height
        z: 1
        source: "../assets/img/final/PUPowershot.gif"
        anchors.centerIn: parent
        playing: true
    }

/*
    Rectangle {
        id: powPowershotBody
        width: 50
        height: 50
        rotation: 45
        color: "darkGreen"
        z: 1

        Rectangle {
            id: powPowershotBodyInner
            width: 30
            height: 30
            anchors.centerIn: powPowershotBody
            color: "lightGreen"
        }
    }
*/
    BoxCollider {
        id: boxCollider
        anchors.fill: powPowershotImage
        anchors.centerIn: parent
        sensor:true

        fixture.onBeginContact: {
            var collidedEntity = other.parent.parent.parent;

            //console.log("onBeginContact: " + collidedEntity.entityId)

            if(tankRed.entityId === collidedEntity.entityId){
                tankRed.plingSound.play();
                playerRed.activatePowershot = true
                powPowershot.destroy()
                GameInfo.powerUpCount-=1
            } else if(tankBlue.entityId === collidedEntity.entityId){
                tankBlue.plingSound.play();
                playerBlue.activatePowershot = true
                powPowershot.destroy()
                GameInfo.powerUpCount-=1
            }
        }
    }
}
