import QtQuick 1.1

Item {
    id: button

    property alias background: buttonRect.color
    property alias color: label.color
    property alias text : label.text

    width: 210
    height: 50

    signal clicked()

    Component.onCompleted: {
        mouseArea.clicked.connect(button.clicked)
    }

    Rectangle {
        id: buttonRect
        anchors.fill: parent
        color: "white"

        Text {
            id: label
            color: "black"
            text: parent.desc
            font.pointSize: 20
            anchors.centerIn: parent
            font.bold: true
        }

    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
    }
}

