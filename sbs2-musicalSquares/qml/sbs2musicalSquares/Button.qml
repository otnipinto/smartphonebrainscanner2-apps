import Qt 4.7

Rectangle {
    width: 180
    height: 60
    color: {if (isEnabled) return "black"; return "gray";}
    property string desc
    x: 0
    y: 0
    property int isEnabled: 0


    Text {
	color: "white"
	text: parent.desc
	font.pointSize: 20
	anchors.centerIn: parent
	font.bold: true
    }

    MouseArea
    {
	anchors.fill: parent
	onClicked:
	{
	    if (!isEnabled)
		return;

	    if (parent.desc == "quit")
		Qt.quit();
	    if (parent.desc == "start")
	    {
		page.start();
	    }
	}
    }
}
