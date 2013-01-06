import QtQuick 1.0

Rectangle {
    id: slider
    width: parent.parent.width * 0.9
    height: 20

    color: "black"

    property string name : ""
    smooth: true
    property double value: 0.0
    property double base: 0.0
    property double baseDisplay: 0.0
    property double visValue: 0.0
    property int seenSamples: -1
    property int baseDuration: sliderVis.baseDuration
    property int updater: updateValue()
    property int currentSamplesCollected: -1
    property double currentSamplesMean: 0


    function updateValue()
    {
	seenSamples = seenSamples + 1
	sliderVis.samplesSeen = seenSamples


	if (seenSamples < baseDuration && seenSamples > 0)
	{
	    base = (base * (seenSamples - 1) + value) / seenSamples
	    baseDisplay = Math.round(1000000*base)/1000000
	    visValue = 0.0;
	}
	else
	{
	    ++currentSamplesCollected;
	    currentSamplesMean = (currentSamplesMean * (currentSamplesCollected - 1) + value) / currentSamplesCollected

	    if (currentSamplesCollected == sliderVis.windowDuration)
	    {
		currentSamplesCollected = 0;
		visValue = (currentSamplesMean/base) / sliderVis.maxValue * slider.width;
		if (visValue > slider.width)
		    visValue = slider.width;

		currentSamplesMean = 0.0;
	    }





	}
	return 1;
    }


    Text
    {

	anchors.bottom: parent.top
	anchors.bottomMargin: 5
	anchors.left: parent.left
	text: parent.name
	font.pixelSize: 16

    }

    Text
    {
	anchors.bottom: parent.top
	anchors.bottomMargin:bubble.width/4
	text: parent.baseDisplay
	x: 1 / sliderVis.maxValue * slider.width - width/2

	Behavior on x
	{
	    NumberAnimation {duration: 200; easing.type: Easing.OutSine }
	}

    }

    Text
    {
	anchors.top: parent.bottom
	anchors.left: parent.left
	font.pixelSize: 16
	text: "0"

    }
    Text
    {
	anchors.top: parent.bottom
	anchors.right: parent.right
	text: sliderVis.maxValue * slider.baseDisplay

    }

    Rectangle
    {
	id: bubble
	height: parent.height * 1.3
	width: height
	anchors.verticalCenter: parent.verticalCenter
	x:  parent.visValue - width/2
	color: "red"

	Behavior on x
	{
	    NumberAnimation {duration: 200; easing.type: Easing.OutSine }
	}
    }



}
