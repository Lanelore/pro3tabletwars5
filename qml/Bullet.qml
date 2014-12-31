import QtQuick 2.0
import VPlay 2.0
import "levels"
import ".."
import "../qml"


EntityBase {
    id: singleBullet
    entityType: "singleBullet"

    Rectangle {
        width: 10
        height: 10
        //anchors.fill: parent
        color: "#000000"
    }

    property point start
    property point velocity

    x: start.x
    y: start.y

    BoxCollider {
        id: boxCollider

        width: 10
        height: 10
        anchors.fill: parent
        collisionTestingOnlyMode: true

        density: 0
        friction: 0
        restitution: 0
        body.bullet: true
        body.fixedRotation: false // if set to true the physics engine will NOT apply rotation to it

        // handle the collision
        fixture.onBeginContact: {
            /*
            var fixture = other;
            var body = other.parent;
            var component = other.parent.parent;

            var collidingType = component.owningEntity.entityType;

            if(collidingType === "car" ||
                    collidingType === "rocket") {
                entity.removeEntity();
                return;
            }


            */


            var fixture = other;
            var body = other.parent;
            var component = other.parent.parent;

            console.log("body.entityId: " + component.entityId);
            console.log("component.entityId: " + component.entityId);
            console.log("component.parent.entityId: " + component.parent.entityId); // tank_1
            console.log("Component.parent.parent.entityId: " + component.parent.parent.entityId); // playerRed / playerBlue

            var otherEntity = component.parent;
            var otherEntityId = component.parent.entityId;
            var otherEntityParent = otherEntity.parent;

            // destroy the bullet it it collided with anything but lake or powerup
            if (otherEntityId.substring(0, 3) !== "lak" || otherEntityId.substring(0, 3) !== "pow") {
                console.log("bullet collides with: " + otherEntityId);
                singleBullet.destroy();
            }

            if (otherEntityParent.entityId.substring(0, 6) === "player") {
                if (!otherEntityParent.activateShield && !otherEntityParent.activateHidShield) {

                    // decrease life and activate hit shield
                    otherEntityParent.life = otherEntityParent.life - ((otherEntityParent.activatePowershot) ? GameInfo.powerDamage : GameInfo.normalDamage)
                    otherEntityParent.activateHitShield = true

                    // play scream sound
                    screamSound.play();

                    // check if life went below 0
                    if (otherEntityParent.life <= 0) {

                        // check who won
                        if (otherEntityParent.entityId === "playerRed") {
                            // playerRed lost
                            GameInfo.winnerRed = false
                            GameInfo.blueVictory += 1
                        } else {
                            // playerBlue lost
                            GameInfo.winnerRed = true
                            GameInfo.redVictory += 1
                        }



                        GameInfo.gamePaused = true
                        GameInfo.gameOver = true
                        entityManager.getEntityById("playerRed").tankRed.circleCollider.linearVelocity = Qt.point(0, 0)
                        entityManager.getEntityById("playerBlue").tankBlue.circleCollider.linearVelocity = Qt.point(0, 0)

                        var toRemoveEntityTypes = ["powAccelerator", "powLifeUp", "powPowershot", "powShield", "singleBullet", "singleBulletOpponent"];
                        entityManager.removeEntitiesByFilter(toRemoveEntityTypes);

                        entityManager.getEntityById("playerRed").tankRed.tankBody.playing = false
                        entityManager.getEntityById("playerBlue").tankBlue.tankBody.playing = false
                    }
                }
            }


/*
            var collidedEntity = other.parent.parent.parent;

            //                    console.log("bullet collides with tank or something else:" + singleBullet.entityId + " / " + collidedEntity.entityId)

            //   if(tankRed.entityId !== collidedEntity.entityId &&
            //   tankBlue.entityId !== collidedEntity.entityId &&
            //   collidedEntity.entityId !== "lake"){

            var str = collidedEntity.entityId;
            var resId = str.substring(0, 3);
            // destroy bullet on collision with any component except lake and powerUpIcons
            if(resId !== "lak" && resId !== "pow"){
                console.log("bullet collides with:" + singleBullet.entityId + " / " + collidedEntity.entityId + " / " + resId)
                singleBullet.destroy()
            }

            if(tankRed.entityId===collidedEntity.entityId){
                if(!playerRed.activateShield && !playerRed.activateHitShield) {
                    playerRed.life = playerRed.life - ((playerBlue.activatePowershot) ? GameInfo.powerDamage : GameInfo.normalDamage)
                    playerRed.activateHitShield = true
                    damage()
                }
            } else if(tankBlue.entityId===collidedEntity.entityId){
                if(!playerBlue.activateShield && !playerBlue.activateHitShield) {
                    playerBlue.life = playerBlue.life - ((playerRed.activatePowershot) ? GameInfo.powerDamage : GameInfo.normalDamage)
                    playerBlue.activateHitShield = true
                    damage()
                }
            }
            */
        }
    }

    MovementAnimation {
        target: singleBullet

        property: "x"
        velocity: singleBullet.velocity.x
        running: true
    }

    MovementAnimation {
        target: singleBullet

        property: "y"
        velocity: singleBullet.velocity.y
        running: true
        onStopped: {
            singleBullet.destroy()
        }
    }

    // gets played when tank shoots
    SoundEffectVPlay {
        volume: 0.3
        id: screamSound
        // an ogg file is not playable on windows, because the extension is not supported!
        source: "../assets/snd/scream.wav"
    }
}
