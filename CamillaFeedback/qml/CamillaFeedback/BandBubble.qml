import QtQuick 1.0

Rectangle {
    width: 100
    height: width
    radius: width/2
    property string name : ""
    smooth: true


    Text {
	anchors.centerIn: parent
	text: parent.name
    }
}
