import QtQuick 2.0
import VPlay 2.0

EntityBase {
    id: ball
    entityType: "ball"

    property alias ballBody: ballBody
    property alias circleCollider: circleCollider

    Image {
        id: ballBody
        width: 50
        height: 50
        //rotation: 0
        anchors.centerIn: parent
    }

    CircleCollider {
        id: circleCollider
        radius: 25
        x: radius
        y: radius

        anchors.centerIn: parent
        friction: 0.5
        restitution: 0.8
        body.bullet: true
        body.linearDamping: 0.5
        body.angularDamping: 0
        density: 0
    }
}
