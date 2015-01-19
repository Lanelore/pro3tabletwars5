import QtQuick 2.0
import VPlay 2.0
import "levels"
import ".."
import "../qml"

EntityBase {
    id: splat
    entityType: "splat"
    entityId: "splat"

    property alias splatTimer: splatTimer

    Image {
        width: 30
        height: 50
        //anchors.fill: parent
        source: "../assets/img/final/Splat.png"
    }

    onEntityCreated: splatTimer.running= true

    Timer {
        id: splatTimer
        interval: 300
        running: false
        repeat: false

        onTriggered:{
            splat.destroy();
        }
    }
}
