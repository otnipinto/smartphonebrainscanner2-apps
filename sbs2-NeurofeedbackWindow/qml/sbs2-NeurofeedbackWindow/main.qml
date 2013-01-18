import QtQuick 1.0

Rectangle {
    //width: 1280
    //height: 760
    width: 1280
    height: 700
    id: page

    property string title: AppSettings.value("ApplicationName","NeurofeedbackWindow")

    signal startRecording(string user, string description)
    signal stopRecording()
    signal turnSpectrogramOn(int samples, int length, int delta)
    signal turnSpectrogramOff()
    signal event(string event)

    Component.onDestruction: {
        // Store the settings.
        AppSettings.setValue("ApplicationName",title);
    }

    function valueSlot(value) {
        //console.log("valueSlot() called with " + value);
        visualization.setValue(value);
    }

    SetupScreen {}
    Visualization {
        id: visualization
        anchors.centerIn: parent
    }
}
