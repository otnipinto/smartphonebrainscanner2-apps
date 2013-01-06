import QtQuick 1.0

Rectangle {
    anchors.fill: parent
    id: squareVis
    color: "black"

    property int samplesSeen: 0
    property int baseDuration: 80
    property int windowDuration: 8
    property int maxValue : 2


    Grid
    {
	id: slidersGrid
	anchors.top: parent.top
	anchors.topMargin: 40
	anchors.horizontalCenter: parent.horizontalCenter
	columns: 1
	spacing: 40


	//Slider{id: one; name:  dataHandler.bands[0].regionName + " " + dataHandler.bands[0].name;  value: dataHandler.bands[0].value }
	Square{id: one; name: dataHandler.bands[0].regionName + " " + dataHandler.bands[0].name; value: dataHandler.bands[0].value}
    }

//Controls{id: controls; anchors.left: parent.left; anchors.bottom: parent.bottom}

}
