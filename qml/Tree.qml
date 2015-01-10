import QtQuick 2.0
import VPlay 2.0
import "."

EntityBase {
    id: tree
    entityType: "tree"
    entityId: "tree"

    property alias treeBody: treeBody
    property alias circleCollider: circleCollider

    Image {
        id: treeBody
        width: 80
        height: 80
        //rotation: 0
        anchors.centerIn: parent
    }

    CircleCollider {
        id: circleCollider
        radius: 40
        x: radius
        y: radius

        anchors.centerIn: parent

        friction: 0
        restitution: 0.0
        body.bullet: true
        body.linearDamping: 0
        body.angularDamping: 0
        //density: 100000000
        bodyType: Body.Static

        // this is applied every physics update tick
        //linearVelocity: Qt.point(twoAxisController.xAxis * 100, twoAxisController.yAxis * (-100))
        //force: Qt.point(twoAxisController.xAxis * 1000, twoAxisController.yAxis * 1000)
        //torque: 1000
    }
}
