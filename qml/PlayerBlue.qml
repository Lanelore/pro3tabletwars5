import QtQuick 2.0
import VPlay 2.0
import "."

EntityBase {
    id: playerBlue
    entityType: "playerBlue"

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

    Timer {
        id: timerBlue
        interval: 100; running: true; repeat: true;

        //enable or disable powerUps for 5 seconds
        onTriggered: {
            //console.log ("activateShield: " + activateShield + " / " + activeShieldCounter)
            if (activateShield) { activeShieldCounter++; }
            if (activeShieldCounter === 80) { activateShield = false; activeShieldCounter = 0; }

            //console.log ("activateAccelerator: " + activateAccelerator + " / " + activeAcceleratorCounter)
            if (activateAccelerator) { activeAcceleratorCounter++; minTimeDistanceBullet = 20; }
            if (activeAcceleratorCounter === 80) { activateAccelerator = false; activeAcceleratorCounter = 0; minTimeDistanceBullet = stdTimeDistanceBetweenBullets; }

            //console.log ("activatePowershot: " + activatePowershot + " / " + activePowershotCounter)
            if (activatePowershot) { activePowershotCounter++ }
            if (activePowershotCounter === 80) { activatePowershot = false; activePowershotCounter = 0; }

            if (activateHitShield) { activeHitShieldCounter++; tankBlue.opacity = 0.2; }
            if (activeHitShieldCounter === 10) { activateHitShield = false; activeHitShieldCounter = 0; tankBlue.opacity = 1; }
        }
    }
}
