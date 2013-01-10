import Qt 4.7

Rectangle {
    anchors.fill: parent
    id: setupScreen
    color: "white"
    property int counter: 0
    property int direction: 1

    function cqValue(name,value) {
        scalpmap.cqValue(name,value);
        setupScreen.counter = (setupScreen.counter + direction)
        if (setupScreen.counter == 100)
            direction = -1
        if (setupScreen.counter == 0)
            direction = 1
    }

    Rectangle {
        color: parent.color
        border.color: "darkGrey"
        border.width: 4
        anchors.centerIn: parent
        width: parent.width - 10
        height: parent.height - 10
    }

    Scalpmap {
        id:scalpmap
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.margins: 10
    }

    Text {
        x: 20;
        y: 20;
        color: "black"
        text: page.title
        font.family: "Helvetica"
        font.pointSize: 27
        font.bold: true
    }

    function setTime() {
        var currentTime = new Date();
        time.text = Qt.formatTime(currentTime, "hh:mm:ss");
        time.move = currentTime.getSeconds();
    }

    Text {
        id: time
        text: " "
        x: 20
        y: page.height - 70
        color: "grey"
        font.family: "Helvetica"
        font.pointSize: 27
        font.bold: true
        Component.onCompleted: setTime()
        property int move : 0

        Timer {
            id: timeTimer
            interval: 1000
            repeat: true
            running: true
            onTriggered: setTime();
        }

        Rectangle {
            color: "grey"
            anchors.top: parent.bottom
            anchors.topMargin: 0

            width: parent.width
            height: 10

            Behavior on width {
                NumberAnimation {easing.type: Easing.InOutBounce}
            }

            Rectangle {
                color: "black"
                height: parent.height
                width: 10
                x: time.move/ 60.0 * parent.width - width
                opacity: time.move/ 60.0

                Behavior on x {
                    NumberAnimation {easing.type: Easing.InOutBounce}
                }
            }
        }
    }

    MyTextInput {
        id: user
        label: "user"
        x: 20
        y: 100
    }

    MyTextInput {
        id: description
        label: "description"
        x: 20
        y: 230
    }

    Button {
        id: quit
        text: "quit"
        y: 80
        x: page.width-quit.width
        onClicked: Qt.quit()
    }

    Button {
        id: start
        text: "start"
        y: 330
        x: 0
        onClicked: {
            page.state = "show"
            page.event("STARTED;"+ user.text + ";"+description.text)
        }
    }

    Rectangle {
        id: aliveIndicator
        width: 15* (setupScreen.counter+1)/100.0
        height: start.height
        color: "black"
        anchors.bottom: start.bottom
        anchors.left: start.right
    }


    Behavior on opacity {
        NumberAnimation { duration: 300; easing.type: Easing.InOutBounce }
    }
    Behavior on x {
        NumberAnimation { duration: 200; easing.type: Easing.InOutBounce }
    }

}
