import QtQuick 1.0

Rectangle {
    anchors.fill: parent
    id: sliderVis
    color: "white"

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


	Slider{id: one; name:  dataHandler.bands[0].regionName + " " + dataHandler.bands[0].name;  value: dataHandler.bands[0].value }
	Slider{id: two; name:  dataHandler.bands[1].regionName + " " + dataHandler.bands[1].name;  value: dataHandler.bands[1].value }
	Slider{id: three; name:  dataHandler.bands[2].regionName + " " + dataHandler.bands[2].name;  value: dataHandler.bands[2].value }

	Slider{id: four; name:  dataHandler.bands[3].regionName + " " + dataHandler.bands[3].name;  value: dataHandler.bands[3].value }
	Slider{id: five; name:  dataHandler.bands[4].regionName + " " + dataHandler.bands[4].name;  value: dataHandler.bands[4].value }
	Slider{id: six; name:  dataHandler.bands[5].regionName + " " + dataHandler.bands[5].name;  value: dataHandler.bands[5].value }

    }

Controls{id: controls; anchors.left: parent.left; anchors.bottom: parent.bottom}

}
