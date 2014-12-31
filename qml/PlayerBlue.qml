import QtQuick 2.0
import VPlay 2.0
import "."

EntityBase {
    id: playerBlue
    entityId: "playerBlue"
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
    property alias tankBlue: tankBlue

    signal damage();

    Tank {
        id: tankBlue
        x: scene.width / 2
        y: scene.height - 100 - height/2
        z: 1
        entityId: "tank_1"
        rotation: 0
        tankBody.source: "../assets/img/walk.gif"       //"../assets/img/blueBody.png"
        tankHead.source: "../assets/img/shoot.gif"      //"../assets/img/blueHead.png"
    }

    Timer {
        id: timerBlue
        interval: 100; running: true; repeat: true;

        //enable or disable powerUps for 5 seconds
        onTriggered: {
            if (activateShield) {tankBlue.shield.opacity=1}
            if (activateShield==false) {tankBlue.shield.opacity=0}

            //console.log ("activateShield: " + activateShield + " / " + activeShieldCounter)
            if (activateShield) { activeShieldCounter++; }
            if (activeShieldCounter === 80) { activateShield = false; activeShieldCounter = 0; }

            //console.log ("activateAccelerator: " + activateAccelerator + " / " + activeAcceleratorCounter)
            if (activateAccelerator) { activeAcceleratorCounter++; minTimeDistanceBullet = 20; tankBlue.fire.opacity=1}
            if (activeAcceleratorCounter === 80) { activateAccelerator = false; activeAcceleratorCounter = 0; minTimeDistanceBullet = stdTimeDistanceBetweenBullets; tankBlue.fire.opacity=0}

            //console.log ("activatePowershot: " + activatePowershot + " / " + activePowershotCounter)
            if (activatePowershot) { activePowershotCounter++ }
            if (activePowershotCounter === 80) { activatePowershot = false; activePowershotCounter = 0; }

            if (activateHitShield) { activeHitShieldCounter++; tankBlue.opacity = 0.2; }
            if (activeHitShieldCounter === 10) { activateHitShield = false; activeHitShieldCounter = 0; tankBlue.opacity = 1; }
        }
    }

    // gets played when tank shoots
    SoundEffectVPlay {
        volume: 0.3
        id: screamSound
        // an ogg file is not playable on windows, because the extension is not supported!
        source: "../assets/snd/scream.wav"
    }

    function onDamage() {
        if (activateShield || activateHitShield) {
            return
        }

        // decrease life and activate hit shield
        life = life - ((activatePowershot) ? GameInfo.powerDamage : GameInfo.normalDamage)
        activateHitShield = true

        // Play scream sound
        screamSound.play()

        // check if life went below 0
        if (life <= 0) {

            // player Blue lost
            GameInfo.winnerRed = false
            GameInfo.redVictory += true

            // show game over screen
            GameInfo.gamePaused = true
            GameInfo.gameOver = true
            tankRed.circleCollider.linearVelocity = Qt.point(0, 0)
            entityManager.getEntityById("playerBlue").tankBlue.circleCollider.linearVelocity = Qt.point(0, 0)

            var toRemoveEntityTypes = ["powAccelerator", "powLifeUp", "powPowershot", "powShield", "singleBullet", "singleBulletOpponent"];
            entityManager.removeEntitiesByFilter(toRemoveEntityTypes);

            tankRed.tankBody.playing = false
            entityManager.getEntityById("playerBlue").tankBlue.tankBody.playing = false
        }
    }
}
