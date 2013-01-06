// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1

Rectangle {
    width: page.width
    height: page.height
    color: "black"

    function event (binNumber, value)
    {
	children[binNumber].event(value);
    }

    Repeater
    {
	model: page.bins
	Bin{x: page.binSize * index + 5}
    }

}
