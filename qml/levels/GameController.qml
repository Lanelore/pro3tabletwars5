import QtQuick 2.0
import VPlay 2.0
import "../common" as Common
import ".."

Common.LevelBase {
    id: scene
    state: "0"

    //property alias playerMovementControlAreaRed: playerMovementControlAreaRed
    //property alias playerMovementControlAreaBlue: playerMovementControlAreaBlue

    property alias redField: redField

    property alias playerRed: playerRed
    property alias playerBlue: playerBlue
    property alias snowballSound1: snowballSound1
    property alias snowballSound2: snowballSound2
    property alias snowballSound3: snowballSound3
    property alias icicleSound1: icicleSound1
    property alias icicleSound2: icicleSound2
    property alias icicleSound3: icicleSound3
    property alias tankRed: playerRed.tankRed
    property alias tankBlue: playerBlue.tankBlue

    //TODO
    focus: true

    // gets played when tank shoots a normal bullet
    SoundEffectVPlay {
        volume: 0.3
        id: snowballSound1
        // an ogg file is not playable on windows, because the extension is not supported!
        source: "../../assets/snd/Snow1.wav"
    }

    // gets played when tank shoots a normal bullet
    SoundEffectVPlay {
        volume: 0.3
        id: snowballSound2
        // an ogg file is not playable on windows, because the extension is not supported!
        source: "../../assets/snd/Snow2.wav"
    }

    // gets played when tank shoots a normal bullet
    SoundEffectVPlay {
        volume: 0.3
        id: snowballSound3
        // an ogg file is not playable on windows, because the extension is not supported!
        source: "../../assets/snd/Snow3.wav"
    }

    // gets played when tank shoots a strong bullter
    SoundEffectVPlay {
        volume: 0.3
        id: icicleSound1
        // an ogg file is not playable on windows, because the extension is not supported!
        source: "../../assets/snd/Icicle1.wav"
    }

    // gets played when tank shoots a strong bullter
    SoundEffectVPlay {
        volume: 0.3
        id: icicleSound2
        // an ogg file is not playable on windows, because the extension is not supported!
        source: "../../assets/snd/Icicle2.wav"
    }

    // gets played when tank shoots a strong bullter
    SoundEffectVPlay {
        volume: 0.3
        id: icicleSound3
        // an ogg file is not playable on windows, because the extension is not supported!
        source: "../../assets/snd/Icicle3.wav"
    }

    function snowball() {
        var random = Math.floor(Math.random() * 3) + 1 //Sounds 1 - 3

        if (random==1) snowballSound1.play()
        if (random==2) snowballSound2.play()
        if (random==3) snowballSound3.play()
    }

    function icicle() {
        var random = Math.floor(Math.random() * 3) + 1 //Sounds 1 - 3
        if (random==1) icicleSound1.play()
        if (random==2) icicleSound2.play()
        if (random==3) icicleSound3.play()
    }

    PlayerRed {
        id: playerRed
        z: 1
    }

    PlayerBlue {
        id: playerBlue
        z: 1
    }

    // ------------------------------------
    // Red Field
    // ------------------------------------
    Rectangle {
        // Object properties
        id: redField
        radius: GameInfo.radius
        opacity: GameInfo.pacity
        color: "transparent"
        //border.width: GameInfo.border
        //border.color: GameInfo.red

        width: scene.width
        height: scene.height/2
        x: 0
        y: 0
        z: 1000

        Image {
            id: playerMovementImageRed
            source: "../../assets/img/final/Control.png"
            opacity: GameInfo.testLevel ? 100 : 0
            x: scene.width - playerMovementImageRed.width - 50
            y: 50
            width: 180
            height: 180
        }


        MultiPointTouchArea {
            enabled: GameInfo.gamePaused ? false : true
            anchors.fill: parent

            property int referencePointX: 0
            property int referencePointY: 0
            property bool didRegisterReferencePoint: false;
            property bool rotateOnce: true
            property real lastTime: 0
            property real touchStartTime: 0
            property int onTouchUpdatedCounter: 0
            property variant playerTwoAxisController: playerRed.tankRed.getComponent("TwoAxisController")
            property real oldPosX: 0.0
            property real oldPosY: 0.0
            property real newPosX: 0.0
            property real newPosY: 0.0


            touchPoints: [
                TouchPoint {id: redFieldPoint}
            ]

            onUpdated: {
                playerRed.tankRed.circleCollider.linearDamping=0
                playerRed.tankRed.tankBody.playing=true

                onTouchUpdatedCounter += 1

                newPosX = ((redFieldPoint.x - referencePointX + playerMovementImageRed.width / 2) / (playerMovementImageRed.width / 2) - 1)
                newPosY = ((redFieldPoint.y - referencePointY + playerMovementImageRed.height / 2) / (playerMovementImageRed.height / 2) - 1)
                var distance = Math.sqrt((newPosX*newPosX) + (newPosY*newPosY)) //distance from center of the circle - radius

                // only update the cannon when the user really swiped, a single touch shouldn't update the cannon angle
                if (onTouchUpdatedCounter >= GameInfo.swipeTouchPointLimit) { // change this number to '6' to only shoot when a Tap occured!

                    // if no referencePoint is loaded yet, get one!
                    if (didRegisterReferencePoint == false) {
                        // save new reference point
                        referencePointX = redFieldPoint.x;
                        referencePointY = redFieldPoint.y;

                        updatePlayerMovementImagePosition()
                    }

                    if (distance >1) {
                        //angle is used to find a reference point at the border of the circular pad
                        var angle = (Math.atan2(newPosX, newPosY) * 180 / Math.PI) -180
                        angle = angle * (-1)
                        angle -= 90

                        //find a new reference point at the border of the circular pad
                        var newX= (playerMovementImageRed.width/2) * Math.cos((angle)*Math.PI/180) + referencePointX
                        var newY= (playerMovementImageRed.height/2) * Math.sin((angle)*Math.PI/180) + referencePointY

                        //calculate the difference between the border reference point and the point outside of the pad
                        var diffX = redFieldPoint.x - newX
                        var diffY = redFieldPoint.y - newY

                        //tester.x=referencePointX
                        //tester.y=referencePointY

                        //translate the pad in the new direction within the half of the field
                        if((referencePointX + diffX) <= playerMovementImageRed.width / 2){
                            referencePointX = playerMovementImageRed.width / 2
                        }else if((referencePointX + diffX) >= (scene.width - playerMovementImageRed.width/2)){
                            referencePointX = scene.width - playerMovementImageRed.width/2
                        }else{
                            referencePointX += diffX
                        }

                        if((referencePointY + diffY) <= playerMovementImageRed.height / 2){
                            referencePointY = playerMovementImageRed.height / 2
                        }else if((referencePointY + diffY) >= (scene.height/2 - playerMovementImageRed.height/2)){
                            referencePointY = scene.height/2 - playerMovementImageRed.height/2
                        }else{
                            referencePointY += diffY
                        }

                        /*
                    // if touch is outside of playerMovementImage update the position of the playerMovementImage and the referencePoint!
                    if (redFieldPoint.x < playerMovementImageRed.x ||
                            redFieldPoint.x > playerMovementImageRed.x + playerMovementImageRed.width) {

                        // touch happened outside of playerMovementImage in horizontal way
                        var diff = redFieldPoint.x - referencePointX;
                        if (diff < 0) {
                            diff = diff + playerMovementImageRed.width / 2;
                            referencePointX = referencePointX + diff;
                        } else {
                            diff = diff - playerMovementImageRed.width / 2;
                            referencePointX = referencePointX + diff;
                        }
                    }

                    if (redFieldPoint.y < playerMovementImageRed.y ||
                            redFieldPoint.y > playerMovementImageRed.y + playerMovementImageRed.height) {

                        // touch happened outside of playerMovementImage in vertical way
                        var diff = redFieldPoint.y - referencePointY;
                        if (diff < 0) {
                            diff = diff + playerMovementImageRed.height / 2;
                            referencePointY = referencePointY + diff;
                        } else {
                            diff = diff - playerMovementImageRed.height / 2;
                            referencePointY = referencePointY + diff;
                        }
                    }
*/
                    }

                    updatePlayerMovementImagePosition()


                    // now do the actual control of the character
                    playerRed.tankRed.circleCollider.linearDamping=0
                    playerRed.tankRed.tankBody.playing=true
                    /*

                    newPosX = ((redFieldPoint.x - referencePointX + playerMovementImageRed.width / 2) / (playerMovementImageRed.width / 2) - 1)
                    newPosY = ((redFieldPoint.y - referencePointY + playerMovementImageRed.height / 2) / (playerMovementImageRed.height / 2) - 1)
                    var distance = Math.sqrt((newPosX*newPosX) + (newPosY*newPosY)) //distance from center of the circle - radius
*/
                    newPosY = newPosY * -1

                    if (newPosX > 1) newPosX = 1
                    if (newPosY > 1) newPosY = 1
                    if (newPosX < -1) newPosX = -1
                    if (newPosY < -1) newPosY = -1

                    // if it is on the lake calculate it in a special way!
                    if(GameInfo.redOnLake){
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
            }

            function updatePlayerMovementImagePosition() {
                // move image to reference point
                var newX = referencePointX - playerMovementImageRed.width / 2;
                var newY = referencePointY - playerMovementImageRed.height / 2;

                newX = Math.max(0, newX);
                newX = Math.min(scene.width - playerMovementImageRed.width, newX);

                newY = Math.max(0, newY);
                newY = Math.min(scene.height / 2 - playerMovementImageRed.height, newY);

                playerMovementImageRed.x = newX;
                playerMovementImageRed.y = newY;

                didRegisterReferencePoint = true;
            }

            // slows down the character when releasing the finger from tablet
            function damping(){
                if(GameInfo.redOnLake==false){
                    playerRed.tankRed.circleCollider.linearDamping=GameInfo.damping
                }
            }

            // updates the speed/direction of the character
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

                    if(GameInfo.easyMode)playerRed.tankRed.tankCannon.rotation = angle+90
                    //playerRed.tankRed.tankCannon.rotation = playerRed.tankRed.tankBody.rotation + playerRed.tankRed.cannonAngle + 90 // used for ControlType2
                }
            }

            onPressed: {
                touchStartTime = new Date().getTime()
                didRegisterReferencePoint = false;
            }

            onReleased: {
                // reset touchUpdateCounter
                onTouchUpdatedCounter = 0

                // set playing to false
                playerRed.tankRed.tankBody.playing=false

                // slow down character till it stops
                damping()
            }

            onEnabledChanged: {
                if(rotateOnce){
                    playerRed.tankRed.tankCannon.rotation = 90
                    rotateOnce = false
                }
            }
        }
    }

    // ---------------------------------
    // Fire Button Player Red
    // ---------------------------------
    Rectangle {
        id: fireButtonPlayerRed
        radius: GameInfo.radius
        opacity: GameInfo.pacity
        color: "transparent" // Qt.lighter(GameInfo.red, GameInfo.lighterColor)
        //border.width: GameInfo.border
        //border.color: GameInfo.red

        width: GameInfo.controlType1Width
        height: GameInfo.controlType1Height
        x: 50
        y: 50
        z: 1000

        Image {
            id: fireImageRed
            source: GameInfo.easyMode? "../../assets/img/final/FireEasy.png" : "../../assets/img/final/FireHard.png"
            anchors.centerIn: parent
            width: parent.width
            height: parent.height
            anchors.fill: parent
        }


        MultiPointTouchArea {
            enabled: (GameInfo.gamePaused == false) && GameInfo.easyMode ? true : false
            anchors.fill: parent

            touchPoints: [
                TouchPoint {id: fireTouchPointRed}
            ]

            property real lastTime: 0

            onPressed: {
                var currentTime = new Date().getTime()
                var timeDiff = currentTime - lastTime

                if (timeDiff > playerRed.minTimeDistanceBullet) {
                    if (playerRed.activatePowershot){
                        icicle()
                    }else{
                        snowball()
                    }
                    playerRed.tankRed.tankHead.playing=true

                    lastTime = currentTime

                    var speed = (playerRed.activateAccelerator) ? 500 : 250

                    var rotation = playerRed.tankRed.tankBody.rotation+90

                    var xDirection = Math.cos(rotation * Math.PI / 180.0) * speed
                    var yDirection = Math.sin(rotation * Math.PI / 180.0) * speed

                    var startX= (45*Math.cos((rotation)*Math.PI/180)) + playerRed.tankRed.x + playerRed.tankRed.width/2
                    var startY= (45*Math.sin((rotation)*Math.PI/180)) + playerRed.tankRed.y + playerRed.tankRed.height/2

                    // create and remove entities at runtime
                    entityManager.createEntityFromUrlWithProperties(Qt.resolvedUrl("../Bullet.qml"), {
                                                                        "start" : Qt.point(startX, startY),
                                                                        "velocity" : Qt.point(xDirection, yDirection),
                                                                        "rotation" : playerRed.tankRed.tankBody.rotation + 180,
                                                                        "bulletType" : playerRed.activatePowershot ? 1 : 0});
                }
            }

            onTouchUpdated: {}

            onReleased: {}

            onCanceled: {}
        }
    }

    onRedOffLake: {
        if(GameInfo.redOnLake==false && playerRed.tankRed.tankBody.playing==false){
            playerRed.tankRed.circleCollider.linearDamping=GameInfo.damping
        }
    }

    /*
    // ---------------------------------------------------
    // Controller tankRed
    // ---------------------------------------------------
    Rectangle {
        // Object properties
        id: playerMovementControlAreaRed
        width: 180
        height: 180
        x: 50
        y: 50
        z: 5000
        radius: width / 2//GameInfo.radius
        opacity: GameInfo.easyMode ? 0 : GameInfo.pacity
        color: GameInfo.easyMode? "transparent" : Qt.lighter(GameInfo.red, GameInfo.lighterColor)
        border.width: GameInfo.border
        border.color: GameInfo.easyMode? "transparent" : GameInfo.red

        Image {
            source: "../../assets/img/final/Control.png"
            opacity: GameInfo.easyMode? 100: 0
            anchors.centerIn: parent
            width: parent.width
            height: parent.height
        }
*//*
        MultiPointTouchArea {
            enabled: GameInfo.gamePaused || GameInfo.easyMode ? false : true
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

                var distance = Math.sqrt((newPosX*newPosX) + (newPosY*newPosY)) //distance from center of the circle - radius


                if (GameInfo.easyMode && distance >1) {
                    //angle is used to find a reference point at the border of the circular pad
                    var angle = (Math.atan2(newPosX, newPosY) * 180 / Math.PI) -180
                    angle = angle * (-1)
                    angle -= 90

                    //find a new reference point at the border of the circular pad
                    var newX= ((playerMovementControlAreaRed.width/2)*Math.cos((angle)*Math.PI/180))
                            +(playerMovementControlAreaRed.width/2) + playerMovementControlAreaRed.x
                    var newY= ((playerMovementControlAreaRed.height/2)*Math.sin((angle)*Math.PI/180))
                            +(playerMovementControlAreaRed.height/2) + playerMovementControlAreaRed.y

                    //calculate the difference between the border reference point and the point outside of the pad
                    var diffX = pointCtrlRed.x + playerMovementControlAreaRed.x - newX
                    var diffY = pointCtrlRed.y + playerMovementControlAreaRed.y - newY

                    //translate the pad in the new direction within the half of the field
                    if((playerMovementControlAreaRed.x + diffX) <= 0){
                        playerMovementControlAreaRed.x = 0
                    }else if((playerMovementControlAreaRed.x + diffX) >= (scene.width - playerMovementControlAreaRed.width)){
                        playerMovementControlAreaRed.x = scene.width - playerMovementControlAreaRed.width
                    }else{
                        playerMovementControlAreaRed.x += diffX
                    }

                    if((playerMovementControlAreaRed.y + diffY) <= 0){
                        playerMovementControlAreaRed.y = 0
                    }else if((playerMovementControlAreaRed.y + diffY) >= (scene.height/2 - playerMovementControlAreaRed.height)){
                        playerMovementControlAreaRed.y = scene.height/2 - playerMovementControlAreaRed.height
                    }else{
                        playerMovementControlAreaRed.y += diffY
                    }






                }

                newPosY = newPosY * -1

                if (newPosX > 1) newPosX = 1
                if (newPosY > 1) newPosY = 1
                if (newPosX < -1) newPosX = -1
                if (newPosY < -1) newPosY = -1

                // if it is on the lake calculate it in a special way!
                if(GameInfo.redOnLake){
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

                *//* normalise the speed! when driving diagonally the x and y speed is both 1
                    when driving horizontally only either x or y is 1, which results in slower horizontal/vercial speed than diagonal speed
                    so shrink x and y about the same ratio down so that their maximum speed will be 1 (or whatever specified) *//*

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

                    if(GameInfo.easyMode)playerRed.tankRed.tankCannon.rotation = angle+90
                    //playerRed.tankRed.tankCannon.rotation = playerRed.tankRed.tankBody.rotation + playerRed.tankRed.cannonAngle + 90 // used for ControlType2
                }
            }
        }
    }

*/





    // ------------------------------------
    // Cannon Controller Player Red
    // ------------------------------------
    Rectangle {
        // Object properties
        id: playerBulletControlAreaRed

        radius: GameInfo.radius
        opacity: 0
        color: Qt.lighter(GameInfo.red, GameInfo.lighterColor)
        border.width: GameInfo.border
        border.color: GameInfo.red

        width: GameInfo.controlType1Width
        height: GameInfo.controlType1Height
        x: 50
        y: 50
        z: 1000

        MultiPointTouchArea {
            enabled: GameInfo.gamePaused || (GameInfo.easyMode) ? false : true
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
                onTouchUpdatedCounter += 1

                // only update the cannon when the user really swiped, a single touch shouldn't update the cannon angle
                if (onTouchUpdatedCounter >= GameInfo.onTouchUpdateCounterThreshold) { // change this number to '6' to only shoot when a Tap occured!
                    upDateCannon()
                }
            }
            */

            onTouchUpdated: upDateCannon()

            onPressed: {
                pressBool= true
                upDateCannon()
            }

            onReleased: {
                upDateCannon()
                var currentTime = new Date().getTime()
                var timeDiff = currentTime - lastTime
                //*//var touchReleaseTime = currentTime - touchStartTime

                if (pressBool && timeDiff > playerRed.minTimeDistanceBullet) {
                    if (playerRed.activatePowershot){
                        icicle()
                    }else{
                        snowball()
                    }
                    playerRed.tankRed.tankHead.playing=true

                    lastTime = currentTime

                    var speed = (playerRed.activateAccelerator) ? 500 : 250

                    var xDirection = Math.cos(playerRed.tankRed.tankCannon.rotation * Math.PI / 180.0) * speed
                    var yDirection = Math.sin(playerRed.tankRed.tankCannon.rotation * Math.PI / 180.0) * speed

                    var startX= (45*Math.cos((playerRed.tankRed.tankCannon.rotation)*Math.PI/180)) + playerRed.tankRed.x + playerRed.tankRed.width/2
                    var startY= (45*Math.sin((playerRed.tankRed.tankCannon.rotation)*Math.PI/180)) + playerRed.tankRed.y + playerRed.tankRed.height/2

                    // create and remove entities at runtime
                    entityManager.createEntityFromUrlWithProperties(Qt.resolvedUrl("../Bullet.qml"), {
                                                                        "start" : Qt.point(startX, startY),
                                                                        "velocity" : Qt.point(xDirection, yDirection),
                                                                        "rotation" : playerRed.tankRed.tankCannon.rotation + 90,
                                                                        "bulletType" : playerRed.activatePowershot ? 1 : 0});
                }
                pressBool= false
                //*//onTouchUpdatedCounter = 0
            }

            function upDateCannon(){
                // point1.x range: 0 - playerBulletControlAreaRed.width

                // ControlType2
                /*
                var b = point1.x - (playerBulletControlAreaRed.width / 2)
                var m = playerBulletControlAreaRed.width / 2 / GameInfo.controlType2AngleRange
                var angle = b / m * (-1)
                angle = Math.max(angle, -GameInfo.controlType2AngleRange)
                angle = Math.min(angle, GameInfo.controlType2AngleRange)
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






    // ------------------------------------
    // Blue Field
    // ------------------------------------
    Rectangle {
        // Object properties
        id: blueField
        radius: GameInfo.radius
        opacity: GameInfo.pacity
        color: "transparent"
        //border.width: GameInfo.border
        //border.color: GameInfo.blue

        width: scene.width
        height: scene.height/2
        x: 0
        y: scene.height/2
        z: 1000

        Image {
            id: playerMovementImageBlue
            source: "../../assets/img/final/Control.png"
            opacity: GameInfo.testLevel ? 100 : 0
            x: 50
            y: blueField.height - playerMovementImageBlue.height - 50
            width: 180
            height: 180
        }


        MultiPointTouchArea {
            enabled: GameInfo.gamePaused ? false : true
            anchors.fill: parent

            property int referencePointX: 0
            property int referencePointY: 0
            property bool didRegisterReferencePoint: false;
            property bool rotateOnce: true
            property real lastTime: 0
            property real touchStartTime: 0
            property int onTouchUpdatedCounter: 0
            property variant playerTwoAxisController: playerBlue.tankBlue.getComponent("TwoAxisController")
            property real oldPosX: 0.0
            property real oldPosY: 0.0
            property real newPosX: 0.0
            property real newPosY: 0.0


            touchPoints: [
                TouchPoint {id: blueFieldPoint}
            ]

            onUpdated: {
                playerBlue.tankBlue.circleCollider.linearDamping=0
                playerBlue.tankBlue.tankBody.playing=true

                onTouchUpdatedCounter += 1

                newPosX = ((blueFieldPoint.x - referencePointX + playerMovementImageBlue.width / 2) / (playerMovementImageBlue.width / 2) - 1)
                newPosY = ((blueFieldPoint.y - referencePointY + playerMovementImageBlue.height / 2) / (playerMovementImageBlue.height / 2) - 1)
                var distance = Math.sqrt((newPosX*newPosX) + (newPosY*newPosY)) //distance from center of the circle - radius


                // only update the cannon when the user really swiped, a single touch shouldn't update the cannon angle
                if (onTouchUpdatedCounter >= GameInfo.swipeTouchPointLimit) { // change this number to '6' to only shoot when a Tap occured!

                    // if no referencePoint is loaded yet, get one!
                    if (didRegisterReferencePoint == false) {
                        // save new reference point
                        referencePointX = blueFieldPoint.x;
                        referencePointY = blueFieldPoint.y;

                        updatePlayerMovementImagePosition()
                    }

                    if (distance >1) {
                        //angle is used to find a reference point at the border of the circular pad
                        var angle = (Math.atan2(newPosX, newPosY) * 180 / Math.PI) -180
                        angle = angle * (-1)
                        angle -= 90

                        //find a new reference point at the border of the circular pad
                        var newX= (playerMovementImageBlue.width/2) * Math.cos((angle)*Math.PI/180) + referencePointX
                        var newY= (playerMovementImageBlue.height/2) * Math.sin((angle)*Math.PI/180) + referencePointY

                        //calculate the difference between the border reference point and the point outside of the pad
                        var diffX = blueFieldPoint.x - newX
                        var diffY = blueFieldPoint.y - newY

                        //translate the pad in the new direction within the half of the field
                        if((referencePointX + diffX) <= (playerMovementImageBlue.width / 2)){
                            referencePointX = playerMovementImageBlue.width / 2
                        }else if((referencePointX + diffX) >= (scene.width - playerMovementImageBlue.width/2)){
                            referencePointX = scene.width - playerMovementImageBlue.width/2
                        }else{
                            referencePointX += diffX
                        }

                        if((referencePointY + diffY) <= playerMovementImageBlue.height / 2){
                            referencePointY = playerMovementImageBlue.height / 2
                        }else if((referencePointY + diffY) >= (scene.height/2 - playerMovementImageBlue.height/2)){
                            referencePointY = scene.height/2 - playerMovementImageBlue.height/2
                        }else{
                            referencePointY += diffY
                        }
                    }


                    /*
                    // if touch is outside of playerMovementImage update the position of the playerMovementImage and the referencePoint!
                    if (blueFieldPoint.x < playerMovementImageBlue.x ||
                            blueFieldPoint.x > playerMovementImageBlue.x + playerMovementImageBlue.width) {

                        // touch happened outside of playerMovementImage in horizontal way
                        var diff = blueFieldPoint.x - referencePointX;
                        if (diff < 0) {
                            diff = diff + playerMovementImageBlue.width / 2;
                            referencePointX = referencePointX + diff;
                        } else {
                            diff = diff - playerMovementImageBlue.width / 2;
                            referencePointX = referencePointX + diff;
                        }
                    }

                    if (blueFieldPoint.y < playerMovementImageBlue.y ||
                            blueFieldPoint.y > playerMovementImageBlue.y + playerMovementImageBlue.height) {

                        // touch happened outside of playerMovementImage in vertical way
                        var diff = blueFieldPoint.y - referencePointY;
                        if (diff < 0) {
                            diff = diff + playerMovementImageBlue.height / 2;
                            referencePointY = referencePointY + diff;
                        } else {
                            diff = diff - playerMovementImageBlue.height / 2;
                            referencePointY = referencePointY + diff;
                        }
                    }

                    */

                    updatePlayerMovementImagePosition()


                    // now do the actual control of the character
                    playerBlue.tankBlue.circleCollider.linearDamping=0
                    playerBlue.tankBlue.tankBody.playing=true

                    /*
                    newPosX = ((blueFieldPoint.x - referencePointX + playerMovementImageBlue.width / 2) / (playerMovementImageBlue.width / 2) - 1)
                    newPosY = ((blueFieldPoint.y - referencePointY + playerMovementImageBlue.height / 2) / (playerMovementImageBlue.height / 2) - 1)
                    var distance = Math.sqrt((newPosX*newPosX) + (newPosY*newPosY)) //distance from center of the circle - radius
*/
                    newPosY = newPosY * -1

                    if (newPosX > 1) newPosX = 1
                    if (newPosY > 1) newPosY = 1
                    if (newPosX < -1) newPosX = -1
                    if (newPosY < -1) newPosY = -1

                    // if it is on the lake calculate it in a special way!
                    if(GameInfo.blueOnLake){
                        newPosX = oldPosX+(newPosX*0.03)
                        newPosY = oldPosY+(newPosY*0.03)

                        if (newPosX > 1) newPosX = 1
                        if (newPosY > 1) newPosY = 1
                        if (newPosX < -1) newPosX = -1
                        if (newPosY < -1) newPosY = -1
                    }

                    // If the player is not touching the control area, slowly stop the body!
                    if(playerBlue.tankBlue.tankBody.playing==false) damping()

                    // update the movement
                    updateMovement()
                }
            }

            function updatePlayerMovementImagePosition() {
                // move image to reference point
                var newX = referencePointX - playerMovementImageBlue.width / 2;
                var newY = referencePointY - playerMovementImageBlue.height / 2;

                newX = Math.max(0, newX);
                newX = Math.min(scene.width - playerMovementImageBlue.width, newX);

                newY = Math.max(0, newY);
                newY = Math.min(scene.height / 2 - playerMovementImageBlue.height, newY);

                playerMovementImageBlue.x = newX;
                playerMovementImageBlue.y = newY;

                didRegisterReferencePoint = true;
            }

            // slows down the character when releasing the finger from tablet
            function damping(){
                if(GameInfo.blueOnLake==false){
                    playerBlue.tankBlue.circleCollider.linearDamping=GameInfo.damping
                }
            }

            // updates the speed/direction of the character
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

                    if(GameInfo.easyMode)playerBlue.tankBlue.tankCannon.rotation = angle+90
                    //playerRed.tankRed.tankCannon.rotation = playerRed.tankRed.tankBody.rotation + playerRed.tankRed.cannonAngle + 90 // used for ControlType2
                }
            }

            onPressed: {
                touchStartTime = new Date().getTime()
                didRegisterReferencePoint = false;
            }

            onReleased: {
                // reset touchUpdateCounter
                onTouchUpdatedCounter = 0

                // set playing to false
                playerBlue.tankBlue.tankBody.playing=false

                // slow down character till it stops
                damping()
            }

            onEnabledChanged: {
                if(rotateOnce){
                    playerBlue.tankBlue.tankBody.rotation = 180
                    playerBlue.tankBlue.tankCannon.rotation = 90
                    rotateOnce = false
                }
            }
        }
    }



    // ---------------------------------
    // Fire Button Player Blue
    // ---------------------------------
    Rectangle {
        id: fireButtonPlayerBlue
        radius: GameInfo.radius
        opacity: GameInfo.pacity
        color: "transparent" // Qt.lighter(GameInfo.red, GameInfo.lighterColor)
        //border.width: GameInfo.border
        //border.color: GameInfo.blue


        width: GameInfo.controlType1Width
        height: GameInfo.controlType1Height
        x: scene.width - fireButtonPlayerBlue.width - 50
        y: scene.height - fireButtonPlayerBlue.height - 50
        z: 1000



        Image {
            id: fireImageBlue
            source: GameInfo.easyMode? "../../assets/img/final/FireEasy.png" : "../../assets/img/final/FireHard.png"
            anchors.centerIn: parent
            width: parent.width
            height: parent.height
            anchors.fill: parent
        }

        MultiPointTouchArea {
            //enabled: GameInfo.gamePaused || GameInfo.easyMode ? true : false
            enabled: (GameInfo.gamePaused == false) && GameInfo.easyMode ? true : false
            anchors.fill: parent

            touchPoints: [
                TouchPoint {id: fireTouchPointBlue}
            ]

            property real lastTime: 0

            onPressed: {
                var currentTime = new Date().getTime()
                var timeDiff = currentTime - lastTime

                if (timeDiff > playerBlue.minTimeDistanceBullet) {
                    if (playerBlue.activatePowershot){
                        icicle()
                    }else{
                        snowball()
                    }
                    playerBlue.tankBlue.tankHead.playing=true

                    lastTime = currentTime

                    var speed = (playerBlue.activateAccelerator) ? 500 : 250

                    var rotation = playerBlue.tankBlue.tankBody.rotation+90

                    var xDirection = Math.cos(rotation * Math.PI / 180.0) * speed
                    var yDirection = Math.sin(rotation * Math.PI / 180.0) * speed

                    var startX= (45*Math.cos((rotation)*Math.PI/180)) + playerBlue.tankBlue.x + playerBlue.tankBlue.width/2
                    var startY= (45*Math.sin((rotation)*Math.PI/180)) + playerBlue.tankBlue.y + playerBlue.tankBlue.height/2

                    // create and remove entities at runtime
                    entityManager.createEntityFromUrlWithProperties(Qt.resolvedUrl("../Bullet.qml"), {
                                                                        "start" : Qt.point(startX, startY),
                                                                        "velocity" : Qt.point(xDirection, yDirection),
                                                                        "rotation" : playerBlue.tankBlue.tankBody.rotation + 180,
                                                                        "bulletType" : playerBlue.activatePowershot ? 1 : 0});
                }
            }

            onTouchUpdated: {}

            onReleased: {}

            onCanceled: {}
        }
    }


    onBlueOffLake: {
        if(GameInfo.blueOnLake==false && playerBlue.tankBlue.tankBody.playing==false){
            playerBlue.tankBlue.circleCollider.linearDamping=GameInfo.damping
        }else{
            playerBlue.tankBlue.circleCollider.linearDamping=0
        }
    }

    // ---------------------------------------------------
    // Controller tankBlue
    // ---------------------------------------------------
    /*


    Rectangle {
        // Object properties
        id: playerMovementControlAreaBlue
        width: 180
        height: 180
        x: scene.width - 230
        y: scene.height - 230
        z: 1000

        radius: width / 2 //GameInfo.radius
        opacity: GameInfo.easyMode ? 0 : GameInfo.pacity
        color: Qt.lighter(GameInfo.blue, GameInfo.lighterColor)
        border.width: GameInfo.border
        border.color: GameInfo.blue

        MultiPointTouchArea {
            enabled: GameInfo.gamePaused || (GameInfo.easyMode) ? false : true
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

                *//* normalise the speed! when driving diagonally the x and y speed is both 1
                    when driving horizontally only either x or y is 1, which results in slower horizontal/vercial speed than diagonal speed
                    so shrink x and y about the same ratio down so that their maximum speed will be 1 (or whatever specified) *//*

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
*/

    // ---------------------------------------------------
    // Controller blueTankCannon
    // ---------------------------------------------------
    Rectangle {
        // Object properties
        id: playerBulletControlAreaBlue

        radius: GameInfo.radius
        opacity: 0
        color: Qt.lighter(GameInfo.blue, GameInfo.lighterColor)
        border.width: GameInfo.border
        border.color: GameInfo.blue

        width: GameInfo.controlType1Width
        height: GameInfo.controlType1Height
        x: scene.width - playerBulletControlAreaBlue.width - 50
        y: scene.height - GameInfo.controlType1Height - 50
        z: 1000

        MultiPointTouchArea {
            enabled: GameInfo.gamePaused || GameInfo.easyMode ? false : true
            anchors.fill: parent

            property bool rotateOnce: true
            property bool pressBool: true
            property var lastTime: 0
            //*// property var touchStartTime: 0
            //*// property int onTouchUpdatedCounter: 0
            property var playerTwoAxisController: playerBlue.tankBlue.getComponent("TwoAxisController")

            touchPoints: [
                TouchPoint {id: point2}
            ]

            /*
            onUpdated: {
                onTouchUpdatedCounter += 1

                // only update the cannon when the user really swiped, a single touch shouldn't update the cannon angle
                if (onTouchUpdatedCounter >= GameInfo.onTouchUpdateCounterThreshold) { // change this number to '6' to only shoot when a Tap o.ccured!
                    upDateCannon()
                }
            }
            */
            onTouchUpdated: upDateCannon()

            onPressed: {
                pressBool= true
                //*//touchStartTime = new Date().getTime()
                upDateCannon()
            }

            onReleased: {
                upDateCannon()
                var currentTime = new Date().getTime()
                var timeDiff = currentTime - lastTime
                //var touchReleaseTime = currentTime - touchStartTime

                if (pressBool && timeDiff > playerBlue.minTimeDistanceBullet) {
                    if (playerRed.activatePowershot){
                        icicle()
                    }else{
                        snowball()
                    }

                    playerBlue.tankBlue.tankHead.playing=true

                    lastTime = currentTime

                    var speed = (playerBlue.activateAccelerator) ? 500 : 250

                    var xDirection = Math.cos(playerBlue.tankBlue.tankCannon.rotation * Math.PI / 180.0) * speed
                    var yDirection = Math.sin(playerBlue.tankBlue.tankCannon.rotation * Math.PI / 180.0) * speed

                    var startX= (45*Math.cos((playerBlue.tankBlue.tankCannon.rotation)*Math.PI/180)) + playerBlue.tankBlue.x + playerBlue.tankBlue.width / 2
                    var startY= (45*Math.sin((playerBlue.tankBlue.tankCannon.rotation)*Math.PI/180)) + playerBlue.tankBlue.y + playerBlue.tankBlue.height / 2

                    // create and remove entities at runtime
                    entityManager.createEntityFromUrlWithProperties(Qt.resolvedUrl("../Bullet.qml"), {
                                                                        "start" : Qt.point(startX, startY),
                                                                        "velocity" : Qt.point(xDirection, yDirection),
                                                                        "rotation" : playerBlue.tankBlue.tankCannon.rotation + 90,
                                                                        "bulletType" : playerBlue.activatePowershot ? 1 : 0})
                }
                pressBool= false
                //*//onTouchUpdatedCounter = 0
            }

            function upDateCannon(){
                // point1.x range: 0 - playerBulletControlAreaRed.width

                // ControlType2
                /*
                var b = point2.x - (playerBulletControlAreaBlue.width / 2)
                var m = playerBulletControlAreaBlue.width / 2 / GameInfo.controlType2AngleRange
                var angle = b / m
                angle = Math.max(angle, -GameInfo.controlType2AngleRange)
                angle = Math.min(angle, GameInfo.controlType2AngleRange)
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

    /*
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
*/

    function calcAngle(touchX, touchY) {
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
//            playerTwoAxisController.xAxis = controllerXPosition
//            var angle = calcAngle(controllerXPosition, controllerYPosition)
//            if (controllerXPosition!=0 && controllerYPosition != 0){
//                tankBlue.tankBody.rotation = angle +90
//                tankBlue.circleCollider.rotation = angle +90
//            }
//        }

//        onControllerYPositionChanged: {
//            playerTwoAxisController.yAxis = controllerYPosition
//            var angle = calcAngle(controllerXPosition, controllerYPosition)
//            if (controllerXPosition!=0 && controllerYPosition != 0){
//                tankBlue.tankBody.rotation = angle +90
//                tankBlue.circleCollider.rotation = angle +90
//            }
//        }

//    }
