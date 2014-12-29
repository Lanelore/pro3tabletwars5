import QtQuick 2.0

Image {
    id: audio

    // this handler is called when the button is clicked.
    signal clicked
    width: 80
    height: 80
    property bool active: false

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        onClicked: audio.clicked()
    }
}
