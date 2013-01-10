import QtQuick 1.0

Rectangle {
    //width: 1280
    //height: 760
    width: 1280
    height: 700


    id: page
    property string title: "NeurofeedbackWindow"

    function valueSlot(value)
    {

    }

    SetupScreen{}
    Visualization{anchors.centerIn: parent}

    function event(msg) {
        console.debug(msg);
    }
}
