import QtQuick 2.0
import VPlay 2.0
import "../common" as Common
import ".."

Common.LevelBase {
    id: scene
    state: "0"


    property alias playerMovementControlAreaRed: playerMovementControlAreaRed
    property alias playerMovementControlAreaBlue: playerMovementControlAreaBlue
    property alias playerRed: playerRed
    property alias playerBlue: playerBlue
    property alias nailSound: nailSound
    property alias tankRed: playerRed.tankRed
    property alias tankBlue: playerBlue.tankBlue

    //TODO
    focus: true

    // gets played when tank shoots
    SoundEffectVPlay {
        volume: 0.3
        id: nailSound
        // an ogg file is not playable on windows, because the extension is not supported!
        source: "../../assets/snd/nailgun.wav"
    }

    PlayerRed {
        id: playerRed
        z: 1
    }

    PlayerBlue {
        id: playerBlue
        z: 1
    }


    // ---------------------------------------------------
    // Controller tankRed
    // ---------------------------------------------------
    onRedOffLake: {
        if(GameInfo.redOnLake==false && playerRed.tankRed.tankBody.playing==false){
            playerRed.tankRed.circleCollider.linearDamping=GameInfo.damping
        }
    }

    Rectangle {
        // Object properties
        id: playerMovementControlAreaRed
        width: 180
        height: 180
        x: 50
        y: 50
        z: 1000
        radius: width / 2//GameInfo.radius
        opacity: GameInfo.pacity
        color: Qt.lighter(GameInfo.red, GameInfo.lighterColor)
        border.width: GameInfo.border
        border.color: GameInfo.red

        MultiPointTouchArea {
            enabled: GameInfo.gamePaused ? false : true
            anchors.fill: parent
            property variant playerTwoAxisController: playerRed.tankRed.getComponent("TwoAxisController")     // Touch Methods
            property real newPosX: 0.0
            property real newPosY: 0.0

            property real oldPosX: 0.0
            property real oldPosY: 0.0

            touchPoints: [
                TouchPoint {id: pointCtrlRed}
            ]

            onReleased: {
                playerRed.tankRed.tankBody.playing=false
                damping()
            }

            onUpdated: {
                // reset playing and linear damping (indicates that player is moving)
                playerRed.tankRed.circleCollider.linearDamping=0
                playerRed.tankRed.tankBody.playing=true

                newPosX = (pointCtrlRed.x / (parent.width / 2) - 1)
                newPosY = (pointCtrlRed.y / (parent.height / 2) - 1)

                newPosY = newPosY * -1

                if (newPosX > 1) newPosX = 1
                if (newPosY > 1) newPosY = 1
                if (newPosX < -1) newPosX = -1
                if (newPosY < -1) newPosY = -1

                // if it is on the lake calculate it in a special way!
                if(GameInfo.redOnLake){
                    console.log("X old: " + oldPosX + " | new: " + newPosX)
                    console.log("Y old: " + oldPosY + " | new: " + newPosY)
                    newPosX = oldPosX+(newPosX*0.03)
                    newPosY = oldPosY+(newPosY*0.03)

                    if (newPosX > 1) newPosX = 1
                    if (newPosY > 1) newPosY = 1
                    if (newPosX < -1) newPosX = -1
                    if (newPosY < -1) newPosY = -1
                }

                // If the player is not touching the control area, slowly stop the body!
                if(playerRed.tankRed.tankBody.playing==false) damping()

                // update the movement
                updateMovement()
            }

            function damping(){
                if(GameInfo.redOnLake==false){
                    playerRed.tankRed.circleCollider.linearDamping=GameInfo.damping
                }
            }

            function updateMovement(){
                // store the x and y values before they'll be altered
                oldPosX=newPosX
                oldPosY=newPosY

                // Adjust the speed
                newPosX = newPosX * GameInfo.maximumPlayerVelocity
                newPosY = newPosY * GameInfo.maximumPlayerVelocity

                /* normalise the speed! when driving diagonally the x and y speed is both 1
                    when driving horizontally only either x or y is 1, which results in slower horizontal/vercial speed than diagonal speed
                    so shrink x and y about the same ratio down so that their maximum speed will be 1 (or whatever specified) */

                // calculate the distance from the center ( = speed)
                var velocity = Math.sqrt(newPosX * newPosX + newPosY * newPosY)
                var maxVelocity = GameInfo.maximumPlayerVelocity
                if (playerRed.activateAccelerator){
                    maxVelocity*= GameInfo.speed
                    newPosX *= GameInfo.speed
                    newPosY *= GameInfo.speed
                }
                if (velocity > maxVelocity) {
                    // velocity is too high! shrink it down
                    var shrinkFactor = maxVelocity / velocity
                    newPosX = newPosX * shrinkFactor
                    newPosY = newPosY * shrinkFactor
                }

                // now update the twoAxisController with the calculated values
                playerTwoAxisController.xAxis = newPosX
                playerTwoAxisController.yAxis = newPosY

                var angle = calcAngle(newPosX, newPosY) - 90

                if (newPosX!=0 && newPosY != 0){
                    playerRed.tankRed.tankBody.rotation = angle
                    playerRed.tankRed.circleCollider.rotation = angle
                    //playerRed.tankRed.tankCannon.rotation = playerRed.tankRed.tankBody.rotation + playerRed.tankRed.cannonAngle + 90 // used for ControlType2
                }
            }
        }
    }






    // ------------------------------------
    // Cannon Controller Player Red
    // ------------------------------------
    Rectangle {
        // Object properties
        id: playerBulletControlAreaRed

        radius: GameInfo.radius
        opacity: GameInfo.pacity
        color: Qt.lighter(GameInfo.red, GameInfo.lighterColor)
        border.width: GameInfo.border
        border.color: GameInfo.red

        width: GameInfo.controlType1Width
        height: GameInfo.controlType1Height
        x: scene.width - GameInfo.controlType1Width - 50
        y: 50
        z: 1000

        MultiPointTouchArea {
            enabled: GameInfo.gamePaused ? false : true
            anchors.fill: parent

            property bool rotateOnce: true
            property bool pressBool: false // becomes true when a touch-cycle starts
            property var lastTime: 0 // stores the last time a bullet was shot
            //*// property var touchStartTime: 0 // will store the start-time of a touch-cycle
            //*// property int onTouchUpdatedCounter: 0 // counts how often the onTouchUpdatedCounter has been called for a touch-cycle
            property variant playerTwoAxisController: playerRed.tankRed.getComponent("TwoAxisController")

            touchPoints: [
                TouchPoint {id: point1}
            ]

            /*
            onUpdated: {
                console.log("--------onTouchUpdated");
                onTouchUpdatedCounter += 1

                // only update the cannon when the user really swiped, a single touch shouldn't update the cannon angle
                if (onTouchUpdatedCounter >= GameInfo.onTouchUpdateCounterThreshold) { // change this number to '6' to only shoot when a Tap occured!
                    upDateCannon()
                }
            }
            */

            onTouchUpdated: upDateCannon()

            onPressed: {
                //*//console.log("--------onPressed");
                pressBool= true
                //*//touchStartTime = new Date().getTime()
                upDateCannon()
            }

            onReleased: {
                //console.log("--------onReleased");
                upDateCannon()
                var currentTime = new Date().getTime()
                var timeDiff = currentTime - lastTime
                //*//var touchReleaseTime = currentTime - touchStartTime
                //*//console.log("---------timeDiff: " + timeDiff + ", touchReleaseTime: " + touchReleaseTime + ", minTimeDistanceBullet: " + playerRed.minTimeDistanceBullet);

                if (pressBool && timeDiff > playerRed.minTimeDistanceBullet) {
                    nailSound.play();
                    playerRed.tankRed.tankHead.playing=true

                    lastTime = currentTime

                    //console.debug("Shoot Cannon")


                    var speed = (playerRed.activateAccelerator) ? 500 : 250

                    var xDirection = Math.cos(playerRed.tankRed.tankCannon.rotation * Math.PI / 180.0) * speed
                    var yDirection = Math.sin(playerRed.tankRed.tankCannon.rotation * Math.PI / 180.0) * speed

                    var startX= (45*Math.cos((playerRed.tankRed.tankCannon.rotation)*Math.PI/180)) + playerRed.tankRed.x + playerRed.tankRed.width/2
                    var startY= (45*Math.sin((playerRed.tankRed.tankCannon.rotation)*Math.PI/180)) + playerRed.tankRed.y + playerRed.tankRed.height/2

                    // create and remove entities at runtime
                    entityManager.createEntityFromUrlWithProperties(Qt.resolvedUrl("../Bullet.qml"), {
                                                                        "start" : Qt.point(startX, startY),
                                                                        "velocity" : Qt.point(xDirection, yDirection),
                                                                        "bulletType" : playerRed.activatePowershot ? 1 : 0});


                }
                pressBool= false
                //*//onTouchUpdatedCounter = 0
            }

            function upDateCannon(){
                // point1.x range: 0 - playerBulletControlAreaRed.width
                //console.log("touchpoint.x: " + point1.x)

                // ControlType2
                /*
                var b = point1.x - (playerBulletControlAreaRed.width / 2)
                var m = playerBulletControlAreaRed.width / 2 / GameInfo.controlType2AngleRange
                var angle = b / m * (-1)
                angle = Math.max(angle, -GameInfo.controlType2AngleRange)
                angle = Math.min(angle, GameInfo.controlType2AngleRange)
                console.log("b: " + b + ", m: " + m + ", angle: " + angle)
                playerRed.tankRed.cannonAngle = angle
                playerRed.tankRed.tankCannon.rotation = playerRed.tankRed.tankBody.rotation + playerRed.tankRed.cannonAngle + 90
                */

                // ControlType1
                var x = point1.x
                var y = point1.y
                x = x - (playerBulletControlAreaRed.width / 2)
                y = (y - (playerBulletControlAreaRed.height / 2)) * (-1)
                var angle = calcAngle(x, y)
                playerRed.tankRed.tankCannon.rotation = angle
            }

            onEnabledChanged: {
                if(rotateOnce){
                    playerRed.tankRed.tankCannon.rotation = 90
                    rotateOnce = false
                }
            }
        }
    }





    // ---------------------------------------------------
    // Controller tankBlue
    // ---------------------------------------------------
    onBlueOffLake: {
        if(GameInfo.blueOnLake==false && playerBlue.tankBlue.tankBody.playing==false){
            playerBlue.tankBlue.circleCollider.linearDamping=GameInfo.damping
        }else{
            playerBlue.tankBlue.circleCollider.linearDamping=0
        }
    }

    Rectangle {
        // Object properties
        id: playerMovementControlAreaBlue
        width: 180
        height: 180
        x: scene.width - 230
        y: scene.height - 230
        z: 1000

        radius: width / 2 //GameInfo.radius
        opacity: GameInfo.pacity
        color: Qt.lighter(GameInfo.blue, GameInfo.lighterColor)
        border.width: GameInfo.border
        border.color: GameInfo.blue

        MultiPointTouchArea {
            enabled: GameInfo.gamePaused ? false : true
            anchors.fill: parent
            property variant playerTwoAxisController: playerBlue.tankBlue.getComponent("TwoAxisController")     // Touch Methods
            property real newPosX: 0.0
            property real newPosY: 0.0
            property bool rotateOnce: true

            property real oldPosX: 0.0
            property real oldPosY: 0.0

            touchPoints: [
                TouchPoint {id: pointCtrlBlue}
            ]

            onEnabledChanged: {
                if(rotateOnce){
                    playerBlue.tankBlue.tankBody.rotation = 180
                    playerBlue.tankBlue.circleCollider.rotation = 180
                    rotateOnce = false
                }
            }

            onReleased: {
                playerBlue.tankBlue.tankBody.playing=false
                damping()
            }

            onUpdated: {
                // reset playing and linear damping (indicates that player is moving)
                playerBlue.tankBlue.circleCollider.linearDamping=0
                playerBlue.tankBlue.tankBody.playing=true

                newPosX = (pointCtrlBlue.x / (parent.width / 2) - 1)
                newPosY = (pointCtrlBlue.y / (parent.height / 2) - 1)

                newPosY = newPosY * -1

                if (newPosX > 1) newPosX = 1
                if (newPosY > 1) newPosY = 1
                if (newPosX < -1) newPosX = -1
                if (newPosY < -1) newPosY = -1

                // if it is on the lake calculate it in a special way!
                if(GameInfo.blueOnLake){
                    console.log("X old: " + oldPosX + " | new: " + newPosX)
                    console.log("Y old: " + oldPosY + " | new: " + newPosY)
                    newPosX = oldPosX+(newPosX*0.03)
                    newPosY = oldPosY+(newPosY*0.03)

                    if (newPosX > 1) newPosX = 1
                    if (newPosY > 1) newPosY = 1
                    if (newPosX < -1) newPosX = -1
                    if (newPosY < -1) newPosY = -1
                }

                // if the player is not touching the control area, slowly stop the body!
                if(playerBlue.tankBlue.tankBody.playing==false) damping()

                // update the movement
                updateMovement()
            }

            function damping(){
                if(GameInfo.blueOnLake==false){
                    playerBlue.tankBlue.circleCollider.linearDamping=GameInfo.damping
                }
            }

            function updateMovement(){
                // store the x and y values before they'll be altered
                oldPosX=newPosX
                oldPosY=newPosY

                // Adjust the speed
                newPosX = newPosX * GameInfo.maximumPlayerVelocity
                newPosY = newPosY * GameInfo.maximumPlayerVelocity

                /* normalise the speed! when driving diagonally the x and y speed is both 1
                    when driving horizontally only either x or y is 1, which results in slower horizontal/vercial speed than diagonal speed
                    so shrink x and y about the same ratio down so that their maximum speed will be 1 (or whatever specified) */

                // Calculate the distance from the center ( = speed)
                var velocity = Math.sqrt(newPosX * newPosX + newPosY * newPosY)

                //maxVelocity and speed depending on the accelerator powerup
                var maxVelocity = GameInfo.maximumPlayerVelocity
                if (playerBlue.activateAccelerator){
                    maxVelocity*= GameInfo.speed
                    newPosX *= GameInfo.speed
                    newPosY *= GameInfo.speed
                }
                if (velocity > maxVelocity) {
                    // velocity is too high! shrink it down
                    var shrinkFactor = maxVelocity / velocity
                    newPosX = newPosX * shrinkFactor
                    newPosY = newPosY * shrinkFactor
                }

                // now update the twoAxisController with the calculated values
                playerTwoAxisController.xAxis = newPosX
                playerTwoAxisController.yAxis = newPosY


                var angle = calcAngle(newPosX, newPosY) - 90

                if (newPosX!=0 && newPosY != 0){
                    playerBlue.tankBlue.tankBody.rotation = angle
                    playerBlue.tankBlue.circleCollider.rotation = angle
                    //playerBlue.tankBlue.tankCannon.rotation = playerBlue.tankBlue.tankBody.rotation + playerBlue.tankBlue.cannonAngle + 90 // used for ControlType2
                }
            }
        }
    }


    // ---------------------------------------------------
    // Controller blueTankCannon
    // ---------------------------------------------------
    Rectangle {
        // Object properties
        id: playerBulletControlAreaBlue

        radius: GameInfo.radius
        opacity: GameInfo.pacity
        color: Qt.lighter(GameInfo.blue, GameInfo.lighterColor)
        border.width: GameInfo.border
        border.color: GameInfo.blue

        width: GameInfo.controlType1Width
        height: GameInfo.controlType1Height
        x: 50
        y: scene.height - GameInfo.controlType1Height - 50
        z: 1000

        MultiPointTouchArea {
            enabled: GameInfo.gamePaused ? false : true
            anchors.fill: parent

            property bool rotateOnce: true
            property bool pressBool: true
            property var lastTime: 0
            property var touchStartTime: 0
            property int onTouchUpdatedCounter: 0
            property var playerTwoAxisController: playerBlue.tankBlue.getComponent("TwoAxisController")

            touchPoints: [
                TouchPoint {id: point2}
            ]

            /*
            onUpdated: {
                console.log("--------onTouchUpdated");
                onTouchUpdatedCounter += 1

                // only update the cannon when the user really swiped, a single touch shouldn't update the cannon angle
                if (onTouchUpdatedCounter >= GameInfo.onTouchUpdateCounterThreshold) { // change this number to '6' to only shoot when a Tap o.ccured!
                    upDateCannon()
                }
            }
            */
            onTouchUpdated: upDateCannon()

            onPressed: {
                //*//console.log("--------onPressed");
                pressBool= true
                //*//touchStartTime = new Date().getTime()
                upDateCannon()
            }

            onReleased: {
                upDateCannon()
                //console.log("---------onReleased")
                var currentTime = new Date().getTime()
                var timeDiff = currentTime - lastTime
                //var touchReleaseTime = currentTime - touchStartTime
                //console.log("---------timeDiff: " + timeDiff + ", touchReleaseTime: " + touchReleaseTime + ", minTimeDistanceBullet: " + playerRed.minTimeDistanceBullet);

                if (pressBool && timeDiff > playerBlue.minTimeDistanceBullet) {
                    nailSound.play();
                    playerBlue.tankBlue.tankHead.playing=true

                    lastTime = currentTime

                    //console.debug("Shoot Cannon")

                    var speed = (playerBlue.activateAccelerator) ? 500 : 250

                    var xDirection = Math.cos(playerBlue.tankBlue.tankCannon.rotation * Math.PI / 180.0) * speed
                    var yDirection = Math.sin(playerBlue.tankBlue.tankCannon.rotation * Math.PI / 180.0) * speed

                    var startX= (45*Math.cos((playerBlue.tankBlue.tankCannon.rotation)*Math.PI/180)) + playerBlue.tankBlue.x + playerBlue.tankBlue.width / 2
                    var startY= (45*Math.sin((playerBlue.tankBlue.tankCannon.rotation)*Math.PI/180)) + playerBlue.tankBlue.y + playerBlue.tankBlue.height / 2

                    // create and remove entities at runtime
                    //*//console.log("activatepowershot: " + playerBlue.activatePowershot)
                    entityManager.createEntityFromUrlWithProperties(Qt.resolvedUrl("../Bullet.qml"), {
                                                                        "start" : Qt.point(startX, startY),
                                                                        "velocity" : Qt.point(xDirection, yDirection),
                                                                        "bulletType" : playerBlue.activatePowershot ? 1 : 0})
                }
                pressBool= false
                //*//onTouchUpdatedCounter = 0
            }

            function upDateCannon(){
                // point1.x range: 0 - playerBulletControlAreaRed.width
                //*//console.log("touchpoint.x: " + point2.x)

                // ControlType2
                /*
                var b = point2.x - (playerBulletControlAreaBlue.width / 2)
                var m = playerBulletControlAreaBlue.width / 2 / GameInfo.controlType2AngleRange
                var angle = b / m
                angle = Math.max(angle, -GameInfo.controlType2AngleRange)
                angle = Math.min(angle, GameInfo.controlType2AngleRange)
                console.log("b: " + b + ", m: " + m + ", angle: " + angle)
                playerBlue.tankBlue.cannonAngle = angle
                playerBlue.tankBlue.tankCannon.rotation = playerBlue.tankBlue.tankBody.rotation + playerBlue.tankBlue.cannonAngle + 90
                */

                // ControlType1

                var x = point2.x
                var y = point2.y
                x = x - (playerBulletControlAreaBlue.width / 2)
                y = (y - (playerBulletControlAreaBlue.height / 2)) * (-1)

                var angle = calcAngle(x, y)
                playerBlue.tankBlue.tankCannon.rotation = angle

            }

            onEnabledChanged: {
                if(rotateOnce){
                    playerBlue.tankBlue.tankCannon.rotation = 270
                    rotateOnce = false
                }
            }
        }
    }

    EnergyBarRed {
        energy: playerRed.life
        z:1
        id: energyBarRed
        anchors {
            horizontalCenter: scene.horizontalCenter
            top: scene.top
            topMargin: 50
        }
    }

    EnergyBarBlue {
        energy: playerBlue.life
        z:1
        id: energyBarBlue
        anchors {
            horizontalCenter: scene.horizontalCenter
            bottom: scene.bottom
            bottomMargin: 50
        }
    }

    // energy tankred
    Text {
        z:1
        //anchors.: parent.horizontalCenter
        //anchors.top: gameScene.gameWindowAnchorItem.top
        //anchors.ce
        //anchors.topMargin: 80
        opacity: GameInfo.pacity
        color: GameInfo.red
        font.pixelSize: 40
        text: playerRed.life

        anchors {
            horizontalCenter: scene.horizontalCenter
            //right: parent.right
            top: scene.top
            topMargin: 90
        }
    }

    // energy tankBlue
    Text {
        z:1
        //anchors.left: parent.horizontalCenter
        //anchors.bottom: gameScene.gameWindowAnchorItem.bottom
        //anchors.topMargin: 80
        opacity: GameInfo.pacity
        color: GameInfo.blue
        font.pixelSize: 40
        text: playerBlue.life

        anchors {
            horizontalCenter: scene.horizontalCenter
            //right: parent.right
            bottom: scene.bottom
            bottomMargin: 90  //30
        }
    }



    /*
    Text {
        z :1
        anchors.centerIn: parent
        color: "green"
        font.pixelSize: 50
        text: playerRed.life<=0 || playerBlue.life<=0 ? "Game Over" : ""
    }
    */

    function calcAngle(touchX, touchY) {
        //console.log("calcAngle: " + (-180 / Math.PI * Math.atan2(touchY, touchX)))
        return -180 / Math.PI * Math.atan2(touchY, touchX)
    }

    /*
      not needed anymore! is now included in Bullet.qml
    onDamage: {
        screamSound.play();

        if (playerRed.life<=0){
            GameInfo.winnerRed=false
            GameInfo.blueVictory+=1
        }
        if (playerBlue.life<=0){
            GameInfo.winnerRed=true
            GameInfo.redVictory+=1
        }
        if (playerRed.life<=0||playerBlue.life<=0){
            GameInfo.gamePaused = true
            GameInfo.gameOver=true
            playerRed.tankRed.circleCollider.linearVelocity=Qt.point(0,0)
            playerBlue.tankBlue.circleCollider.linearVelocity=Qt.point(0,0)
            var toRemoveEntityTypes = ["powAccelerator", "powLifeUp", "powPowershot", "powShield", "singleBullet", "singleBulletOpponent"];
            entityManager.removeEntitiesByFilter(toRemoveEntityTypes);
            playerRed.tankRed.tankBody.playing=false
            playerBlue.tankBlue.tankBody.playing=false
        }
    }
    */
}








