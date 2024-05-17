import QtQuick 2.14
import QtQuick.Window 2.14
import QtQuick.Controls 2.14
import com.example 1.0

Window {
    id: thisGame
    width: 800
    height: 480
    visible: true
    title: qsTr("Game Neuradynamia")

    property int gameCardNum: 16
    property int gameTime: 30
    property int playerNum: 2


    MyUtils{
        id: myUtils
        dirName: "other/img"
        Component.onCompleted: {
            myUtils.setPicNameList("other/img");
            gamePage.myutils=myUtils;
            multiplayerModePage.myutils=myUtils;
            playerComputerPage.myutils=myUtils;
            //            homePage.source = "HomePage.qml";
            //            gamePage.source = "GamePage.qml";
            //            gamePage.gameCardNum = 16;
            //            gamePage.myutils = myUtils;
        }
    }

    //    Loader{
    //        id:homePage
    //    }
    //    Loader{
    //        id:gamePage
    ////        gameCardNum: 16
    ////        myutils: myUtils
    //    }
    HomePage{
        id:homePage
        width: thisGame.width; height: thisGame.height
    }



    GamePage{
        id:gamePage
        width: thisGame.width; height: thisGame.height
        gameCardNum: thisGame.gameCardNum
        gameTime: thisGame.gameTime
    }
    MultiplayerModePage{
        id: multiplayerModePage
        width: thisGame.width; height: thisGame.height
        gameCardNum: thisGame.gameCardNum
        playerNum: thisGame.playerNum
    }
    PlayerComputerPage{
        id: playerComputerPage
        width: thisGame.width; height: thisGame.height
        gameCardNum: thisGame.gameCardNum
        gameTime: thisGame.gameTime
    }
    SettingsPage{
        id: settingsPage
        gameCardNum: thisGame.gameCardNum
        gameTime: thisGame.gameTime
        Component.onCompleted: {
            thisGame.gameTime = Qt.binding(function(){
                return settingsPage.gameTime;
            })
            thisGame.gameCardNum = Qt.binding(function(){
                return settingsPage.gameCardNum;
            })
            thisGame.playerNum = Qt.binding(function(){
                return settingsPage.playerNum;
            })
        }
    }

    Connections{
        target: homePage.spmBtn
        onClicked:{
            stackView.push([gamePage]);
            gamePage.initCards();
            gamePage.restart();
        }
    }
    Connections{
        target: homePage.mpmBtn
        onClicked:{
            stackView.push([multiplayerModePage]);
            multiplayerModePage.initGame();
            multiplayerModePage.restart();
        }
    }
    Connections{
        target: homePage.computerBtn
        onClicked:{
            stackView.push([playerComputerPage]);
            playerComputerPage.initCards();
            playerComputerPage.restart();
        }
    }
    Connections{
        target: homePage.settingsBtn
        onClicked:{
            stackView.push([settingsPage]);
        }
    }




    Connections{
        target: gamePage.backBtn
        onClicked:{
            stackView.pop();
        }
    }
    Connections{
        target: multiplayerModePage.backBtn
        onClicked:{
            stackView.pop();
        }
    }
    Connections{
        target: playerComputerPage.backBtn
        onClicked:{
            stackView.pop();
        }
    }
    Connections{
        target: settingsPage.backBtn
        onClicked:{
            stackView.pop();
        }
    }




    StackView {
        id: stackView; anchors.fill: parent
        width: thisGame.width; height: thisGame.height
        initialItem: homePage
    }



}
