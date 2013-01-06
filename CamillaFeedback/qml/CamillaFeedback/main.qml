//import QtQuick 1.0
import QtQuick 1.0

Rectangle {
    id: mainWindow

    function dataReceived(data)
    {
	//console.log("main: " +data);
	dataHandler.dataReceived(data);
    }

 DataHandler{id: dataHandler}
 //SliderVis{id: sliderVis}
 SquareVis{id: squareVis}

    width: 800
    height: 480
    color: "pink"

}