// ---------------------------------------------------
// Joystick Controller tankRed
// ---------------------------------------------------
//    JoystickControllerHUD {
//        id: joystickRed
//        width: 180
//        height: 180
//        x: 50
//        y: 50
//        z: 5

//        Rectangle {
//            id: cannonControlArea
//            anchors.fill: parent
//            color: "#aaaaaa"
//            opacity: 0.3
//            z: 5
//        }

//        // delete the default images
//        source: ""
//        thumbSource: ""

//        // Touch Methods
//        property var playerTwoAxisController: tankRed.getComponent("TwoAxisController")

//        onControllerXPositionChanged: {
//            playerTwoAxisController.xAxis = controllerXPosition
//            var angle = calcAngle(controllerXPosition, controllerYPosition) - 90
//            if (controllerXPosition!=0 && controllerYPosition != 0){
//                tankRed.tankBody.rotation = angle
//                tankRed.circleCollider.rotation = angle
//            }
//        }

//        onControllerYPositionChanged: {
//            playerTwoAxisController.yAxis = controllerYPosition
//            var angle = calcAngle(controllerXPosition, controllerYPosition) - 90
//            if (controllerXPosition!=0 && controllerYPosition != 0){
//                tankRed.tankBody.rotation = angle
//                tankRed.circleCollider.rotation = angle
//            }
//        }
//    }

