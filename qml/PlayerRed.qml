import QtQuick 2.0
import VPlay 2.0
import "."

EntityBase {
    id: playerRed
    entityId: "playerRed"
    entityType: "playerRed"

    property int life: GameInfo.maxEnergy
    property bool activateShield: false // for activating powerUpShield
    property int activeShieldCounter: 0 // count from 0 to 80 every 100 millisecond for the duration of active powerUps
    property bool activateAccelerator: false // for activating powerUpAccelerator
    property int activeAcceleratorCounter: 0 // count from 0 to 80 every 100 millisecond for the duration of active powerUps
    property bool activatePowershot: false // for activating powerUpPowershot
    property int activePowershotCounter: 0 // count from 0 to 80 every 100 millisecond for the duration of active powerUps
    property int stdTimeDistanceBetweenBullets: 500 // standard time distance between two bullets
    property int minTimeDistanceBullet: stdTimeDistanceBetweenBullets // time distance between two bullets
    property bool activateHitShield: false // activate shield for short after a hit
    property int activeHitShieldCounter: 0 // count from 0 to 5 every 100 millisecond for the duration between two bullet-hits

    property var tankRed: tankRed

    Tank {
        id: tankRed
        x: scene.width / 2
        y: 100 + height/2
        z: 1
        entityId: "tank_0"
        rotation: 0
        tankBody.source: "../assets/img/walk.gif"
        tankHead.source: "../assets/img/shoot.gif"
    }

    Timer {
        id: timerRed
        interval: 100; running: true; repeat: true;

        //disable powerUpShield after 5 seconds
        onTriggered: {
            if (activateShield) {tankRed.shield.opacity=1}
            if (activateShield==false) {tankRed.shield.opacity=0}

            //console.log ("activateShield: " + activateShield + " / " + activeShieldCounter)
            if (activateShield) { activeShieldCounter++; }
            if (activeShieldCounter === 80) { activateShield = false; activeShieldCounter = 0; }

            //console.log ("activateAccelerator: " + activateAccelerator + " / " + activeAcceleratorCounter)
            if (activateAccelerator) { activeAcceleratorCounter++; minTimeDistanceBullet = 20; tankRed.fire.opacity=1}
            if (activeAcceleratorCounter === 80) { activateAccelerator = false; activeAcceleratorCounter = 0; minTimeDistanceBullet = stdTimeDistanceBetweenBullets; tankRed.fire.opacity=0}

            //console.log ("activatePowershot: " + activatePowershot + " / " + activePowershotCounter)
            if (activatePowershot) { activePowershotCounter++ }
            if (activePowershotCounter === 80) { activatePowershot = false; activePowershotCounter = 0; }

            if (activateHitShield) { activeHitShieldCounter++; tankRed.opacity = 0.2; }
            if (activeHitShieldCounter === 10) { activateHitShield = false; activeHitShieldCounter = 0; tankRed.opacity = 1; }
        }
    }
}


