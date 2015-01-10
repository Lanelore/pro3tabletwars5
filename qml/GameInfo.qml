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
    property bool gameOver: false  //indicates a gameover and shows gameovermessage
    property bool gamePaused: true //freezes the animations, the controls, the opponent and the powerupspawn
                                   //in the beginning while countdown is running and at the gameOver window
    //lake
    property bool redOnLake: false
    property bool blueOnLake: false
    property real damping: 10

    //power ups
    property int powerUpCount: 0
    property int maxPowerUpsOnField: 10
    property int speed: 2                   //for the accelerator powerup, doubles the tank speed
    property int shieldDamageReduction: 65 // percentage of damage reduction when you have the shield powerup

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

    // Controller parameters
    readonly property int onTouchUpdateCounterThreshold: 0 // change this to about 6 to prevent the cannon from changing the angle when shooting

    readonly property int controlType2AngleRange: 50
    readonly property int controlType2Width: 240
    readonly property int controlType2Height: 80

    readonly property int controlType1Width: 180
    readonly property int controlType1Height: 180

    readonly property double maximumPlayerVelocity: 1.4
}
