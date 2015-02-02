import VPlay 2.0
import QtQuick 2.0
import "../common"
import ".."

SceneBase {
    id: selectLevelScene

    // signal indicating that a level has been selected
    signal levelPressed(string selectedLevel)


    // background
    Image {
        anchors.fill: parent
        source: "../../assets/img/final/BG.png"
    }

    onLevelPressed: {
        GameInfo.powerUpCount=0;
        var toRemoveEntityTypes = ["powAccelerator", "powLifeUp", "powPowershot", "powShield"];
        entityManager.removeEntitiesByFilter(toRemoveEntityTypes);
        GameInfo.redOnLake = false;
        GameInfo.blueOnLake = false;

        GameInfo.currentLevel = selectedLevel
    }

    /*
    // back button to leave scene
    MenuButton {
        text: "Back"
        // anchor the button to the gameWindowAnchorItem to be on the edge of the screen on any device
        anchors.right: selectLevelScene.right
        anchors.rightMargin: 10
        anchors.top: selectLevelScene.top
        anchors.topMargin: 10
        onClicked: {
            GameInfo.redVictory=0
            GameInfo.blueVictory=0
            backPressed()
        }
        buttonText.font.pixelSize: 25
    }
    */

    // back button to leave scene
    MenuButton {
        label.height: 60
        label.width: 60
        label.source: "../../assets/img/final/Back.png"
        color: "transparent"
        z: 10
        anchors.right: parent.right
        anchors.rightMargin: 10
        anchors.verticalCenter: parent.verticalCenter
        onClicked: {
            GameInfo.redVictory=0
            GameInfo.blueVictory=0
            backPressed()}
        buttonText.font.pointSize: 25
    }

    Text {
          id: headerText
          text: "Levels"
          color: "black"
          font.family: standardFont.name
          font.pointSize: 40

          anchors.horizontalCenter: parent.horizontalCenter
          anchors.top: parent.top
          anchors.topMargin: parent.height / 2 - 200
    }

    // levels to be selected
    Grid {
        anchors.centerIn: parent
        spacing: 10
        columns: 5

        Rectangle {
            width: 100
            height: 100
            radius: 12
            color: "white"

            Rectangle {
                width: 86
                height: 86
                anchors.centerIn: parent
                radius: 11
                color: "#54A4BF"

                Rectangle {
                    width: 80
                    height: 80
                    anchors.centerIn: parent
                    radius: 10
                    color: "white"

                    MenuButton {
                        text: "1"
                        width: 50
                        height: 50
                        anchors.top: parent.top
                        anchors.topMargin: 20
                        anchors.horizontalCenter: parent.horizontalCenter
                        buttonText.color: "#54A4BF"
                        buttonText.font.family: standardFont.name
                        onClicked: {
                            levelPressed("Level_01.qml")
                        }
                    }
                }
            }
        }

        Rectangle {
            width: 100
            height: 100
            radius: 12
            color: "white"

            Rectangle {
                width: 86
                height: 86
                anchors.centerIn: parent
                radius: 11
                color: "#54A4BF"

                Rectangle {
                    width: 80
                    height: 80
                    anchors.centerIn: parent
                    radius: 10
                    color: "white"

                    MenuButton {
                        text: "2"
                        width: 50
                        height: 50
                        anchors.top: parent.top
                        anchors.topMargin: 20
                        anchors.horizontalCenter: parent.horizontalCenter
                        buttonText.color: "#54A4BF"
                        buttonText.font.family: standardFont.name
                        onClicked: {
                            levelPressed("Level_02.qml")
                        }
                    }
                }
            }
        }

        Rectangle {
            width: 100
            height: 100
            radius: 12
            color: "white"

            Rectangle {
                width: 86
                height: 86
                anchors.centerIn: parent
                radius: 11
                color: "#54A4BF"

                Rectangle {
                    width: 80
                    height: 80
                    anchors.centerIn: parent
                    radius: 10
                    color: "white"

                    MenuButton {
                        text: "3"
                        width: 50
                        height: 50
                        anchors.top: parent.top
                        anchors.topMargin: 20
                        anchors.horizontalCenter: parent.horizontalCenter
                        buttonText.color: "#54A4BF"
                        buttonText.font.family: standardFont.name
                        onClicked: {
                            levelPressed("Level_03.qml")
                        }
                    }
                }
            }
        }


        Rectangle {
            width: 100
            height: 100
            radius: 12
            color: "white"

            Rectangle {
                width: 86
                height: 86
                anchors.centerIn: parent
                radius: 11
                color: "#54A4BF"

                Rectangle {
                    width: 80
                    height: 80
                    anchors.centerIn: parent
                    radius: 10
                    color: "white"

                    MenuButton {
                        text: "4"
                        width: 50
                        height: 50
                        anchors.top: parent.top
                        anchors.topMargin: 20
                        anchors.horizontalCenter: parent.horizontalCenter
                        buttonText.color: "#54A4BF"
                        buttonText.font.family: standardFont.name
                        onClicked: {
                            levelPressed("Level_04.qml")
                        }
                    }
                }
            }
        }

        Rectangle {
            width: 100
            height: 100
            radius: 12
            color: "white"

            Rectangle {
                width: 86
                height: 86
                anchors.centerIn: parent
                radius: 11
                color: "#54A4BF"

                Rectangle {
                    width: 80
                    height: 80
                    anchors.centerIn: parent
                    radius: 10
                    color: "white"

                    MenuButton {
                        text: "5"
                        width: 50
                        height: 50
                        anchors.top: parent.top
                        anchors.topMargin: 20
                        anchors.horizontalCenter: parent.horizontalCenter
                        buttonText.color: "#54A4BF"
                        buttonText.font.family: standardFont.name
                        onClicked: {
                            levelPressed("Level_05.qml")
                        }
                    }
                }
            }
        }
    }
}

