import QtQuick 2.0
import VPlay 2.0
import "."


EntityBase {
    id: powLifeUp
    entityType: "powLifeUp"
    entityId: "powLifeUp"

    property var tankRed
    property var tankBlue
    property var playerRed
    property var playerBlue

    onEntityCreated: GameInfo.powerUpCount+=1

    width: 50
    height: 50

    AnimatedImage {
        id: powLifeUpImage
        width: parent.width
        height: parent.height
        z: 1
        source: "../assets/img/final/PULifeUP.gif"
        anchors.centerIn: parent
        playing: true
    }

    /*
    Rectangle {
        id: powLifeUpBody
        width: 50
        height: 50
        rotation: 45
        color: "darkRed"

        Rectangle {
            id: powLifeUpBodyInner
            width: 30
            height: 30
            anchors.centerIn: powLifeUpBody
            color: "red"
        }
    }
*/

    BoxCollider {
        id: boxCollider
        anchors.fill: powLifeUpImage
        anchors.centerIn: parent
        sensor:true


        fixture.onBeginContact: {
            var collidedEntity = other.parent.parent.parent;

            //console.log("onBeginContact: " + collidedEntity.entityId)

            if(tankRed.entityId === collidedEntity.entityId){
                tankRed.glitter.playing=true;
                tankRed.plingSound.play();
                powLifeUp.destroy()
                GameInfo.powerUpCount-=1
                playerRed.life+=GameInfo.fillEnergy
                if (playerRed.life+GameInfo.fillEnergy>GameInfo.maxEnergy) playerRed.life=100

            } else if(tankBlue.entityId === collidedEntity.entityId){
                tankBlue.glitter.playing=true;
                tankBlue.plingSound.play();
                powLifeUp.destroy()
                GameInfo.powerUpCount-=1
                playerBlue.life+=GameInfo.fillEnergy
                if (playerBlue.life+GameInfo.fillEnergy>GameInfo.maxEnergy) playerBlue.life=100
            }
        }
    }
}
