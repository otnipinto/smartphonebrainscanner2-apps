import QtQuick 1.0

Rectangle {
    id: squareVisualiztion
    width: 100
    height: width
    color: "gray"
    property double currentValue: 0.0
    property double baselineValue: 20.0
    property double power: 0.0
    property double maxPower: 200.0

    property bool shapeHasDynamicSize: AppSettings.value("ShapeHasDynamicSize",true)

    Component.onDestruction: {
        // Store the settings.
        // This will ensure that the default setting will be stored
        // if the setting file is just created/the value was never stored.
        // But also useful if the code is changed to allow user modification
        // of settings at runtime.
        AppSettings.setValue("ShapeHasDynamicSize",shapeHasDynamicSize);
    }

    function setValue(value) {
        currentValue = value;
        /*if (maxPower < value) {
            maxPower = value;
            console.debug("New max: " + maxPower);
        }*/
        if (currentValue > maxPower)
            currentValue = maxPower;
        if (value < baselineValue && value > 10) {
            baselineValue = value;
            console.debug("New min: " + baselineValue);
        }

        if (shapeHasDynamicSize)
            squareVisualiztion.width = currentValue;

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
        if (power < 0.0)
            power = 0.0;
        if (power > 1.0)
            power = 1.0;

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
        var tmpg = power - 0.5;
        g = 1.0 - 2.0*(tmpg > 0 ? tmpg : -tmpg);
        b = 1.0 - power*2.0;
        b = b > 1.0 ? 1.0 : b

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
