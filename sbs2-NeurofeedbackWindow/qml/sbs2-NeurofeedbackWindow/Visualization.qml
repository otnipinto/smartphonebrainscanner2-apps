import QtQuick 1.0

Rectangle {
    width: 100
    height: width
    color: "gray"
    id: squareVisualiztion
    property double currentValue: 0
    property double baselineValue: 0

    function setValue(value) {
        currentValue = value;
        setColor();
    }

    function setBaseline(value) {
        baselineValue = value;
    }

    function setColor() {
        //TODO: function translating value/baseline into color
        if (currentValue > baselineValue)
            squareVisualiztion.color = "red"
        if (currentValue == baselineValue)
            squareVisualiztion.color = "gray"
        if (currentValue < baselineValue)
            squareVisualiztion.color = "blue"
    }

}
