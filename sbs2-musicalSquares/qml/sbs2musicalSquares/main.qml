// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1

//TODO: connect slot


Rectangle {
    id: page
    width: 1280
    height: 800
    color: "black"
    property string title: "musical squares"

    property int baselineLength: 60*1000
    property int experimentLength: 3*60*1000 //changed from 5*60*1000
    property int bins: 15 //Changed from 20
    property double binDuration: experimentLength/bins

    property int binSize: page.width / bins

    property int eventWindowSize: 1 * 1000
    property int eventDelta: 250 //In msec, how often do events happen

    property int maxEventsNumber: binDuration/eventDelta
    property int maxRectanglesInBin: 10
    property int currentBinNumber: -1
    property double baselineEeg: 1

    property int visualizationVisible: 0
    property int setupScreenVisible: 0
    property int baselineRecording: 1
    property int eventCounter: 0
    property int updateFreq: 8
    property int timeTick: 1/updateFreq * 1000
    property int finished: 0

    property double currentBaseline: 0
    property double currentScore: 0

    property int badChannelValue: 0
    property int badChannelThreshold: 1000
    property int failed: 0

    property int isSpectrogramOn: 0
    property int seenValues: 0

    Visualization{id: visualization; visible: visualizationVisible}
    SetupScreen{id: setupScreen; visible: setupScreenVisible}

    function start()
    {

	if (!baselineRecording) baselineEeg = setupScreen.baselineValue
	startRecording(setupScreen.userText, setupScreen.descTest);

	state = "visualization"

    }

    signal startRecording(string user, string description)
    signal stopRecording()
    signal turnSpectrogramOn(int samples, int length, int delta)
    signal turnSpectrogramOff()
    signal event(string event)


    function powerValue(value)
    {


	if (!visualizationVisible)
	    return;


	page.event("value_"+value);

	if (baselineRecording)
	    currentBaseline += value;

	//console.log(value+ " "+currentBaseline+ " "+currentBaseline/eventCounter);

	if (baselineRecording)
	    value = Math.random() * 4


	//console.log(eventCounter+ " "+eventCounter*timeTick+ " "+eventDelta);
	if ((eventCounter*timeTick) >= baselineLength) // Changed from experimentLength
	{
	    page.state = "finished"

	}

	if (!baselineRecording)
	    currentScore += value/baselineEeg;

	if ((eventCounter*timeTick)%binDuration == 0)
	{
	    currentBinNumber += 1
	}
	if ((eventCounter*timeTick)%eventDelta  == 0)
	{

	    visualization.event(currentBinNumber, value);
	}



	eventCounter += 1;

    }

    function cqChanged(channel, value)
    {

	++seenValues;
	if (!isSpectrogramOn && seenValues == 28)
	{
	    isSpectrogramOn = 1;
	    turnSpectrogramOn(128,128,16);
	}

	setupScreen.cqValue(channel,value);

	if (value < 407 && visualizationVisible) badChannelValue += (407 - value);
	if (badChannelValue >= badChannelThreshold) page.state="failed";
    }


    state: "setupScreen"

    states: [
	State {
	    name: "setupScreen"
	    PropertyChanges {
		target: page
		visualizationVisible: 0
		setupScreenVisible: 1
		finished: 0
	    }
	},
	State {
	    name: "visualization"
	    PropertyChanges {
		target: page
		visualizationVisible: 1
		setupScreenVisible: 0
		finished: 0
	    }
	},
	State {
	    name: "finished"
	    PropertyChanges {
		target: page
		finished: 1
		visualizationVisible: 0
		setupScreenVisible: 0
	    }
	},
	State {
	    name: "failed"
	    PropertyChanges {
		target: page
		failed: 1
		finished: 0
		visualizationVisible: 0
		setupScreenVisible: 0

	    }
	}
    ]


    Rectangle
    {
	id: finishedRect
	visible: page.finished
	width: parent.width
	height: parent.height
	color: "black"

	Text{
	    color: "white"
	    anchors.centerIn: parent
	    text: {if (page.baselineRecording) return "finished, baseline: "+page.currentBaseline/page.eventCounter; return "finished, score: "+currentScore/page.eventCounter}
	    font.pixelSize: 50
	}

	MouseArea
	{
	    anchors.fill: parent
	    onPressAndHold:
	    {
		Qt.quit();
	    }
	}
    }

    Rectangle
    {
	id: failedRect
	visible: page.failed
	width: parent.width
	height: parent.height
	color: "black"

	Text{
	    color: "white"
	    anchors.centerIn: parent
	    text: "channel quality too low!"
	    font.pixelSize: 50
	}

	MouseArea
	{
	    anchors.fill: parent
	    onPressAndHold:
	    {
		Qt.quit();
	    }
	}
    }

/*
    Timer
    {
	id: minorTimer
	running: page.visualizationVisible
	interval: 125
	repeat: true
	onTriggered:
	{
	    powerValue(Math.random() * 4 );
	}

    }
*/

}
