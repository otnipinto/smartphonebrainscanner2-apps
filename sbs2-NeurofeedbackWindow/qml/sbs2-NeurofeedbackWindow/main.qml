import QtQuick 1.0

Rectangle {
    width: 1280
    height: 760
    id: page
    property string title: "NeurofeedbackWindow"

    function valueSlot(value)
    {

    }

    SetupScreen{}
    Visualization{anchors.centerIn: parent}
}
