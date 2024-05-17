import QtQuick 2.14
import QtQuick.Controls 2.14

Rectangle {
    id: thisPage
    //    color: "red"
    property alias spmBtn: singlePlayerModeButton
    property alias mpmBtn: multiplayerModeButton
    property alias computerBtn: computerButton
    property alias settingsBtn: settingsButton


    property int btnWidth: 180

    QtObject{
        id: myGrad
        property var grad1: Gradient {
            GradientStop { position: 0; color: "#ffffff" }
            GradientStop { position: 1; color: "#c1bbf9" }
        }
        property var grad2: Gradient{
            GradientStop { position: 0; color: "#7777aa" }
            GradientStop { position: 1; color: "#eeeeee" }
        }
    }

    Column{
        spacing: 20
        anchors.centerIn: parent

        Button {
            id: singlePlayerModeButton
            width: btnWidth
            text: qsTr("Single-player Mode")


            contentItem: Text {
                text: singlePlayerModeButton.text
                font: singlePlayerModeButton.font
                opacity: enabled ? 1.0 : 0.7
                color: singlePlayerModeButton.down ? "#17a81a" : "#21be2b"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                elide: Text.ElideRight
            }

            background: Rectangle {
                implicitWidth: 100
                implicitHeight: 40
                opacity: enabled ? 1 : 0.7
                border.color: singlePlayerModeButton.down ? "#17a81a" : "#21be2b"
                border.width: 1
                gradient: singlePlayerModeButton.down ?  myGrad.grad1:myGrad.grad2
                radius: 2
            }

        }

        Button {
            id: multiplayerModeButton
            width: btnWidth
            text: qsTr("Multiplayer Mode")

            contentItem: Text {
                text: multiplayerModeButton.text
                font: multiplayerModeButton.font
                opacity: enabled ? 1.0 : 0.7
                color: multiplayerModeButton.down ? "#17a81a" : "#21be2b"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                elide: Text.ElideRight
            }

            background: Rectangle {
                implicitWidth: 100
                implicitHeight: 40
                opacity: enabled ? 1 : 0.7
                border.color: multiplayerModeButton.down ? "#17a81a" : "#21be2b"
                border.width: 1
                gradient: multiplayerModeButton.down ?  myGrad.grad1:myGrad.grad2
                radius: 2
            }

        }

        Button {
            id: computerButton
            width: btnWidth
            text: qsTr("Computer Mode")

            contentItem: Text {
                text: computerButton.text
                font: computerButton.font
                opacity: enabled ? 1.0 : 0.7
                color: computerButton.down ? "#17a81a" : "#21be2b"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                elide: Text.ElideRight
            }

            background: Rectangle {
                implicitWidth: 100
                implicitHeight: 40
                opacity: enabled ? 1 : 0.7
                border.color: computerButton.down ? "#17a81a" : "#21be2b"
                border.width: 1
                gradient: computerButton.down ?  myGrad.grad1:myGrad.grad2
                radius: 2
            }

        }

        Button {
            id: settingsButton
            width: btnWidth
            text: qsTr("Settings")

            contentItem: Text {
                text: settingsButton.text
                font: settingsButton.font
                opacity: enabled ? 1.0 : 0.3
                color: settingsButton.down ? "#17a81a" : "#21be2b"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                elide: Text.ElideRight
            }

            background: Rectangle {
                implicitWidth: 100
                implicitHeight: 40
                opacity: enabled ? 1 : 0.3
                border.color: settingsButton.down ? "#17a81a" : "#21be2b"
                border.width: 1
                gradient: settingsButton.down ?  myGrad.grad1:myGrad.grad2
                radius: 2
            }

        }





    }


}
