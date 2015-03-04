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
    licenseKey: "A9BFADBFD993062BF5C0DD837864F67E55ACE3B420ECC2F9BAF3A5D5E5233F965A39F6EC05E019A2D3A9B48D05F9D4F21A85D9CBB7BEF0BD3E9ECDE749F5EDF7680D96A5EFE4A253E30ED6F54F576CBEF10D049A126682B04EA1708ECBD41764D0B92B49ACA47DA1175BB58CFCF1D13088766D221396763717FFEA6E20B1C8E3A99BC1DB62CFA0E078183FAE86614829042B964B1D0B3D8BD2FE286ECEFFD9FFEC536B5405244B370409AED8A31D26FD0C20D982878B8CA21C72C0FDF7058AB6B91F146923D84612529EB8F6C64F10DF02C79C3345C95BBFBE954B76C36B97D23C280E15D4B71DC31E650210127E6907668B5E2E177E136FABFED331088E116E0957A352DBC22E793A2813E070CD6528F7CF6F0EAFA2F46BAF32E026F3EDBC33"

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
