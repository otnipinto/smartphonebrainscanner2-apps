// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1

Rectangle {
    anchors.horizontalCenter: parent.horizontalCenter
    width: 0//parent.width
    height: width
    property string name: "musicalSquare"
    opacity: 0//0.5
    radius: 0
    smooth: true
    property int myIndex: 0
    property double power: 0
    property double maxPower: 0
    rotation: Math.random() * 10 - 5

    Behavior on opacity {
	NumberAnimation{duration: 250}
    }

    Behavior on width {
	NumberAnimation{duration: 1000; easing.type: Easing.OutBack}
    }



    color: {
	var r = 0;
	var g = 0;
	var b = 0;

	//if (power == 0)
	  //  return Qt.rgba(0.5,0.5,0.5,1);

	if (power < 0.6 * maxPower)
	{
	    r = 75 - 2.3 * power;
	    g = 172 - 4.6 * power;
	    b = 198 - 5.2 * power;
	}
	else
	{
	    r = 195 + 4.125 * (power - 0.6 * maxPower);
	    g = 214 - 13.25 * (power - 0.6 * maxPower);
	    b = 155 - 18.125 * (power - 0.6 * maxPower);
	}
	r = r / 256;
	g = g / 256;
	b = b / 256;


	return Qt.rgba(r,g,b,1)
    }





/*
    Text
    {
	anchors.centerIn: parent
	text: parent.myIndex
    }
*/

}
