import QtQuick 1.0

Rectangle {


    id: controls
    color: "black"
    width: parent.width
    height: 80
    property int horizontalSpacing: 10


    function reset()
    {

	one.base = 0.0
	one.baseDisplay = 0.0
	one.visValue = 0.0
	one.currentSamplesMean = 0
	one.seenSamples = -2
	one.currentSamplesCollected = -2


	two.base = 0.0
	two.baseDisplay = 0.0
	two.visValue = 0.0

	two.currentSamplesMean = 0
	two.seenSamples = -2
	two.currentSamplesCollected = -2


	three.base = 0.0
	three.baseDisplay = 0.0
	three.visValue = 0.0

	three.currentSamplesMean = 0
	three.seenSamples = -2
	three.currentSamplesCollected = -2


	four.base = 0.0
	four.baseDisplay = 0.0
	four.visValue = 0.0

	four.currentSamplesMean = 0
	four.seenSamples = -2
	four.currentSamplesCollected = -2


	five.base = 0.0
	five.baseDisplay = 0.0
	five.visValue = 0.0

	five.currentSamplesMean = 0
	five.seenSamples = -2
	five.currentSamplesCollected = -2


	six.base = 0.0
	six.baseDisplay = 0.0
	six.visValue = 0.0

	six.currentSamplesMean = 0
	six.seenSamples = -2
	six.currentSamplesCollected = -2


    }

    function resetSamples()
    {

	one.currentSamplesCollected = 0
	two.currentSamplesCollected = 0
	three.currentSamplesCollected = 0
	four.currentSamplesCollected = 0
	five.currentSamplesCollected = 0
	six.currentSamplesCollected = 0

    }


    Grid
    {
	id: textGrid
	anchors.left: parent.left
	anchors.leftMargin: controls.horizontalSpacing
	anchors.verticalCenter: parent.verticalCenter
	columns: 1
	spacing: 5

	Text
	{
	    color: "white"
	    id: samplesSeenText
	    font.pixelSize: 20
	    text: "samples " + sliderVis.samplesSeen
	}




    }

    Rectangle
    {
	id: resetButton
	width: 60
	height: 60
	color:"white"
	anchors.left:textGrid.right
	anchors.leftMargin: controls.horizontalSpacing
	anchors.verticalCenter: parent.verticalCenter

	Rectangle
	{
	    width: parent.width / 20
	    height: 20
	    color: "white"
	    anchors.bottom: parent.top
	    anchors.horizontalCenter: parent.horizontalCenter
	}

	Text {
	    color: "black"
	    text: "reset"
	    anchors.centerIn: parent
	}

	Behavior on x
	{
	    NumberAnimation {duration: 200; easing.type: Easing.OutSine }
	}

	MouseArea
	{
	    anchors.fill: parent
	    onClicked:
	    {

		reset();




	    }
	}


    }


    Rectangle
    {
	id: scallingButton
	width: 120
	height: 60
	color:"white"
	anchors.left: resetButton.right
	anchors.leftMargin: controls.horizontalSpacing
	anchors.verticalCenter: parent.verticalCenter

	Rectangle
	{
	    width: parent.width / 20
	    height: 20
	    color: "white"
	    anchors.bottom: parent.top
	    anchors.horizontalCenter: parent.horizontalCenter
	}

	Rectangle
	{
	    width: parent.width/2
	    height: parent.height
	    color: "gray"
	    anchors.left: parent.left
	    anchors.verticalCenter: parent.verticalCenter

	    Text {
		text: "-"
		anchors.centerIn: parent
	    }

	    MouseArea
	    {
		anchors.fill: parent
		onClicked:
		{
		    sliderVis.maxValue = Math.max(1,sliderVis.maxValue-1)
		}
	    }


	}

	Rectangle
	{
	    width: parent.width/2
	    height: parent.height
	    color: "darkGray"
	    anchors.right: parent.right
	    anchors.verticalCenter: parent.verticalCenter

	    Text {
		text: "+"
		anchors.centerIn: parent
	    }

	    MouseArea
	    {
		anchors.fill: parent
		onClicked:
		{
		    sliderVis.maxValue = Math.min(10,sliderVis.maxValue+1)
		}
	    }


	}

	Text {
	    color: "black"
	    text: "scalling"
	    font.pixelSize: 16
	    anchors.verticalCenter: parent.verticalCenter
	    anchors.horizontalCenter: parent.horizontalCenter
	    anchors.verticalCenterOffset: -20


	    Text {
		color: "black"
		text: sliderVis.maxValue
		anchors.horizontalCenter: parent.horizontalCenter
		anchors.top: parent.bottom
	    }
	}

	Behavior on x
	{
	    NumberAnimation {duration: 200; easing.type: Easing.OutSine }
	}
    }


    Rectangle
    {
	id: baselineDurationButton
	width: 120
	height: 60
	color:"white"
	anchors.left: scallingButton.right
	anchors.leftMargin: controls.horizontalSpacing
	anchors.verticalCenter: parent.verticalCenter

	Rectangle
	{
	    width: parent.width / 20
	    height: 20
	    color: "white"
	    anchors.bottom: parent.top
	    anchors.horizontalCenter: parent.horizontalCenter
	}

	Rectangle
	{
	    width: parent.width/2
	    height: parent.height
	    color: "gray"
	    anchors.left: parent.left
	    anchors.verticalCenter: parent.verticalCenter

	    Text {
		text: "-"
		anchors.centerIn: parent
	    }

	    MouseArea
	    {
		anchors.fill: parent
		onClicked:
		{
		    sliderVis.baseDuration = Math.max(1,sliderVis.baseDuration-1);
		    reset();
		}
	    }


	}

	Rectangle
	{
	    width: parent.width/2
	    height: parent.height
	    color: "darkGray"
	    anchors.right: parent.right
	    anchors.verticalCenter: parent.verticalCenter

	    Text {
		text: "+"
		anchors.centerIn: parent
	    }

	    MouseArea
	    {
		anchors.fill: parent
		onClicked:
		{
		    sliderVis.baseDuration = Math.min(1000,sliderVis.baseDuration+1)
		    reset();
		}
	    }


	}

	Text {
	    color: "black"
	    text: "baseline"
	    font.pixelSize: 16
	    anchors.verticalCenter: parent.verticalCenter
	    anchors.horizontalCenter: parent.horizontalCenter
	    anchors.verticalCenterOffset: -20


	    Text {
		color: "black"
		text: sliderVis.baseDuration
		anchors.horizontalCenter: parent.horizontalCenter
		anchors.top: parent.bottom
	    }
	}

	Behavior on x
	{
	    NumberAnimation {duration: 200; easing.type: Easing.OutSine }
	}
    }

    Rectangle
    {
	id: windowDurationButton
	width: 120
	height: 60
	color:"white"
	anchors.left: baselineDurationButton.right
	anchors.leftMargin: controls.horizontalSpacing
	anchors.verticalCenter: parent.verticalCenter

	Rectangle
	{
	    width: parent.width / 20
	    height: 20
	    color: "white"
	    anchors.bottom: parent.top
	    anchors.horizontalCenter: parent.horizontalCenter
	}

	Rectangle
	{
	    width: parent.width/2
	    height: parent.height
	    color: "gray"
	    anchors.left: parent.left
	    anchors.verticalCenter: parent.verticalCenter

	    Text {
		text: "-"
		anchors.centerIn: parent
	    }

	    MouseArea
	    {
		anchors.fill: parent
		onClicked:
		{
		    sliderVis.windowDuration = Math.max(1,sliderVis.windowDuration-1);
		    resetSamples()
		}
	    }


	}

	Rectangle
	{
	    width: parent.width/2
	    height: parent.height
	    color: "darkGray"
	    anchors.right: parent.right
	    anchors.verticalCenter: parent.verticalCenter

	    Text {
		text: "+"
		anchors.centerIn: parent
	    }

	    MouseArea
	    {
		anchors.fill: parent
		onClicked:
		{
		    sliderVis.windowDuration = Math.min(1000,sliderVis.windowDuration+1)
		    resetSamples()
		}
	    }


	}

	Text {
	    color: "black"
	    text: "window"
	    font.pixelSize: 16
	    anchors.verticalCenter: parent.verticalCenter
	    anchors.horizontalCenter: parent.horizontalCenter
	    anchors.verticalCenterOffset: -20


	    Text {
		color: "black"
		text: sliderVis.windowDuration
		anchors.horizontalCenter: parent.horizontalCenter
		anchors.top: parent.bottom
	    }
	}

	Behavior on x
	{
	    NumberAnimation {duration: 200; easing.type: Easing.OutSine }
	}
    }

    Rectangle
    {
	id: quitButton
	width: 60
	height: 60
	color:"darkred"
	anchors.right: controls.right
	anchors.rightMargin: controls.horizontalSpacing
	anchors.verticalCenter: parent.verticalCenter

	Rectangle
	{
	    width: parent.width / 20
	    height: 20
	    color: "darkred"
	    anchors.bottom: parent.top
	    anchors.horizontalCenter: parent.horizontalCenter
	}

	Text {
	    color: "black"
	    text: "quit"
	    anchors.centerIn: parent
	}

	Behavior on x
	{
	    NumberAnimation {duration: 200; easing.type: Easing.OutSine }
	}

	MouseArea
	{
	    anchors.fill: parent
	    onClicked:
	    {

		Qt.quit();




	    }
	}


    }




}
