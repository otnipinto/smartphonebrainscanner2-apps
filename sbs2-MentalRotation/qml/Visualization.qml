import QtQuick 1.1

Rectangle {
    id: squareVisualiztion
    width: 500 // 2/3 of min(screen.width, screen.height)
    height: width
    color: "gray"
    property double currentValue: 0.0
    property double baselineValue: 20.0
    property double power: 0.0

    property double minPower: 10.0
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

    onBaselineValueChanged: {
        minPower = baselineValue * 0.5;
        maxPower = baselineValue * 2.0;
    }

    function setValue(value) {
        currentValue = value;

        setColor();
    }

    function setBaseline(value) {
        baselineValue = value;
    }

    function setColor() {
        power = (currentValue - minPower) / (maxPower - minPower);
        if (power < 0.0)
            power = 0.0;
        if (power > 1.0)
            power = 1.0;

        if (shapeHasDynamicSize)
            squareVisualiztion.width = 450.0 + ((power-0.5) * 200.0);

        squareVisualiztion.color = ColorUtils.getColor(power);
    }

    function setDummyValue(power) {
        if (power < 0.0)
            power = 0.0;
        if (power > 1.0)
            power = 1.0;

        squareVisualiztion.color = ColorUtils.getColor(power);
    }

}
