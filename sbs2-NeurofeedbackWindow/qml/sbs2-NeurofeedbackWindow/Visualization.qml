import QtQuick 1.0

Rectangle {
    id: squareVisualiztion
    width: 500 // 2/3 of min(screen.width, screen.height)
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
        power = (currentValue - baselineValue) / (maxPower - baselineValue);
        if (power < 0.0)
            power = 0.0;
        if (power > 1.0)
            power = 1.0;

        squareVisualiztion.color = ColorUtils.getColor(power);
    }

}
