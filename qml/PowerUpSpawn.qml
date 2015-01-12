import QtQuick 2.0
import VPlay 2.0
import "levels"
import "."

EntityBase {
    id: powerUpSpawn
    entityType: "powerUpSpawn"

    property alias spawnBody: spawnBody
    property alias circleCollider: circleCollider
    property alias spawnSound: spawnSound

    // gets played when a powerup spawns
    SoundEffectVPlay {
        volume: 0.3
        id: spawnSound
        // an ogg file is not playable on windows, because the extension is not supported!
        source: "../assets/snd/Spawn.wav"
    }

    Image {
        id: spawnBody
        width: 80
        height: 80
        //rotation: 0
        anchors.centerIn: parent
    }

    CircleCollider {
        id: circleCollider
        radius: 40
        x: radius
        y: radius

        anchors.centerIn: parent

        friction: 0
        restitution: 0.0
        body.bullet: true
        body.linearDamping: 0
        body.angularDamping: 0
        //density: 100000000
        bodyType: Body.Static

        // this is applied every physics update tick
        //linearVelocity: Qt.point(twoAxisController.xAxis * 100, twoAxisController.yAxis * (-100))
        //force: Qt.point(twoAxisController.xAxis * 1000, twoAxisController.yAxis * 1000)
        //torque: 1000
    }

    property int timeMin: 8000    //5000    //wait at least 5 sec
    property int timeSpan: 12000    //7000   //spawn between 5 and (5+7) 12 sec
    property int limit: Math.ceil(Math.random() * (timeSpan)+timeMin);

    Timer {
        id: timerGame
        interval: limit;
        running: GameInfo.gamePaused ? false : true;
        repeat: true;

        onTriggered: {
            //spawn items at random times
            limit = Math.ceil(Math.random() * (timeSpan)+timeMin);

            if(GameInfo.powerUpCount<GameInfo.maxPowerUpsOnField){
                console.debug("Limit: " + limit + " | Counter: " + GameInfo.powerUpCount)
                spawnRandomItem()
            }
        }
    }

    function spawnRandomItem(){
        var differentItems= 4
        var randomItem = Math.ceil(Math.random() * (differentItems));

        var randomAngle = Math.ceil(Math.random() * (359));
        var radius = Math.ceil(Math.random() * (20)) + 70;    //between 70 and 140

        var startX= (radius*Math.cos((randomAngle)*Math.PI/180)) + powerUpSpawn.x
        var startY= (radius*Math.sin((randomAngle)*Math.PI/180)) + powerUpSpawn.y

        console.debug("Item: " + randomItem)

        var url
        if(randomItem==1){url = "PowerUpAccelerator.qml"}
        if(randomItem==2){url = "PowerUpLifeUp.qml"}
        if(randomItem==3){url = "PowerUpPowershot.qml"}
        if(randomItem==4){url = "PowerUpShield.qml"}

        spawnSound.play()

        entityManager.createEntityFromUrlWithProperties(
                    Qt.resolvedUrl(url), {
                        "z": 1,
                        "x": startX-25,
                        "y": startY-25,
                        "tankRed": tankRed,
                        "tankBlue": tankBlue,
                        "playerRed": playerRed,
                        "playerBlue": playerBlue,
                    }
        );
    }

    Component {
        id: test
        EntityBase {
            entityType: "test"
            Image {
                id: test2
                width: 20
                height: 20
                //rotation: 0
                anchors.centerIn: parent
                source: "./../assets/img/Ball.png"
            }
        }
    }
}