// ---------------------------------------------------
// Controller redTankCannon
// ---------------------------------------------------
/*
    JoystickControllerHUD {
        width: 180
        height: 180
        x: scene.width - 230
        y: 50

        Rectangle {
            anchors.fill: parent
            color: "#aaaaaa"
            opacity: 0.3
        }

        // delete the default images
        source: ""
        thumbSource: ""

        property var playerTwoAxisController: tankRed.getComponent("TwoAxisController")
        onControllerXPositionChanged: {
            var angle = calcAngle(controllerXPosition, controllerYPosition)
            if (controllerXPosition!=0 && controllerYPosition != 0){
                tankRed.tankCannon.rotation = angle
            }
        }

        onControllerYPositionChanged: {
            var angle = calcAngle(controllerXPosition, controllerYPosition)
            if (controllerXPosition!=0 && controllerYPosition != 0){
                tankRed.tankCannon.rotation = angle
            }
        }




{
            interval: 500; running: true; repeat: true;

            onTriggered: {
                var speed = 250
                var xDirection = Math.cos(tankRed.tankCannon.rotation * Math.PI / 180.0) * speed
                var yDirection = Math.sin(tankRed.tankCannon.rotation * Math.PI / 180.0) * speed

                // create and remove entities at runtime
                entityManager.createEntityFromComponentWithProperties(
                            bullet, {
                                start: Qt.point(tankRed.x, tankRed.y + 35),
                                velocity: Qt.point(xDirection, yDirection)
                            });
            }
        }
    }
*/


