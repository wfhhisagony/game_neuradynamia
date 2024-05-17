import QtQuick 2.14
import QtQuick.Controls 2.14
import QtQuick.Layouts 1.14

Rectangle{

    id: thisPage
    //    color: "blue"
    // the property to expose
    property alias rowLayout: rowLayout
    property alias backBtn: backButton
    property alias gameCardNum: cardInfoClass.cardNum
    property alias playerNum: playerInfoClass.num
    property alias currentPlayerIndex: playerInfoClass.currentIndex

    // the property to be imported
    property var myutils;


    property var tmpList : []
    QtObject{
        id: cardInfoClass
        property int cardNum;
        property var cardIndexList: []  // give each card a number so that they can differentiate from each other and make pairs
        property var cardList: []   // instances of Card.qml
        property int pairNum: 0
    }
    QtObject{
        id: playerInfoClass
        property var num;   // 玩家数
        property var nameList: []  // 各玩家的名字
        property var pairList: [0, 0, 0, 0] // 各玩家已完成配对数组
        property int currentIndex: 0    // 标明现在是哪个玩家再翻牌
    }
    QtObject{
        id: playerNameClass
        property string playerName;
        property int playerIconIndex;
    }

    onCurrentPlayerIndexChanged: {
//        if(currentPlayerIndex === 0){
//            player1ScoreBoard.border.color = "green";
//            player2ScoreBoard.border.color = "red";
//        }
//        else if(currentPlayerIndex === 1){
//            player1ScoreBoard.border.color = "red";
//            player2ScoreBoard.border.color = "green";
//        }

        showCurrentPlayerText.text = "P" + (currentPlayerIndex+1) + "翻牌"
    }

    Component.onCompleted: {

    }



    ColumnLayout{
        anchors.fill: parent
        Layout.fillWidth: true; Layout.fillHeight: true
        spacing: 10
        RowLayout{
            id: rowLayout
            Layout.fillWidth: true
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
                Text{
                    id: showCurrentPlayerText
                    text: "P1翻牌"
                    font.pixelSize: 20
                    anchors.fill: parent
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                }
            }

            Rectangle{
                id: player1ScoreBoard
                width: 80 ; height: player1ScoreBoardText.height + 10
                border.color: currentPlayerIndex===0? "green": "red"
                border.width: 2
                Text{
                    id: player1ScoreBoardText
                    text: playerInfoClass.pairList[0];
                    anchors.fill: parent
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                }
            }

            Rectangle{
                id: player2ScoreBoard
                width: 80 ; height: player2ScoreBoardText.height + 10
                border.color: currentPlayerIndex===1? "green": "red"
                border.width: 2
                Text{
                    id: player2ScoreBoardText
                    text: playerInfoClass.pairList[1];
                    anchors.fill: parent
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                }
            }

            Rectangle{
                id: player3ScoreBoard
                width: 80 ; height: player3ScoreBoardText.height + 10
                border.color: currentPlayerIndex===2? "green": "red"
                border.width: 2
                visible: playerNum >= 3 ? true : false
                Text{
                    id: player3ScoreBoardText
                    text: playerInfoClass.pairList[1];
                    anchors.fill: parent
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                }
            }

            Rectangle{
                id: player4ScoreBoard
                width: 80 ; height: player4ScoreBoardText.height + 10
                border.color: currentPlayerIndex===3? "green": "red"
                border.width: 2
                visible: playerNum >= 4 ? true : false
                Text{
                    id: player4ScoreBoardText
                    text: playerInfoClass.pairList[1];
                    anchors.fill: parent
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
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
                width: thisPage.width
                Layout.fillHeight: true
                spacing: 20
            }
        }

    }


    function initGame(){
        initCards();
        playerInfoClass.currentIndex = 0;
        playerInfoClass.pairList = new Array(playerInfoClass.num).fill(0);
        cardInfoClass.pairNum = 0;
        player1ScoreBoardText.text = Qt.binding(function(){
            return playerInfoClass.pairList[0];
        })

        player2ScoreBoardText.text = Qt.binding(function(){
            return playerInfoClass.pairList[1];
        })

    }


    function initCards(){
        clearCardList();
        makeCardIndexList(cardInfoClass.cardNum);
        loadImgAndMakeCardList();
    }

    function restart(){
        popup.close();
        clearRecordVars();
        flipCardsToBack(cardInfoClass.cardNum);
        shufflePoker(cardInfoClass.cardNum);
        testRefreshScoreBoardText();
    }


    function clearCardList(){
        for(var i=0;i<cardInfoClass.cardList.length; i++){
            cardInfoClass.cardList[i].destroy();  // destroy the qml Item
        }
        cardInfoClass.cardList = [];  // clear the js array
    }

    function clearRecordVars(){
        tmpList = [];
        cardInfoClass.pairNum = 0;
        playerInfoClass.currentIndex = 0;
        for(let i=0;i<playerNum;i++){
            playerInfoClass.pairList[i] = 0;
        }
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
        // shuffle algorithm
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
                playerInfoClass.pairList[playerInfoClass.currentIndex] ++ ;
                testRefreshScoreBoardText();
            }
            else{   // unpaired then restore them
                delayFlipTimer.flipableList[0] = tmpList[0];
                delayFlipTimer.flipableList[1] = tmpList[1];
                delayFlipTimer.start(); // wait for the animation duration ,after that set them false
                playerInfoClass.currentIndex = (playerInfoClass.currentIndex + 1) % playerInfoClass.num;  // 下一个玩家抽牌
            }
            tmpList.splice(0, tmpList.length);  // clear it
        }
        if(cardInfoClass.pairNum === cardInfoClass.cardNum / 2) {
            gameComplete();
        }
    }

    function testRefreshScoreBoardText(){
        player1ScoreBoardText.text = playerInfoClass.pairList[0];
        player2ScoreBoardText.text = playerInfoClass.pairList[1];
        if(playerNum >= 3)
            player3ScoreBoardText.text = playerInfoClass.pairList[2];
        if(playerNum >= 4)
            player4ScoreBoardText.text = playerInfoClass.pairList[3];
    }

    function flipCardsToBack(cardNum){
        for(var i=0;i<cardNum;i++){
            cardInfoClass.cardList[i].flipped = false;
        }
    }

    function gameComplete(){
        let res = getWinnerIndex();
        if(res === -2){
            popup.theShowText = qsTr("平局!\n按Space键重新开始");
        }else if(res === -1){
            var sss = "Player";
            for(let i=0;i<tmpList.length;i++){
                let index = i+1;
                sss +=  " " + index  + "、";
            }
            sss += "赢了";
            popup.theShowText = qsTr(sss+"\n按Space键重新开始");
        }else{
            let index =res+1;
            popup.theShowText = qsTr("Player " + index + "赢了\n按Space键重新开始");
        }
        popup.open();
    }

    function getWinnerIndex(){
        let i=0;
        let maxPairNum = playerInfoClass.pairList[i];
        let res = findArrayMaxIndex();
        if(res === -1){
            if(tmpList.length === playerInfoClass.num){
                return -2;  // 平局
            }
            else{
                return -1;  // multiple maxNum
            }
        }
        else return res;
    }

    function findArrayMaxIndex(){   // if winner is more than one then use tmpList to sort
        let flag =0;
        let i=0;
        let maxNum = playerInfoClass.pairList[i];
        for(i=1;i<playerInfoClass.num;i++){

            if(maxNum < playerInfoClass.pairList[i]){
                maxNum = playerInfoClass.pairList[i];
            }
        }
        // check if maxNum is the only one
        for(i=0;i<playerInfoClass.num;i++){
            if(playerInfoClass.pairList[i] === maxNum){
                tmpList.push(i);
            }
        }
        if(tmpList.length === 1) return tmpList[0];
        else return -1; // multiple maxNum
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
