import QtQuick 2.0
import VPlay 2.0

EntityBase {
    entityType: "tank"
    id: tank

    // make the twoAxisController acessible from outside
    property alias controller: twoAxisController
    property alias tankBody: tankBody
    property alias tankHead: tankHead
    property alias tankCannon: tankCannon
    property alias circleCollider: circleCollider
    property alias shield: shield

    property int life: 3
    property int cannonAngle: 0 // range of about -35 to + 35 degrees, the difference to the tankbody-angle
    // flag indicating if dead
    //property bool gameRunning: life == 0


    // this is used as input for the BoxCollider force & torque properties

    TwoAxisController {
        id: twoAxisController
    }

    AnimatedImage {
        id: tankBody
        width: 40
        height: 40
        //rotation: 0
        anchors.centerIn: parent
        playing: false
    }

    Rectangle {
        id: tankCannon

        x: tankBody.x + tankBody.width / 2
        y: tankBody.y + tankBody.height / 2 - 2
        width: 4 //26
        height: 4
        transformOrigin: Item.Left
        //transformOriginPoint: Qt.point(13, 2)

        color: "transparent"
/*
        Image {
            id: tankHead
            width: 40
            height: 40
            //transformOrigin: Item.Right
            //rotation: 0
            anchors.centerIn: tankCannon
            //x: -tankHead.width
        }
*/
        AnimatedImage {
            id: tankHead
            width: 40
            height: 40
            //transformOrigin: Item.Right
            //rotation: 0
            anchors.centerIn: tankCannon
            //x: -tankHead.width
            playing: false
        }

    }

    CircleCollider {
        //collisionTestingOnlyMode: true
        id: circleCollider
        radius: 22
        x: radius
        y: radius
        anchors.centerIn: parent


        density: 0
        friction: 0.4
        restitution: 0.4
        bullet: true
        linearDamping: 100
        //angularDamping: 0

        // this is applied every physics update tick
        linearVelocity: Qt.point(twoAxisController.xAxis * 100, twoAxisController.yAxis * (-100))
        //force: Qt.point(twoAxisController.xAxis * 1000, twoAxisController.yAxis * 1000)
        //torque: 1000
    }

    Image {
        opacity: 0
        id: shield
        width: 60
        height: 60
        //rotation: 0
        anchors.centerIn: parent
        source: "../assets/img/Shield.png"
    }
}

