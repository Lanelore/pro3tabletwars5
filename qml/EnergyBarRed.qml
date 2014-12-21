import QtQuick 2.0
import VPlay 2.0
import "."

EntityBase {
    id: energyBarBlue
    entityType: "energyBarBlue"
    z: 1

    property alias energyBarOuterBody: energyBarOuterBody
    property alias energyBarInnerBody: energyBarInnerBody
    property int energy
    property color barColor: GameInfo.red
    property int gap: GameInfo.border

    width: 150
    height: 30

    opacity: GameInfo.pacity

    Rectangle {
        border.width: gap
        border.color: barColor
        id: energyBarOuterBody
        anchors.fill: parent
        color: Qt.lighter(barColor, GameInfo.lighterColor)
        radius: GameInfo.radius
        Rectangle {
            radius: parent.radius-3
            id: energyBarInnerBody
            width: (parent.width/100*energy)-(gap*3)
            height: parent.height-(gap*3)

            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: gap*1.5

            gradient: Gradient {
                    GradientStop { position: 0.0; color: Qt.lighter(barColor, 1.2) }
                    GradientStop { position: 1.0; color: barColor }
                }
        }
        onEnabledChanged: console.debug("Energie: " + energy)
    }
}
