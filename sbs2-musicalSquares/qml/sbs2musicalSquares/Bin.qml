// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1

Rectangle {
    width: page.binSize * 0.8
    height: page.height * 0.8
    color: page.color
    anchors.verticalCenter: page.verticalCenter
    property int eventNumber: 0
    property int allowedChildIndex: 0
    property int startingDir: -2
    property double maxPowerRatio: 4
    property int eventsPerSquare: page.maxEventsNumber/page.maxRectanglesInBin

    Repeater
    {
	model: page.maxRectanglesInBin
	MusicalSquare{
	    y: {

		if (startingDir == -2)
		{
		    var u = Math.random() - 0.5;
		    startingDir = u/Math.abs(u);
		}

		var v = parent.height/2;
		var dir = startingDir
		//if (index%2 == 0) dir = -startingDir
		if (index%3 == 0) dir = -startingDir
		if (index >= 4) dir = -1
		v += 200

		if (dir == -1)
		    v += 150*dir*(index/3) + (Math.random()-0.5)*80
		else
		    v += 100*dir*(index/3) + (Math.random()-0.5)*80
		return v;
	    }
	    myIndex: index
	    maxPower: eventsPerSquare * maxPowerRatio
	}
    }

    function event(power)
    {
	//eventNumber += 1
	//allowedChildIndex = eventNumber/page.maxEventsNumber * (page.maxRectanglesInBin-1)

	if (power > page.baselineEeg)
	    addMusicalSquare(power);
	else
	    removeMusicalSquare();
    }

    function addMusicalSquare(power)
    {

	eventNumber += 1
	//Here we choose the square that we are currently working on, increase opacity randomly by some value and change color of the square based on the collected power.

	var currentSquare = parseInt((eventNumber-1)/page.maxEventsNumber * page.maxRectanglesInBin)
	//console.log("::: "+currentSquare+" "+eventNumber+ " "+page.maxEventsNumber + " "+page.maxRectanglesInBin)
	if (children[currentSquare].opacity == 0) children[currentSquare].opacity = 0.3
	children[currentSquare].width = width
	children[currentSquare].opacity += 0.1;
	children[currentSquare].power += Math.min(power/page.baselineEeg, maxPowerRatio);

    }

    function removeMusicalSquare()
    {

    }

}
