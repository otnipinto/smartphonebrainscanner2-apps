import QtQuick 1.0

Rectangle {
    anchors.fill: parent
    id: simpleVis
    color: "green"
    property double maxValueRegion1 : getMaxValue(1)
    property double minValueRegion1 : getMinValue(1)
    property double maxValueRegion2 : getMaxValue(2)
    property double minValueRegion2 : getMinValue(2)

    function getMaxValue(regionIndex)
    {
	var tempMaxValue = -1

	for (var band = (regionIndex - 1) * 3; band < regionIndex*3; ++band)
	{

	    if (dataHandler.bands[band].value > tempMaxValue)
	    {
		tempMaxValue = dataHandler.bands[band].value;
	    }
	}
	return tempMaxValue;
    }

    function getMinValue(regionIndex)
    {
	var tempMinValue = 999

	for (var band = (regionIndex - 1) * 3; band < regionIndex*3; ++band)
	{

	    if (dataHandler.bands[band].value < tempMinValue)
	    {
		tempMinValue = dataHandler.bands[band].value;
	    }
	}
	return tempMinValue;
    }

    Text {
	id: textMax
	text: "max 1: "+parent.maxValueRegion1 + " max 2: "+parent.maxValueRegion2
    }
    Text {
	id: textMin
	anchors.top: textMax.bottom
	text: "min 1: "+parent.minValueRegion1 + " min 2: "+parent.minValueRegion2
    }


    Grid
    {
	anchors.centerIn: parent
	columns: 3
	spacing: 2


	BandBubble{id: one; name: dataHandler.bands[0].name; color: "red"; width: dataHandler.bands[0].value/simpleVis.maxValueRegion1 * 100 }
	BandBubble{id: two; name: dataHandler.bands[1].name; color: "blue"; width: dataHandler.bands[1].value/simpleVis.maxValueRegion1 * 100}
	BandBubble{name: dataHandler.bands[2].name; color: "magenta"; width: dataHandler.bands[2].value/simpleVis.maxValueRegion1 * 100}

	BandBubble{name: dataHandler.bands[3].name; color: "red"; width: dataHandler.bands[3].value/simpleVis.maxValueRegion2 * 100}
	BandBubble{name: dataHandler.bands[4].name; color: "blue"; width: dataHandler.bands[4].value/simpleVis.maxValueRegion2 * 100}
	BandBubble{name: dataHandler.bands[5].name; color: "magenta"; width: dataHandler.bands[5].value/simpleVis.maxValueRegion2 * 100}

    }




}
