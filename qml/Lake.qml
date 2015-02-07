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

    width: 500
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
            Qt.point(lakeBody.x+lakeBody.width-100, lakeBody.y+90),
            Qt.point(lakeBody.x+220,lakeBody.y+30),
            Qt.point(lakeBody.x+130, lakeBody.y+lakeBody.height-130),
            Qt.point(lakeBody.x+lakeBody.width-150, lakeBody.y+lakeBody.height-90)
        ]

        anchors.centerIn: parent

        //sensor:true

        collisionTestingOnlyMode: true


        fixture.onBeginContact: {
            // handle the collision and make the image semi-transparent
            var collidedEntity = other.parent.parent.parent;

            if(tankRed.entityId === collidedEntity.entityId){
                GameInfo.redOnLake=true
            }

            if(tankBlue.entityId === collidedEntity.entityId){
                GameInfo.blueOnLake=true
            }
        }

        fixture.onEndContact: {
            // handle the collision and make the image visible

            var collidedColliderComponent = other.parent.parent;
            var collidedEntity = collidedColliderComponent.parent;

            if(tankRed.entityId ===collidedEntity.entityId){
                GameInfo.redOnLake=false
                redOffLake()
            }

            if(tankBlue.entityId ===collidedEntity.entityId){
                GameInfo.blueOnLake=false
                blueOffLake()
            }
        }
    }
}
