import Qt 4.7

Rectangle {
    anchors.fill: parent
    id: setupScreen
    color: "black"
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

    Behavior on opacity {
        NumberAnimation {
            duration: 200
        }
    }

    Rectangle {
        color: parent.color
        border.color: "gray"
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
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.leftMargin: 20
        anchors.topMargin: 100
    }

    MyTextInput {
        id: description
        label: "description"
        anchors.top: user.bottom
        anchors.left: user.left
        anchors.topMargin: 20
    }

    Button {
        id: start
        text: "Start"
        visible: page.state === "recordedBaseline" ? true : false
        anchors.left: description.left
        anchors.top: description.bottom
        anchors.topMargin: 20
        onClicked: {
            page.state = "started";
            page.startRecording(user.text, description.text);
        }
    }

    Button {
        id: recordBaseline
        text: "Rec. Baseline"
        anchors.left: start.left
        anchors.top: start.bottom
        anchors.topMargin: 20
        onClicked: {
            page.state = "recordingBaseline";
            page.startRecording(user.text, description.text+"_BASELINE");
        }
    }

    Button {
        id: quit
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.rightMargin: 20
        anchors.topMargin: 100
        text: "Quit"
        onClicked: Qt.quit()
    }


    Rectangle {
        id: aliveIndicator
        width: 15* (setupScreen.counter+1)/100.0
        height: start.height
        color: "black"
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.leftMargin: 20
        anchors.bottomMargin: 20
    }
}
