import QtQuick 1.0

Rectangle {
    id: square
    width: parent.parent.width
    height: parent.parent.height

    color: "black"

    property string name : ""
    smooth: true
    property double value: 0.0
    //property double base: 0.0
    property double base: 0
    property double baseDisplay: 0.0
    property double visValue: 0.0
    property int seenSamples: -1
    property int baseDuration: squareVis.baseDuration
    property int updater: updateValue()
    property int currentSamplesCollected: 0
    property double currentSamplesMean: 0
    property double scale: 2.0
    property int baselineSet: 0
    property int timeTicks: 0
    property int duration: 300
    property int finished: 0
    property int control: 0

    function timeUpdate()
    {

	++timeTicks;
	if (timeTicks == duration)
	{
	    baselineSet = 0;
	    finished = 1;
	}

	if (control)
	{

	    if (timeTicks % parseInt((Math.random() + 1) * 2) == 0 )
	    {
		if (Math.random() < 0.5)
		{
		    visRectangle.r_value = 0.8;
		    visRectangle.b_value = 0.0;
		}
		else
		{
		    visRectangle.b_value = 0.8;
		    visRectangle.r_value = 0.0;

		}
	    }
	}

    }


    Timer
    {
	interval: 1000; running: baselineSet; repeat: true
	onTriggered: timeUpdate()
    }

    function updateValue()
    {

	if (baselineSet == 0)
	    return 0;



	base = parseFloat(baselineTextInput.text);
	scale = parseFloat(scaleTextInput.text);
	seenSamples = seenSamples + 1
	squareVis.samplesSeen = seenSamples



	++currentSamplesCollected;
	currentSamplesMean = (currentSamplesMean * (currentSamplesCollected - 1) + value) / currentSamplesCollected



	if (seenSamples == 0)
	{
	    --currentSamplesCollected;
	    currentSamplesMean = 0;
	    return 0;
	}


	if (control)
	    return 1;


	if (currentSamplesCollected == squareVis.windowDuration)
	{

	    currentSamplesCollected = 0;
	    visValue = (currentSamplesMean/base)
	    console.log(visValue);
	    console.log(currentSamplesMean);
	    console.log(base);
	    currentSamplesMean = 0.0;
	}


	if (visValue > 1)
	{
	    visRectangle.b_value = 0;
	    visRectangle.r_value = Math.min((visValue - 1) * 0.8 / (scale -1), 0.8);

	}
	if (visValue <= 1)
	{
	    visRectangle.r_value = 0;
	    visRectangle.b_value = Math.min((1 - visValue) * scale * 0.8, 0.8);

	}




/*

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

	    if (currentSamplesCollected == squareVis.windowDuration)
	    {
		currentSamplesCollected = 0;
		visValue = (currentSamplesMean/base) / squareVis.maxValue * square.width;
		if (visValue > square.width)
		    visValue = square.width;

		currentSamplesMean = 0.0;
	    }





	}
	*/
	return 1;

    }



    Rectangle
    {
	id: visRectangle
	anchors.horizontalCenter: parent.horizontalCenter
	anchors.top: parent.top

	height: parent.height * 0.8
	width: height
	property double r_value: 0
	property double b_value: 0
	color: Qt.rgba(0.2 + r_value,0.2,0.2 + b_value,1)
	visible: square.baselineSet
    }

    Rectangle
    {
	border.width: 1
	border.color: "white"
	height: 40
	width: 100
	anchors.left: parent.left
	color: "black"
	opacity: 0.5
	Text
	{
	    anchors.bottom: parent.top
	    text: "baseline"
	    color: "white"
	}

	TextInput
	{

	    id: baselineTextInput
	    color: "white"
	    height: 30
	    width: parent.width
	    anchors.centerIn: parent
	    horizontalAlignment: TextInput.AlignHCenter
	    cursorVisible: false
	    cursorDelegate: Rectangle{opacity: 0}
	}


    }

    Rectangle
    {
	visible: !square.baselineSet
	color: "black"
	opacity: 1
	height: 200
	width: 400
	anchors.centerIn: parent
	MouseArea
	{
	    anchors.fill: parent
	    onClicked:
	    {
		if (! isNaN(parseFloat(baselineTextInput.text)) || square.control)
		{
		    console.log(parseFloat(baselineTextInput.text));
		    square.baselineSet = 1;

		}


	    }
	}

	Text
	{
	    text: "start"
	    font.pixelSize: 200
	    anchors.centerIn: parent
	    color: "white"
	}
    }



    Rectangle
    {
	border.width: 1
	border.color: "white"
	height: 40
	width: 100
	anchors.left: parent.left
	color: "black"
	opacity: 0.5
	y: 100
	Text
	{
	    anchors.bottom: parent.top
	    text: "scale"
	    color: "white"
	}

	TextInput
	{

	    id: scaleTextInput
	    color: "white"
	    height: 30
	    width: parent.width
	    anchors.centerIn: parent
	    horizontalAlignment: TextInput.AlignHCenter
	    cursorVisible: false
	    cursorDelegate: Rectangle{opacity: 0}
	    text: "2.0"


	}
    }

    Text
    {
	text: "samples "+square.seenSamples
	color: "white"
	opacity: 0.5
	anchors.left: parent.left
	y: 200
    }
    Text
    {
	text: "power "+square.visValue
	color: "white"
	opacity: 0.5
	anchors.left: parent.left
	y: 300
    }
    Text
    {
	text: "time "+timeTicks+"s"
	color: "white"
	opacity: 0.5
	anchors.left: parent.left
	y: 400
    }
    Text
    {
	text: { return "mean "+Math.floor(square.currentSamplesMean*100000)/100000;}
	color: "white"
	opacity: 0.5
	anchors.left: parent.left
	y: 350
    }

    Rectangle
    {
	visible: finished
	anchors.fill: parent
	color: "black"
	MouseArea
	{
	    anchors.fill: parent
	    onClicked:
	    {
		Qt.quit();
	    }
	}

	Text
	{
	    text: {if (square.control) return "finished "+currentSamplesMean; return "finished";}
	    font.pixelSize: 50
	    color: "white"
	    anchors.centerIn: parent
	}
    }

    Rectangle
    {
	color: {if (square.control) return "white"; return "black"; }
	border.width: 1
	border.color: "white"
	width: 250
	height: 60
	anchors.horizontalCenter: parent.horizontalCenter
	visible: !square.baselineSet
	Text
	{

	    color: {if (square.control) return "black"; return "white"; }
	    text: {if (square.control) return "baseline recording ON"; return "baseline recording OFF"; }
	    anchors.centerIn: parent


	}

	MouseArea
	{
	    anchors.fill: parent
	    onClicked:
	    {
		square.control = !square.control
	    }
	}

    }

    /*
    Rectangle
    {
	color: "pink"
	height: 40
	width: 40
	MouseArea
	{
	    anchors.fill: parent
	    onClicked:
	    {
		square.value = Math.random() * 4;


	    }
	}
    }
    */

    /*

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
	x: 1 / squareVis.maxValue * square.width - width/2

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
	text: squareVis.maxValue * square.baseDisplay

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

*/

}
