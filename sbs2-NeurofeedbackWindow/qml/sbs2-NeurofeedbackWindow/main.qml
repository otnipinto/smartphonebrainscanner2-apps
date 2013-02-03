import QtQuick 1.0

Rectangle {
    width: 1280
    height: 700
    id: page
    color: "black"

    property string state: "init"
    property bool hasRecordedBaseline: false

    property string title: AppSettings.value("ApplicationName","NeurofeedbackWindow")
    property int colorMap: AppSettings.value("ColorMapNumber",1)

    property int accBaselineCount: 0
    property double accBaseline: 0.0
    property alias calculatedBaseline: visualization.baselineValue

    property int badChannelValue: 0
    property int badChannelThreshold: 1000
    property bool isSpectrogramOn: false
    property int seenValues: 0

    signal startRecording(string user, string description)
    signal stopRecording()
    signal turnSpectrogramOn(int samples, int length, int delta)
    signal turnSpectrogramOff()
    signal event(string event)

    Timer {
        id: baselineTimer
        interval: 5 /** 60*/ * 1000  // 5 mins
        repeat: false
        onTriggered: handleBaselineRecorded()
    }

    onStateChanged: {
        if (state === "recordingBaseline") {
            // reset the accumulator
            accBaseline = 0.0;
            accBaselineCount = 0;
            setupScreen.opacity = 0;
            baselineTimer.restart();
            visualization.visible = true;
        } else if (state === "recordedBaseline") {
            if (accBaselineCount > 0)
                calculatedBaseline = accBaseline / accBaselineCount;
            setupScreen.opacity = 1
            visualization.visible = false;
            console.log("Calculated Baseline: "+ calculatedBaseline);
        } else if (state === "started") {
            setupScreen.opacity = 0
            visualization.visible = true;
        } else if (state === "failed") {
            console.log("Too many bad channels/electrodes.  Bailing out.");
            //Qt.quit();
        }
    }

    function handleBaselineRecorded() {
        stopRecording();
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

        if (state === "recordingBaseline") {
            accBaseline += value;
            accBaselineCount++;
            visualization.setDummyValue(Math.random())
        } else
            visualization.setValue(value);
    }

    function cqChanged(channel, value) {

        ++seenValues;
        if (!isSpectrogramOn && seenValues == 28) {
            isSpectrogramOn = true;
            turnSpectrogramOn(128,128,16);
        }

        setupScreen.cqValue(channel,value);

        if (value < 407 && visualization.visible)
            badChannelValue += (407 - value);
        if (badChannelValue >= badChannelThreshold)
            page.state = "failed";
    }

    SetupScreen {
        id: setupScreen
    }

    Visualization {
        id: visualization
        anchors.centerIn: parent
        visible: false

        MouseArea {
            anchors.fill: parent
            onPressAndHold: {
                Qt.quit();
            }
        }
    }
}
