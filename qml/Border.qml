import QtQuick 2.0
import VPlay 2.0

EntityBase {
    id: borderID
    entityId: "border"
    entityType: "border"
    z: 2000
    //property alias border: border

    /*
    Rectangle {
        anchors.fill: parent
        color: "brown"
        visible: true // set to 'true' for debugging
    }
*/
    Rectangle {
        z: 2000
        anchors.fill: parent
        color: "black"
        visible: true // set to 'true' for debugging
    }
}
