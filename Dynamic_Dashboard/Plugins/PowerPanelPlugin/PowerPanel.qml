import QtQuick 2.15
import QtQuick.Controls 2.15

Rectangle {
    id: powerPanel
    color: "#1f1f29"
    radius: 10
    border.color: "#03a9f4"
    border.width: 2

    property string params: ""

    Column {
        anchors.centerIn: parent
        spacing: 10

        Text {
            text: "Power Overview"
            color: "white"
            font.pixelSize: 18
            horizontalAlignment: Text.AlignHCenter
            width: parent.width
        }

        ProgressBar {
            id: powerBar
            from: 0
            to: powerData.totalPower
            value: powerData.usedPower
            width: parent.width * 0.8
            height: 12
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Text {
            text: "Used: " + powerData.usedPower.toFixed(1) + " MW"
            color: "#ff9800"
            font.pixelSize: 16
        }

        Text {
            text: "Available: " + powerData.availablePower.toFixed(1) + " MW"
            color: "#4caf50"
            font.pixelSize: 16
        }
    }

    Behavior on color {
        ColorAnimation { duration: 500 }
    }
}
