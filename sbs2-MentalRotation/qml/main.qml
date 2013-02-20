import QtQuick 1.1

Rectangle {
    width: 1280
    height: 700
    id: page
    color: "black"

    property string state: "init"
    property bool hasRecordedBaseline: false

    property string title: AppSettings.value("ApplicationName","MentalRotation")

    property int accBaselineCount: 0
    property double accBaseline: 0.0
    property double calculatedBaseline: 0.0
    property bool hasBaseline: false

    property int badChannelValue: 0
    property int badChannelThreshold: 1000
    property bool isSpectrogramOn: false
    property int seenValues: 0

    // For now, this is just in the ini file.
    property int preTestBaselineDuration:  AppSettings.value("PreTestBaselineDuration",5 * 60 * 1000)  // 5 mins
    property int testDuration:  AppSettings.value("TestDuration",5 * 60 * 1000)  // 5 mins
    property int postTestBaselineDuration:  AppSettings.value("PostTestBaselineDuration",5 * 60 * 1000)  // 5 mins

    signal startRecording(string user, string description)
    signal stopRecording()
    signal turnSpectrogramOn(int samples, int length, int delta)
    signal turnSpectrogramOff()
    signal event(string event)

    property bool isPortrait: false

    onWidthChanged: checkOrientation()
    onHeightChanged: checkOrientation()

    function checkOrientation() {
        if (page.width < page.height)
            isPortrait = true;
        else
            isPortrait = false;
    }

    onStateChanged: {
        if (state === "recordingPreTestBaseline") {
            // reset the accumulator
            accBaseline = 0.0;
            accBaselineCount = 0;
            setupScreen.opacity = 0;
            preTestBaselineTimer.restart();
            experimentView.visible = true;
        } else if (state === "recordingPostTestBaseline") {
            // reset the accumulator
            accBaseline = 0.0;
            accBaselineCount = 0;
            setupScreen.opacity = 0;
            postTestBaselineTimer.restart();
            experimentView.visible = true;
        } else if (state === "recordedBaseline") {
            if (accBaselineCount > 0)
                calculatedBaseline = accBaseline / accBaselineCount;
            setupScreen.opacity = 1
            experimentView.visible = false;
            hasBaseline = true;
            console.log("Calculated Baseline: "+ calculatedBaseline);
        } else if (state === "recordedTest") {
            setupScreen.opacity = 1
            experimentView.visible = false;
            console.log("Recorded test");
        } else if (state === "started") {
            setupScreen.opacity = 0
            experimentView.visible = true;
            testTimer.restart();
        } else if (state === "failed") {
            console.log("Too many bad channels/electrodes.  Bailing out.");
            //Qt.quit();
        }
    }

    Timer {
        id: preTestBaselineTimer
        interval: preTestBaselineDuration
        repeat: false
        onTriggered: handleBaselineRecorded()
    }

    Timer {
        id: postTestBaselineTimer
        interval: postTestBaselineDuration
        repeat: false
        onTriggered: handleBaselineRecorded()
    }

    function handleBaselineRecorded() {
        stopRecording();
        state = "recordedBaseline";
    }

    Timer {
        id: testTimer
        interval: testDuration
        repeat: false
        onTriggered: handleTestRecorded()
    }

    function handleTestRecorded() {
        stopRecording();
        state = "recordedTest";
    }

    Component.onCompleted: {
    }

    Component.onDestruction: {
        // Store the settings.
        AppSettings.setValue("ApplicationName",title);
        AppSettings.setValue("PreTestBaselineDuration", preTestBaselineDuration);
        AppSettings.setValue("TestDuration", testDuration);
        AppSettings.setValue("PostTestBaselineDuration", postTestBaselineDuration);

    }

    function valueSlot(value) {
        //console.log("valueSlot() called with " + value);
        if (state === "recordingPreTestBaseline" || state === "recordingPostTestBaseline") {
            accBaseline += value;
            accBaselineCount++;
            experimentView.setDummyValue(Math.random())
        } else
            experimentView.setValue(value);
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
        /*if (badChannelValue >= badChannelThreshold)
            page.state = "failed";*/
    }

    SetupScreen {
        id: setupScreen
    }

    MentalRotationView {
        id: experimentView
        anchors.centerIn: parent

        visible: false

        MouseArea {
            anchors.fill: parent
            onPressAndHold: {
                Qt.quit();
            }
        }
    }

    /*
    Visualization {
        id: experimentView
        anchors.centerIn: parent
        visible: false

        MouseArea {
            anchors.fill: parent
            onPressAndHold: {
                Qt.quit();
            }
        }
    }
    */
}
