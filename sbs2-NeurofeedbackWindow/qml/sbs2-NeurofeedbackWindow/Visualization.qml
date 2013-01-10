import QtQuick 1.0

Rectangle {
    id: squareVisualiztion
    width: 100
    height: width
    color: "gray"
    property double currentValue: 0.0
    property double baselineValue: 20.0
    property double power: 0.0
    property double maxPower: 100.0

    function setValue(value) {
        currentValue = value;
        /*if (maxPower < value) {
            maxPower = value;
            console.debug("New max: " + maxPower);
        }*/
        if (value < baselineValue && value > 10) {
            baselineValue = value;
            console.debug("New min: " + baselineValue);
        }
        setColor();
    }

    function setBaseline(value) {
        baselineValue = value;
    }

    function setColor() {
        //TODO: function translating value/baseline into color
        var r = 0.0;
        var g = 0.0;
        var b = 0.0;

        //if (power == 0)
          //  return Qt.rgba(0.5,0.5,0.5,1);

        power = (currentValue - baselineValue) / (maxPower - baselineValue);
/*
        if (power < 0.6 * maxPower)
        {
            r = 75.0 - 2.3 * power;
            g = 172.0 - 4.6 * power;
            b = 198.0 - 5.2 * power;
        }
        else
        {
            r = 195.0 + 4.125 * (power - 0.6 * maxPower);
            g = 214.0 - 13.25 * (power - 0.6 * maxPower);
            b = 155.0 - 18.125 * (power - 0.6 * maxPower);
        }
        r = r / 256.0;
        g = g / 256.0;
        b = b / 256.0;
*/

        r = power;
        g = 1.0 - (power > 0.5 ? power - 0.5 : power);
        b = 1.0-power;

        //return Qt.rgba(r,g,b,1)
        squareVisualiztion.color = Qt.rgba(r,g,b,1);
/*
        if (currentValue > baselineValue)
            squareVisualiztion.color = "red"
        if (currentValue == baselineValue)
            squareVisualiztion.color = "gray"
        if (currentValue < baselineValue)
            squareVisualiztion.color = "blue"*/
    }

}
