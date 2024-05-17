import QtQuick 2.14

Flipable {
    id: flipable
    width: 96; height: 128
    property alias source: thisImg.source

    property int flipDuration: 200  // flip animation consumed time
    property int cardIndex;  // the index in cardIndexList (GamePage.qml)
    property bool flipped: false
    signal hasBeenflipped(int cardIndex)

    front: Image{
        id: thisImg
        width: flipable.width; height: flipable.height
//        source: "file:other/img/porkerman.png"
        fillMode: Image.Stretch
        asynchronous: true
    }

    back: Rectangle{
        id: backRect
        width: flipable.width; height: flipable.height
        gradient: Gradient{
            GradientStop{position: 0; color: Qt.rgba(0.8,0.2,0)}
            GradientStop{position: 1; color: Qt.rgba(0,0.1,1)}
        }
    }
    transform: Rotation {
        id: rotation
        origin.x: flipable.width/2; origin.y: flipable.height/2 // set the origin position
        axis.x: 0; axis.y: 1; axis.z: 0     // set axis.y to 1 to rotate around y-axis
        angle: 0    // the default angle
    }

    states: State {
        name: "back"
        PropertyChanges { target: rotation; angle: 180 }
        when: !flipable.flipped
    }

    transitions: Transition {
        NumberAnimation { target: rotation; property: "angle"; duration: flipDuration; }
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            if(!flipped){
                flipped = true
                hasBeenflipped(cardIndex);
            }
        }

    }
}
