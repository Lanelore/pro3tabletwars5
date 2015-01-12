import QtQuick 2.0
import VPlay 2.0
import "levels"

EntityBase {
    z: 1
    id: iglu
    entityId: "iglu"
    entityType: "iglu"

    property int igluCount
    property alias igluBody: igluBody
    property alias porter: porter
    property alias rectColliderLeft: rectColliderLeft
    property alias rectColliderRight: rectColliderRight
    property alias rectColliderBottom: rectColliderBottom
    property alias teleportGlow: teleportGlow
    property alias teleportSound: teleportSound

    width: 150
    height: 180

    // gets played when tank shoots a normal bullet
    SoundEffectVPlay {
        volume: 0.3
        id: teleportSound
        // an ogg file is not playable on windows, because the extension is not supported!
        source: "../assets/snd/Teleport.wav"
    }

    Image {
        id: igluBody
        width: parent.width
        height: parent.height
        //rotation: 0
        anchors.centerIn: parent
    }

    PolygonCollider {
        bodyType: Body.Static
        id: rectColliderLeft

        vertices: [
            Qt.point(igluBody.x + igluBody.width/5, igluBody.y),
            Qt.point(igluBody.x, igluBody.y + igluBody.height/2),
            Qt.point(igluBody.x + igluBody.width/7, igluBody.y + igluBody.height/7*6),
            Qt.point(igluBody.x + igluBody.width/2, igluBody.y+igluBody.height)
        ]

        transform: Rotation {
            origin.x: iglu.width / 2
            origin.y: iglu.width / 2
            angle: 135
        }

        anchors.centerIn: parent
    }

    PolygonCollider {
        bodyType: Body.Static
        id: rectColliderRight

        vertices: [
            Qt.point(igluBody.x + igluBody.width/5*4, igluBody.y),
            Qt.point(igluBody.x + igluBody.width, igluBody.y + igluBody.height/2),
            Qt.point(igluBody.x + igluBody.width/7*6, igluBody.y + igluBody.height/7*6),
            Qt.point(igluBody.x+igluBody.width/2, igluBody.y+igluBody.height)
        ]

        anchors.centerIn: parent
    }

    PolygonCollider {
        bodyType: Body.Static
        id: rectColliderBottom

        vertices: [
            Qt.point(igluBody.x + igluBody.width/5, igluBody.y + igluBody.height/5*2),
            Qt.point(igluBody.x + igluBody.width/5*4, igluBody.y + igluBody.height/5*2),
            Qt.point(igluBody.x+igluBody.width/2, igluBody.y+igluBody.height)
        ]

        anchors.centerIn: parent
    }

    //glitter effect when collecting a life powerup
    AnimatedImage {
        id: teleportGlow
        width: 50
        height: 50
        anchors.bottom: rectColliderBottom.bottom
        anchors.bottomMargin: 20
        anchors.left: rectColliderBottom.left
        anchors.leftMargin: 55
        playing: false
        source: "../assets/img/final/TeleportGlow.gif"
    }

    // ATTENTION!!!!
    // TWO SEPARATE TIMERS ARE NEEDED for the case that two players go into the same iglu at the same time
    Timer {
        // This timer is used to let the player disappear for a certain amount of time when he enters an iglu
        id: teleportTimerPlayerBlue
        interval: 750
        running: false
        repeat: false

        property var destIglu // destinationIglu
        property var teleportedPlayer
        property var destinationX
        property var destinationY

        onTriggered:{

            teleportedPlayer.x = destinationX
            teleportedPlayer.y = destinationY
            teleportedPlayer.rotation = destIglu.rotation

            //destIglu.teleportGlow.playing = false
            //destIglu.opacity = 1.0
            teleportedPlayer.opacity = 1.0
        }
    }

    Timer {
        id: teleportTimerPlayerRed
        interval: 750
        running: false
        repeat: false

        property var destIglu
        property var teleportedPlayer
        property var destinationX
        property var destinationY

        onTriggered: {
            teleportedPlayer.x = destinationX
            teleportedPlayer.y = destinationY
            teleportedPlayer.rotation = destIglu.rotation

            //destIglu.teleportGlow.playing = false
            teleportedPlayer.opacity = 1.0
        }
    }

    BoxCollider {
        density: 100000000
        id: porter
        width: igluBody.width/2
        height: igluBody.height/2
        anchors.centerIn: parent
        collisionTestingOnlyMode: true

        fixture.onBeginContact: {
            var collidedColliderComponent = other.parent.parent;
            var collidedEntity = collidedColliderComponent.parent;

            if (collidedEntity.entityId == tankRed.entityId || collidedEntity.entityId == tankBlue.entityId) {
                teleportSound.play()

                console.log("fixture.parent.parent.parent.x: " + fixture.parent.parent.parent.x)
                console.log("fixture.x: " + fixture.x)
                collidedEntity.x = fixture.parent.parent.parent.x + 100
                collidedEntity.y = fixture.parent.parent.parent.y + 100

                // Load all iglus of this level
                var iglus = entityManager.getEntityArrayByType("iglu")

                // create a random int of the iglus-array-length
                var random = Math.floor(Math.random() * (iglus.length))
                var destinationIglu = iglus[random] // load a random iglu

                // get a random iglu as long as the retained iglu is the same that the player moved into!
                while(iglu.entityId == destinationIglu.entityId) {
                    random = Math.floor(Math.random() * (iglus.length))
                    destinationIglu = iglus[random]
                }

                // calculate the x and y position where the player should appear
                var destinationX = (80 * Math.cos((destinationIglu.rotation - 10) * Math.PI / 180)) + destinationIglu.x + tankRed.width / 2
                var destinationY = (80 * Math.sin((destinationIglu.rotation - 10) * Math.PI / 180)) + destinationIglu.y + tankRed.width / 2

                collidedEntity.opacity = 0.0
                //destinationIglu.opacity = 0.0
                destinationIglu.teleportGlow.playing = false
                destinationIglu.teleportGlow.playing = true

                if (collidedEntity.entityId == tankRed.entityId) {
                    // Player Red
                    teleportTimerPlayerRed.destinationX = destinationX
                    teleportTimerPlayerRed.destinationY = destinationY
                    teleportTimerPlayerRed.destIglu = destinationIglu
                    teleportTimerPlayerRed.teleportedPlayer = collidedEntity
                    teleportTimerPlayerRed.start()
                } else {
                    // Player Iglu
                    teleportTimerPlayerBlue.destinationX = destinationX
                    teleportTimerPlayerBlue.destinationY = destinationY
                    teleportTimerPlayerBlue.destIglu = destinationIglu
                    teleportTimerPlayerBlue.teleportedPlayer = collidedEntity
                    teleportTimerPlayerBlue.start()
                }
            }

            return

            /*
  Old Code, not iglu-count independent!

            var igluX
            var igluY
            var igluR
            var random = Math.ceil(Math.random() * (igluCount-1));

            if (fixture === iglu1.porter.fixture){
                random = (random==1) ? 2 : 3;
            }else if (fixture === iglu2.porter.fixture){
                random = (random==1) ? 1 : 3;
            }else{
                random = (random==1) ? 1 : 2;
            }

            if (random == 1){
            igluX= (80*Math.cos((iglu1.rotation-10)*Math.PI/180)) + iglu1.x + tankRed.width/2
            igluY= (80*Math.sin((iglu1.rotation-10)*Math.PI/180)) + iglu1.y + tankRed.width/2
                igluR = iglu1.rotation
            }else if (random == 2){
                igluX= (80*Math.cos((iglu2.rotation-10)*Math.PI/180)) + iglu2.x - tankRed.width/2
                igluY= (80*Math.sin((iglu2.rotation-10)*Math.PI/180)) + iglu2.y - tankRed.width/2
                igluR = iglu2.rotation
            }else{
                igluX= (80*Math.cos((iglu3.rotation-10)*Math.PI/180)) + iglu3.x - tankRed.width/2
                igluY= (80*Math.sin((iglu3.rotation-10)*Math.PI/180)) + iglu3.y - tankRed.width/2
                igluR = iglu3.rotation
            }

            if(tankRed.entityId === collidedEntity.entityId){
                tankRed.x = igluX
                tankRed.y = igluY
                tankRed.rotation = igluR
            }

            if(tankBlue.entityId === collidedEntity.entityId){
                tankBlue.x = igluX
                tankBlue.y = igluY
                tankBlue.rotation = igluR
            }
            */
        }
    }
}
