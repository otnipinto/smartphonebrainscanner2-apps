import Qt 4.7

Rectangle {
    id: button
    width: 180
    height: 60
    color: "black"
    property alias text : label.text

    signal clicked()

    Component.onCompleted: {
        mouseArea.clicked.connect(button.clicked)
    }

    Text {
        id: label
        color: "white"
        text: parent.desc
        font.pointSize: 20
        anchors.centerIn: parent
        font.bold: true
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
    }
}
