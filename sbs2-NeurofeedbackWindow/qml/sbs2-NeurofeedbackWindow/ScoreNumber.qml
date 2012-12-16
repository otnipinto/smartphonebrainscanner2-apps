import QtQuick 1.0

Rectangle {
    width: 100
    height: width
    id: scoreNumber
    color: "black"
    property int value: 0
    Text
    {
	color: {if (parent.color == "#000000") return "red"; return "black"}
	anchors.centerIn: parent
	text: parent.value
    }

    MouseArea
    {
	anchors.fill: parent
	onClicked:
	{
	    score.setScore(scoreNumber.value)
	}
    }

}
