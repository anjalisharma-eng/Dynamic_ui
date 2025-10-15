import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    id: compassPanel
    property real scale: 1.0

    Layout.fillWidth: true
    Layout.fillHeight: true

    color: "#263238"
    radius: 12 * scale
    border.color: "#1f464b"
    border.width: 3 * scale
    clip: true

    // Responsive sizing
    property real compassSize: Math.min(width, height) * 0.9

    // Compass background image
    Image {
        id: image
        anchors.centerIn: parent
        width: compassPanel.compassSize
        height: width
        opacity: 0.63
        source: "qrc:/Dynamic_Dashboard/CompasDial.png"
        fillMode: Image.PreserveAspectFit
    }

    // Inner dial circle
    Rectangle {
        id: dial
        anchors.centerIn: parent
        width: compassPanel.compassSize * 0.78
        height: width
        color: "#30343d"
        radius: width / 2
        border.color: "#1e2c63"
        border.width: Math.max(3 * scale, width * 0.005)

        // Pointer — resizes with dial
        Rectangle {
            id: pointer
            width: Math.max(4 * scale, dial.width * 0.015)
            height: parent.width*0.5 //245
            color: "#090e26"
            radius: width / 2
            border.color: "#5065b5"
            anchors.horizontalCenter: parent.horizontalCenter

            transform: Rotation {
                origin.x: pointer.width / 2
                origin.y: pointer.height
                angle: compassData.angle
            }
        }

        // Direction label (N, E, S, W)
        Text {
            id: directionText
            text: compassData.direction
            color: "white"
            font.pixelSize: dial.width * 0.07
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: dial.width * 0.1
        }

        // Degree label
        Text {
            id: degreeText
            text: compassData.angle.toFixed(0) + "°"
            color: "lightgray"
            font.pixelSize: dial.width * 0.06
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: dial.width * 0.1
        }
    }
}
