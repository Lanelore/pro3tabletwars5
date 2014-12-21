pragma Singleton
import QtQuick 2.0
import VPlay 2.0

Item {
    id: gameInfo

    //statistic
    property string winner
    property bool winnerRed: false
    property int redVictory: 0
    property int blueVictory: 0

    //lake
    property bool redOnLake: false
    property bool blueOnLake: false
    property real damping: 10

    //power ups
    property int powerUpCount: 0
    property int maxPowerUpsOnField: 10

    //menu layout
    property color red: "red"
    property color blue: "blue"
    property int border: 4
    property int radius: 10
    property double lighterColor: 1.7       //lighter colors are 70% lighter than normal colors
    property double pacity: 0.3             //because opacity is already taken

    //energy management
    property int maxEnergy: 100
    property int fillEnergy: 25     //extra energy powerup
    property int normalDamage: 25   //tank, opponent, obstacle
    property int powerDamage: 50    //with PowerUp
}