//    JoystickControllerHUD {
//        rotation: 0
//        id: joystickBlue
//        width: 180
//        height: 180
//        x: scene.width - 230
//        y: scene.height - 230
//        z: 5

//        Rectangle {
//            anchors.fill: parent
//            color: "#aaaaaa"
//            opacity: 0.3
//            z: 5
//        }

//        // delete the default images
//        source: ""
//        thumbSource: ""

//        property var playerTwoAxisController: tankBlue.getComponent("TwoAxisController")

//        onControllerXPositionChanged: {
//            console.debug("controllerXPosition-Blue = " + controllerXPosition)
//            playerTwoAxisController.xAxis = controllerXPosition
//            var angle = calcAngle(controllerXPosition, controllerYPosition)
//            if (controllerXPosition!=0 && controllerYPosition != 0){
//                tankBlue.tankBody.rotation = angle +90
//                tankBlue.circleCollider.rotation = angle +90
//            }
//        }

//        onControllerYPositionChanged: {
//            console.debug("controllerYPosition-Blue = " + controllerYPosition)
//            playerTwoAxisController.yAxis = controllerYPosition
//            var angle = calcAngle(controllerXPosition, controllerYPosition)
//            if (controllerXPosition!=0 && controllerYPosition != 0){
//                tankBlue.tankBody.rotation = angle +90
//                tankBlue.circleCollider.rotation = angle +90
//            }
//        }

//    }
