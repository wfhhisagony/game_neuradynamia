import QtQuick 2.14
import QtQuick.Controls 2.14
import QtQuick.Layouts 1.14

Rectangle{

    id: thisPage
    //    color: "blue"
    // the property to expose
    property alias rowLayout: rowLayout
    property alias backBtn: backButton
    property alias timer: timer
    property alias gameTime: timer.gameTime
    property alias remainTime: timer.remainTime
    property alias gameCardNum: cardInfoClass.cardNum


    property var tmpList : []
    QtObject{
        id: cardInfoClass
        property int cardNum;
        property var cardIndexList: []  // give each card a number so that they can differentiate from each other and make pairs
        property var cardList: []   // instances of Card.qml
        property int pairNum: 0
    }

    property var myutils;

    Component.onCompleted: {
        //        var component = Qt.createComponent("Card.qml");

        //        if (component.status === Component.Ready) { // 默认会尽量使用同步加载
        //            for(var i=0;i<16;i++){
        //                var cardObj = component.createObject(gridLayout);
        //                cardObj.source = "file:other/img/porkerman.png"
        //                cardInfoClass.cardList.push(cardObj);
        //            }
        //        }
        //        restart()
    }

    ColumnLayout{
        anchors.fill: parent
        Layout.fillWidth: true; Layout.fillHeight: true
        spacing: 10
        RowLayout{
            id: rowLayout
            Layout.fillWidth: true
//            anchors.top: parent.top
//            anchors.left: parent.left
            z:1
            Button {
                id: backButton

                text: qsTr("< Back")


                contentItem: Text {
                    text: backButton.text
                    font: backButton.font
                    opacity: enabled ? 1.0 : 0.3
                    color: backButton.down ? "#17a81a" : "#21be2b"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    elide: Text.ElideRight
                }

                QtObject{
                    id: myGrad
                    property var grad1: Gradient {
                        GradientStop { position: 0; color: "#ffffff" }
                        GradientStop { position: 1; color: "#c1bbf9" }
                    }
                    property var grad2: Gradient{
                        GradientStop { position: 0; color: "#111111" }
                        GradientStop { position: 1; color: "#eeeeee" }
                    }
                }

                background: Rectangle {
                    implicitWidth: 100
                    implicitHeight: 40
                    opacity: enabled ? 1 : 0.3
                    border.color: backButton.down ? "#17a81a" : "#21be2b"
                    border.width: 1
                    gradient: backButton.down ?  myGrad.grad1:myGrad.grad2
                    radius: 2
                }

            }

            Item{   // as a spacer
                Layout.fillHeight: true
                Layout.fillWidth: true
            }

            Rectangle{
                id: timerTextRect
                width: 80
                height: timerText.height + 10
                border.color: "red"
                border.width: 2
                Text{
                    id: timerText
                    text: timer.remainTime
                    anchors.fill: parent
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                }

//                Layout.alignment: Qt.AlignRight

                Timer{
                    id: timer
                    running: false
                    interval: 1000
                    repeat: true
                    property int gameTime;
                    property int remainTime: gameTime
                    onTriggered: {
                        remainTime--;
                        if(remainTime == 0) {
                            timer.stop();
                            if(cardInfoClass.pairNum < cardInfoClass.cardNum / 2){
                                loseGame();
                            }
                        }
                    }
                }
            }



        }

        ScrollView{
            id: scrollView
            Layout.fillWidth: true
            Layout.fillHeight: true
            clip: true
            Flow{
                id: flowLayout
                //                anchors.top: rowLayout.bottom

                width: thisPage.width
                Layout.fillHeight: true
                spacing: 20
            }
        }

    }



    function initCards(){
        clearCardList();
        makeCardIndexList(cardInfoClass.cardNum);
        loadImgAndMakeCardList();
    }

    function restart(){
        popup.close();
        clearRecordArrays();
        flipCardsToBack(cardInfoClass.cardNum);
        shufflePoker(cardInfoClass.cardNum);
        restartTimer();
    }

    function restartTimer(){
        timer.gameTime = gameTime;
        timer.remainTime = timer.gameTime;
        timer.start();
    }

    function clearCardList(){
        for(var i=0;i<cardInfoClass.cardList.length; i++){
            cardInfoClass.cardList[i].destroy();  // destroy the qml Item
        }
        cardInfoClass.cardList = [];  // clear the js array
    }

    function clearRecordArrays(){
        tmpList = [];
        cardInfoClass.pairNum = 0;
    }

    function makeCardIndexList(cardNum){
        cardInfoClass.cardIndexList = []  // clear the js array
        cardInfoClass.cardIndexList = new Array(cardNum).fill(0);
        // init
        var i;
        for(i=1;i<=cardNum/2;i++){  // cardNum must be an even
            cardInfoClass.cardIndexList[i-1] = i;
            cardInfoClass.cardIndexList[i-1+ cardNum/2] = i;
        }
    }

    function shufflePoker(cardNum){
        // shuffle algorithm: Knuth-Durstenfeld Shuffle
        for(var i=cardNum-1;i>0;i--){
            var randNumber = Math.floor(Math.random() * i);

            var tmp =  cardInfoClass.cardIndexList[i];
            cardInfoClass.cardIndexList[i] = cardInfoClass.cardIndexList[randNumber];
            cardInfoClass.cardIndexList[randNumber] = tmp;

            // in fact, just exchange the imgSource
            tmp = cardInfoClass.cardList[i].source;
            cardInfoClass.cardList[i].source = cardInfoClass.cardList[randNumber].source;
            cardInfoClass.cardList[randNumber].source = tmp;
        }
    }

    function loadImgAndMakeCardList(){
        var component = Qt.createComponent("Card.qml");
        var num = cardInfoClass.cardNum;
        if (component.status === Component.Ready) {
            for(var i=0;i<num;i++){
                var cardObj = component.createObject(flowLayout);
                cardObj.cardIndex = i;  // the index in cardIndexList
                //                cardObj.source = "file:other/img/porkerman.png"
                //                cardObj.source = "file:"+findImgSourceByPrefix(cardInfoClass.cardIndexList[i]);
                cardObj.source = "file:"+findImgSourceByIndex(cardInfoClass.cardIndexList[i]-1);
                cardObj.onHasBeenflipped.connect(tryPairCards);  // signal connect function
                cardInfoClass.cardList.push(cardObj);
            }
        }
    }

    function findImgSourceByPrefix(index){
        return myutils.getImgFullNameByPrefix(index.toString());
    }

    function findImgSourceByIndex(index){
        return myutils.getImgFullNameByIndex(index);
    }

    function tryPairCards(cardIndex){
        cardInfoClass.cardList[cardIndex].flipped = true;
        tmpList.push(cardIndex);
        let n = tmpList.length;
        if(n==1) return;
        else{   // n ==2
            if(cardInfoClass.cardIndexList[tmpList[0]]  === cardInfoClass.cardIndexList[tmpList[1]] ){   // paired then keep them fipped
                cardInfoClass.pairNum ++;
            }
            else{   // unpaired then restore them
                delayFlipTimer.flipableList[0] = tmpList[0];
                delayFlipTimer.flipableList[1] = tmpList[1];
                delayFlipTimer.start(); // wait for the animation duration ,after that set them false
            }
            tmpList.splice(0, tmpList.length);  // clear it

        }
        if(cardInfoClass.pairNum === cardInfoClass.cardNum / 2) winGame()
    }

    function flipCardsToBack(cardNum){
        for(var i=0;i<cardNum;i++){
            cardInfoClass.cardList[i].flipped = false;
        }
    }

    function loseGame(){
        timer.stop();
        popup.theShowText = qsTr("You Loser!\nPress Space to restart")
        popup.open();
    }

    function winGame(){
        timer.stop();
        popup.theShowText = qsTr("You Winner!\nPress Space to restart");
        popup.open();
    }

    // ******************** Game Win or Over Dialog ***********************
    //    Button { text: "Open"; onClicked: popup.open()}
    // focus: true

    Rectangle { // as the game over dialog
        id: popup
        //        x: Math.round((parent.width - width) / 2)
        //        y: Math.round((parent.height - height) / 2)
        visible: false
        anchors.centerIn: parent
        border{
            color: Qt.rgba(0,0,0)
            width: 2
        }
        radius: 10

        property alias theShowText: showText.text
        Text {
            id: showText
            anchors.centerIn: parent
            text: qsTr("Game Over \nPress Space to restart")
        }
        width: parent.width/2; height: parent.height/2;
        Keys.onSpacePressed:  {    // attention: focus must be true when you need the keys to be listened
            console.log("Space pressed")
            popup.close();
            thisPage.restart();
            // TODO ... restart the Game
        }
        function open(){
            popup.visible = true;
            popup.focus = true;
        }
        function close(){
            popup.visible = false;
            popup.focus = false;
        }
    }



    Timer{  // wait some time for the flip animation
        id: delayFlipTimer
        running: false
        interval: 400

        property var flipableList: [0,0]

        onTriggered: {
            cardInfoClass.cardList[flipableList[0]].flipped = false;
            cardInfoClass.cardList[flipableList[1]].flipped = false;
            delayFlipTimer.stop();
        }
    }




}
