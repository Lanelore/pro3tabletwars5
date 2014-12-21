import QtQuick 2.0
import VPlay 2.0
import "levels"
import "."

EntityBase {
    id: lake
    entityId: "lake"
    entityType: "lake"

    property alias lakeBody: lakeBody
    property alias boxCollider: boxCollider

    width: 400
    height: 400

    Image {
        id: lakeBody
        width: parent.width
        height: parent.height
        //rotation: 0
        anchors.centerIn: parent
    }

    PolygonCollider {
        id: boxCollider

        /*
        // the image and the physics will use this size
        //anchors.fill: lakeBody
        width: lakeBody.width-140
        height: lakeBody.height-140
        */

        vertices: [
            Qt.point(lakeBody.x+50,lakeBody.y+50),
            Qt.point(lakeBody.x+lakeBody.width-50, lakeBody.y+50),
            Qt.point(lakeBody.x+50, lakeBody.y+lakeBody.height-50)
        ]

        anchors.centerIn: parent

        //sensor:true

        collisionTestingOnlyMode: true


        fixture.onBeginContact: {

            // handle the collision and make the image semi-transparent

            var collidedEntity = other.parent.parent.parent;
            console.log("object collides with lake:" + collidedEntity.entityId)

            if(tankRed.entityId === collidedEntity.entityId){
                //tankRed.opacity = 0.5
                console.log("tankRed is inside the lake, joystick = " ) //+ playerMovementControlAreaRed)
                //playerMovementControlAreaRed.enabled=false;
                //redOnLake()
                GameInfo.redOnLake=true
            }

            if(tankBlue.entityId === collidedEntity.entityId){
                //tankBlue.opacity = 0.5
                console.log("tankRed is inside the lake, joystick = " )//+ playerMovementControlAreaBlue)
                //playerMovementControlAreaBlue.enabled=false;
                //blueOnLake()
                GameInfo.blueOnLake=true
            }

            console.log("contact!")
        }

        fixture.onEndContact: {
            // handle the collision and make the image visible

            var collidedColliderComponent = other.parent.parent;
            var collidedEntity = collidedColliderComponent.parent;
            console.log(collidedEntity.entityId)

            if(tankRed.entityId ===collidedEntity.entityId){
                //tankRed.opacity = 1
                console.log("tankRed is outside the lake!")
                //playerMovementControlAreaRed.enabled=true;
                //redOffLake();
                GameInfo.redOnLake=false
            }

            if(tankBlue.entityId ===collidedEntity.entityId){
                //tankBlue.opacity = 1
                console.log("tankBlue is outside the lake!")
                //playerMovementControlAreaBlue.enabled=true;
                //blueOffLake()
                GameInfo.blueOnLake=false
            }

            console.log("contact!")
        }
    }
}
