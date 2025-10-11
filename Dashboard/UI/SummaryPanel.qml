import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    id: summaryPanel
    width: 800
    height: 200
    radius: 10
    color: "#1e1e2e"
    border.color: "#00bcd4"
    border.width: 2

    property alias power: powerText.text
    property alias thruster: thrusterText.text
    property alias forecast: forecastText.text
    property alias info: infoText.text

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 12
        spacing: 8

        Text {
            text: "System Summary"
            color: "#00eaff"
            font.pixelSize: 22
            font.bold: true
            Layout.alignment: Qt.AlignHCenter
        }

        GridLayout {
            columns: 2
            rowSpacing: 6
            columnSpacing: 40
            Layout.alignment: Qt.AlignHCenter

            // Power Summary
            Rectangle {
                width: 350; height: 70; radius: 8
                color: "#24243e"
                border.color: "#0088cc"
                Column {
                    anchors.centerIn: parent
                    spacing: 4

                    property string params: ""

                    Text { text: "Power Available:"; color: "#aaaaaa"; font.pixelSize: 14 }
                    Text {
                        id: powerText
                        text: powerData ? (powerData.availablePower.toFixed(2) + " MW") : "--"
                        color: "#00ffcc"
                        font.pixelSize: 18
                        font.bold: true
                    }
                }
            }

            // Thruster Summary
            Rectangle {
                width: 350; height: 70; radius: 8
                color: "#24243e"
                border.color: "#ff7f50"
                Column {
                    anchors.centerIn: parent
                    spacing: 4
                    Text { text: "Thruster Trend:"; color: "#aaaaaa"; font.pixelSize: 14 }
                    Text {
                        id: thrusterText
                        text: thrusterData ? thrusterData.trend : "--"
                        color: thrusterData && thrusterData.trend === "Up" ? "#00ff66"
                               : thrusterData && thrusterData.trend === "Down" ? "#ff3333" : "#ffff66"
                        font.pixelSize: 18
                        font.bold: true
                    }
                }
            }

            // Forecast Summary
            Rectangle {
                width: 350; height: 70; radius: 8
                color: "#24243e"
                border.color: "#33cc33"
                Column {
                    anchors.centerIn: parent
                    spacing: 4
                    Text { text: "Forecast Avg:"; color: "#aaaaaa"; font.pixelSize: 14 }
                    Text {
                        id: forecastText
                        text: forecastData ? (forecastData.avgValue.toFixed(1) + " %") : "--"
                        color: "#00ff99"
                        font.pixelSize: 18
                        font.bold: true
                    }
                }
            }

            // Info Summary
            Rectangle {
                width: 350; height: 70; radius: 8
                color: "#24243e"
                border.color: "#3399ff"
                Column {
                    anchors.centerIn: parent
                    spacing: 4
                    Text { text: "Ship Speed:"; color: "#aaaaaa"; font.pixelSize: 14 }
                    Text {
                        id: infoText
                        text: infoData ? (infoData.speed.toFixed(1) + " knots") : "--"
                        color: "#33ccff"
                        font.pixelSize: 18
                        font.bold: true
                    }
                }
            }
        }
    }

    // Smooth pulsing border animation
    SequentialAnimation on border.color {
        loops: Animation.Infinite
        ColorAnimation { to: "#00bcd4"; duration: 1000 }
        ColorAnimation { to: "#004466"; duration: 1000 }
    }
}
