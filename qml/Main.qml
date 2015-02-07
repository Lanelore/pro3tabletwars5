import VPlay 2.0
import QtQuick 2.0
import "scenes"
import "levels"
import "common"


GameWindow {
    onActiveChanged: {
        settings.setValue("soundEnabled", true)

        settings.soundEnabled= true
        settings.musicEnabled = true
    }


    //property bool end
    //signal gameOver
    //id: gameWindow
    licenseKey: "ACE21390D11341ED2FBAD617F7C2F862FE5AACB2CFFC6D0D05F690F43F64C28AB8FB18C05D68FC3C73EEE9C188B5017D4DF874968083AB7CEEEFA7B6AEB21DADBA3F3E17942D6862D52ABD75C6E7066FBED0070639EDBB3DDB01CC7C3276BE01E676617D0D37467F90AE3A42173C63BD55FF3C935D3999CF751B47B7DE34A2CA4C22F553EAEB7EE210DE2F402BE33FB9C18CF77B199AFD1413C82A7AD75BCF6EA3FCBA53AA60918FB430C450FA8B229BC6C9930BCFDC8BB386D23B83935C81595EA15A6B116E9DC0C3D28B0A27A344BF511574720563ED8837ED177D4D5770A91C6A282654064B75D4A84422F2B33336FA5648E5FE8B549406604900C43EB33D19DAEB8F8FA0F5A14E821055D608DA87"

    // the size of the Window can be changed at runtime by pressing Ctrl (or Cmd on Mac) + the number keys 1-8
    // the content of the logical scene size (480x320 for landscape mode by default) gets scaled to the window size based on the scaleMode
    // you can set this size to any resolution you would like your project to start with, most of the times the one of your main target device
    // this resolution is for iPad
    height: 1024
    width: 768

    id: window

    Rectangle {
        id: background
        color: "black"
        anchors.fill: parent
    }

    // create and remove entities at runtime
    EntityManager {
        id: entityManager
        entityContainer: gameScene
    }

    FontLoader {
        id: titleFont
        source: "fonts/CHLORINR.ttf"
    }

    FontLoader {
        id: standardFont
        source: "fonts/gc.ttf"
    }

    // menu scene
    MenuScene {
        id: menuScene
        // listen to the button signals of the scene and change the state according to it
        onSelectLevelPressed: window.state = "selectLevel"
        onCreditsPressed: window.state = "credits"
        onSettingsPressed: window.state = "settings"
        //onGameOver: window.state = "gameOver"

        // the menu scene is our start scene, so if back is pressed there we ask the user if he wants to quit the application
        onBackPressed: {
            nativeUtils.displayMessageBox(qsTr("Really quit the game?"), "", 2);
        }

        // listen to the return value of the MessageBox
        Connections {
            target: nativeUtils
            onMessageBoxFinished: {
                if(accepted)
                    Qt.quit()
            }
        }
    }

    // scene for selecting levels
    SelectLevelScene {
        id: selectLevelScene
        onLevelPressed: {
            // selectedLevel is the parameter of the levelPressed signal
            gameScene.setLevel(selectedLevel)
            window.state = "game"

        }
        onBackPressed: window.state = "menu"
    }

    // credits scene
    CreditsScene {
        id: creditsScene
        onBackPressed: window.state = "menu"

    }

    // credits scene
    SettingScene {
        id: settingScene
        onBackPressed: window.state = "menu"

    }
/*
    // gameOver scene
    GameOverScene {
        id: gameOverScene
        onBackPressed: window.state = "selectLevel"
    }
*/



    // game scene to play a level
    GameScene {
        id: gameScene
        onBackPressed: window.state = "selectLevel"

    }
/*
    Connections {
         target: gameScene.activeLevel || null
         onGameOver: window.state = "gameOver"
    }
*/
    // menuScene is our first scene, so set the state to menu initially
    state: "menu"
    activeScene: menuScene

    // state machine, takes care reversing the PropertyChanges when changing the state, like changing the opacity back to 0
    states: [
        State {
            name: "menu"
            PropertyChanges {target: menuScene; opacity: 1}
            PropertyChanges {target: window; activeScene: menuScene}
        },
        State {
            name: "selectLevel"
            PropertyChanges {target: selectLevelScene; opacity: 1}
            PropertyChanges {target: window; activeScene: selectLevelScene}
        },
        State {
            name: "credits"
            PropertyChanges {target: creditsScene; opacity: 1}
            PropertyChanges {target: window; activeScene: creditsScene}
        },
        /*
        State {
            name: "gameOver"
            PropertyChanges {target: gameOverScene; opacity: 1}
            PropertyChanges {target: window; activeScene: gameOverScene}
        },
        */
        State {
            name: "settings"
            PropertyChanges {target: settingScene; opacity: 1}
            PropertyChanges {target: window; activeScene: settingScene}
        },
        State {
            name: "game"
            PropertyChanges {target: gameScene; opacity: 1}
            PropertyChanges {target: window; activeScene: gameScene}
        }
    ]
}
