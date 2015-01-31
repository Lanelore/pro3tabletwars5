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
    property alias winnerSound: winnerSound

    signal damage()
    signal damageWithBulletType(var bulletType)

    // gets played when one player wins the match
    SoundEffectVPlay {
        volume: 0.3
        id: winnerSound
        // an ogg file is not playable on windows, because the extension is not supported!
        source: "../assets/snd/Winner.wav"
    }

    Tank {
        id: tankRed
        x: scene.width / 2
        y: 100 + height/2
        z: 1
        entityId: "tank_0"
        rotation: 0
        tankBody.source: "../assets/img/final/RedBody.gif"
        tankHead.source: "../assets/img/final/RedHead.gif"
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

    // gets played when tank shoots
    SoundEffectVPlay {
        volume: 0.3
        id: screamSound1
        // an ogg file is not playable on windows, because the extension is not supported!
        source: "../assets/snd/Injury1.wav"
    }

    // gets played when tank is hurt
    SoundEffectVPlay {
        volume: 0.3
        id: screamSound2
        // an ogg file is not playable on windows, because the extension is not supported!
        source: "../assets/snd/Injury2.wav"
    }

    function onDamage() {
        onDamageWithBulletType(0)
    }

    function scream() {
        var random = Math.floor(Math.random() * 2) + 1 //Sounds 1 - 2
        if (random == 1){
            screamSound1.play()
        }else{
            screamSound2.play()
        }
    }

    function onDamageWithBulletType(bulletType) {
        if (activateHitShield) {
            return
        }

        // decrease life and activate hit shield
        // find out the amount of damage (depends on the bulletType)
        var damage = 0;
        switch (bulletType) {
        case 0:
            // normal bullet
            damage = GameInfo.normalDamage;
            break;

        case 1:
            // powerBullet
            damage = GameInfo.powerDamage;
            break;

        default:
            damage = GameInfo.normalDamage;
            break;
        }

        if (activateShield) {
            damage = damage / 100.0 * (100 - GameInfo.shieldDamageReduction)
        }

        life = life - damage;
        activateHitShield = true


        scream()

        // check if life went below 0
        if (life <= 0) {

            // player Red lost
            GameInfo.winnerRed = false
            GameInfo.blueVictory += 1

            // show game over screen
            winnerSound.play()

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


