import QtQuick 2.15
import QtQuick.Controls 2.15

Rectangle {
    id: infoPanel
    width: 300
    height: 200
    color: "#1e1e2d"
    radius: 10
    border.color: "#03a9f4"
    border.width: 2

    property string params: ""

    Column {
        anchors.centerIn: parent
        spacing: 8

        Text {
            text: "System Info"
            color: "#ffffff"
            font.pixelSize: 20
            font.bold: true
            horizontalAlignment: Text.AlignHCenter
            width: parent.width
        }

        Text {
            text: "Speed: " + infoData.speed.toFixed(1) + " knots"
            color: "#ffb300"
            font.pixelSize: 16
        }

        Text {
            text: "Heading: " + infoData.heading.toFixed(0) + "°"
            color: "#03a9f4"
            font.pixelSize: 16
        }

        Text {
            text: "Wind: " + infoData.windSpeed.toFixed(1) + " m/s"
            color: "#8bc34a"
            font.pixelSize: 16
        }

        Text {
            text: "Temperature: " + infoData.temperature.toFixed(1) + " °C"
            color: "#f44336"
            font.pixelSize: 16
        }
    }

    Behavior on color {
        ColorAnimation { duration: 300 }
    }
}
