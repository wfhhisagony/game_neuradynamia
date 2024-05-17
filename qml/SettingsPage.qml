import QtQuick 2.14
import QtQuick.Controls 2.14
import QtQuick.Layouts 1.14

Rectangle {
    id: thisPage
    //    color: "red"


    property alias backBtn: backButton

    property int gameTime;
    property int gameCardNum;
    property int playerNum;

    Component.onCompleted: {
        gameTime = Qt.binding(function() { return gameTimeSpinBox.value} );
        gameCardNum = Qt.binding(function() { return gameCardNumSpinBox.value} );
        playerNum = Qt.binding(function(){ return playerNumSpinBox.value});
    }

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

    GridLayout{
        anchors.centerIn: parent
        columns: 2
        //        Row{ // set gametime
        //            spacing: 20

        Label{
            text:qsTr("Game Time")

        }
        SpinBox{
            id: gameTimeSpinBox
            from: 0
            to: 300
            value: thisPage.gameTime
        }
        //        }

        //        Row{ // set carnum
        //            spacing: 20

        Label{
            topInset: 20
            text: qsTr("Card Number")
        }
        SpinBox{    // or ComboBox
            id: gameCardNumSpinBox
            from: 16
            to: 64
            stepSize: 8
            value: thisPage.gameCardNum
        }
        //        }
        Label{
            topInset: 20
            text: qsTr("Player Number")
        }
        SpinBox{    // or ComboBox
            id: playerNumSpinBox
            from: 2
            to: 4
            stepSize: 1
            value: thisPage.playerNum
        }
    }


}
