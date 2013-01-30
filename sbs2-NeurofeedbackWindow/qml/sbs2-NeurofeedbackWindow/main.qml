import QtQuick 1.0

Rectangle {
    //width: 1280
    //height: 760
    width: 1280
    height: 700
    id: page
    color: "black"

    property string state: "init"
    property bool hasRecordedBaseline: false

    property string title: AppSettings.value("ApplicationName","NeurofeedbackWindow")
    property int colorMap: AppSettings.value("ColorMapNumber",1)

    signal startRecording(string user, string description)
    signal stopRecording()
    signal turnSpectrogramOn(int samples, int length, int delta)
    signal turnSpectrogramOff()
    signal event(string event)

    Timer {
        id: dummyTimer
        interval: 3000
        repeat: false
        onTriggered: handleBaselineRecorded()
    }

    onStateChanged: {
        if (state === "recordingBaseline") {
            setupScreen.opacity = 0;
            dummyTimer.restart() // dummy function (for now)
        } else if (state === "recordedBaseline") {
            setupScreen.opacity = 1
        } else if (state === "started") {
            setupScreen.opacity = 0
        }
    }

    function handleBaselineRecorded() {
        state = "recordedBaseline";
    }

    Component.onCompleted: {
        // Init the color map.
        // TODO:  Make this more dynamic via a settings file.
        ColorUtils.reset();
        switch(colorMap) {
        case 1: {
            ColorUtils.addColor(0.0,   0,   0, 255);  // blue
            ColorUtils.addColor(0.5, 255, 255,   0);  // yellow
            ColorUtils.addColor(1.0, 255,   0,   0);  // red
            break;
        }
        case 2: {
            ColorUtils.addColor(0.0,   0,   0, 255);  // blue
            ColorUtils.addColor(0.5, 127, 127, 127);  // gray
            ColorUtils.addColor(1.0, 255,   0,   0);  // red
            break;
        }
        default: {
            ColorUtils.addColor(0.0,   0,   0,   0);  // black
            ColorUtils.addColor(1.0, 255,   0,   0);  // red
            break;
        }
        }

    }

    Component.onDestruction: {
        // Store the settings.
        AppSettings.setValue("ApplicationName",title);
        AppSettings.setValue("ColorMapNumber",colorMap)
    }

    function valueSlot(value) {
        //console.log("valueSlot() called with " + value);
        visualization.setValue(value);
    }

    SetupScreen {
        id: setupScreen
    }

    Visualization {
        id: visualization
        anchors.centerIn: parent
    }
}
