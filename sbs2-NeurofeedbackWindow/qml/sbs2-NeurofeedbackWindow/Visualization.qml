import QtQuick 1.0

Rectangle {
    width: 100
    height: width
    color: "gray"
    id: squareVisualiztion
    property double currentValue: 0
    property double baselineValue: 0
    property double power: 0
    property double maxPower: 0

    function setValue(value) {
        currentValue = value;
        setColor();
    }

    function setBaseline(value) {
        baselineValue = value;
    }

    function setColor() {
        //TODO: function translating value/baseline into color
        var r = 0;
        var g = 0;
        var b = 0;

        //if (power == 0)
          //  return Qt.rgba(0.5,0.5,0.5,1);

        power = currentValue

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

        if (currentValue > baselineValue)
            squareVisualiztion.color = "red"
        if (currentValue == baselineValue)
            squareVisualiztion.color = "gray"
        if (currentValue < baselineValue)
            squareVisualiztion.color = "blue"
    }

}
