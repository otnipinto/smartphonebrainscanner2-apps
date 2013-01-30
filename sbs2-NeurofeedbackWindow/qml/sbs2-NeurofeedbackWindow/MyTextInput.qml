import Qt 4.7

Item
{
    id: myTextInput
    property alias label : label.text
    property alias text : textInput.text

    width: 280
    height: 80


    Rectangle {
        id: input
        anchors.fill: parent
        color: "lightGray"
        border.color: "black"

        Rectangle {
            id: clearField
            width: 40
            height: width
            color: parent.color
            border.width: 1
            border.color: "black"
            anchors.left: parent.right
            anchors.verticalCenter: parent.verticalCenter
            Text {
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                text: "X"
                font.bold: true
                font.pointSize: 20
                color: "black"
            }
            MouseArea {
                anchors.fill: parent
                onClicked: textInput.text = ""
            }
        }

        TextInput {
            id: textInput

            width: 200
            height: 80

            color: "black"
            font.bold: true
            font.pointSize: 20
            cursorVisible: false

            smooth: true
            anchors.fill: parent
            anchors.leftMargin: 10
            anchors.topMargin: 30
        }

        Text {
            id: label
            anchors.left: parent.left
            anchors.top: parent.top
            font.pixelSize: 14
            anchors.leftMargin: 5
            anchors.topMargin: 5
            font.italic: true
            color: "gray"
        }
    }

}
