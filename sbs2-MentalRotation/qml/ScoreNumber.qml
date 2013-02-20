import QtQuick 1.1

Rectangle {
    id: scoreNumber
    width: 100
    height: width
    color: "black"
    property int value: 0

    signal clicked()

    Component.onCompleted: {
        mouseArea.clicked.connect(scoreNumber.clicked)
    }

    Text {
        color: parent.color == "#000000" ? "red" : "black"
        anchors.centerIn: parent
        text: ""+parent.value
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
    }

}
