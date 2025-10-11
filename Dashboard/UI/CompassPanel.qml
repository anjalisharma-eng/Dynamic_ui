//import QtQuick 2.15
//import QtQuick.Controls 2.15

//Rectangle {
//    id: compassPanel
//    property real scale: 1.0
//    width: 600*scale                // Increased size from 480 → 600
//    height: width             // Keep square shape
//    color: "#263238"
//    radius: 12
//    border.color: "#1f464b"
//    border.width: 3
//    clip: true                // Prevents image overflow beyond rounded border

//    anchors {
//        top: parent.top
//        left: parent.left
//        topMargin: 10
//        leftMargin: 10
//    }

//    // Compass background image
//    Image {
//        id: image
//        anchors.centerIn: parent
//        width: parent.width * 0.95
//        height: width
//        opacity: 0.63
//        source: "qrc:/Dynamic_Dashboard/CompasDial.png"
//        fillMode: Image.PreserveAspectFit
//    }

//    // Inner dial circle overlay
//    Rectangle {
//        id: dial
//        anchors.centerIn: parent
//        width: parent.width * 0.78   // Slightly increased to match new panel
//        height: width
//        color: "#30343d"
//        radius: width / 2
//        border.color: "#1e2c63"
//        border.width: Math.max(3, width * 0.005)
//        anchors.verticalCenterOffset: -11
//        anchors.horizontalCenterOffset: 0

//        // Pointer / needle
//        Rectangle {
//            id: pointer
//            anchors.centerIn: parent
//            width: Math.max(4, dial.width * 0.015)
//            height: dial.radius
//            color: "#090e26"
//            radius: width / 2
//            border.color: "#5065b5"
//            anchors.verticalCenterOffset: -106
//            anchors.horizontalCenterOffset: 0

//            transform: Rotation {
//                id: rotateTransform
//                origin.x: pointer.width / 2
//                origin.y: pointer.height
//                angle: compassData.angle
//            }
//        }

//        // Direction label (e.g., N, E, S, W)
//        Text {
//            id: directionText
//            text: compassData.direction
//            color: "white"
//            font.pixelSize: Math.max(18, dial.height * 0.07)
//            anchors.horizontalCenter: parent.horizontalCenter
//            anchors.bottom: parent.bottom
//            anchors.bottomMargin: dial.height * 0.05
//        }

//        // Degree label (e.g., 230°)
//        Text {
//            id: degreeText
//            text: compassData.angle.toFixed(0) + "°"
//            color: "lightgray"
//            font.pixelSize: Math.max(14, dial.height * 0.05)
//            anchors.horizontalCenter: parent.horizontalCenter
//            anchors.top: parent.top
//            anchors.topMargin: dial.height * 0.05
//        }
//    }
//}
import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    id: compassPanel
    property real scale: 1.0
    height: 700   // passed from main.qml

    Layout.fillWidth: true
    Layout.fillHeight: true
    Layout.preferredWidth: 1    // ✅ allows GridLayout to size it
    Layout.preferredHeight: 1

    color: "#263238"
    radius: 12 * scale
    border.color: "#1f464b"
    border.width: 3 * scale
    clip: true

    // Compass background image
    Image {
        id: image
        anchors.centerIn: parent
        width: parent.width * 0.95
        height: width
        opacity: 0.63
        source: "qrc:/Dynamic_Dashboard/CompasDial.png"
        fillMode: Image.PreserveAspectFit
    }

    // Inner dial circle
    Rectangle {
        id: dial
        anchors.centerIn: parent
        width: parent.width * 0.78
        height: width
        color: "#30343d"
        radius: width / 2
        border.color: "#1e2c63"
        border.width: Math.max(3 * scale, width * 0.005)
        anchors.verticalCenterOffset: -12
        anchors.horizontalCenterOffset: 1

        // Pointer - full radius, pivot at center
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

        // Direction label
        Text {
            id: directionText
            y: 570
            text: compassData.direction
            color: "white"
            font.pixelSize: 20 * scale
            anchors.horizontalCenterOffset: -183
            anchors.bottomMargin: -97
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
        }

        // Degree label
        Text {
            id: degreeText
            text: compassData.angle.toFixed(0) + "°"
            color: "lightgray"
            font.pixelSize: 16 * scale
            anchors.horizontalCenterOffset: -164
            anchors.topMargin: -78
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
        }
    }
}

/*##^##
Designer {
    D{i:0;formeditorZoom:0.75}D{i:1}
}
##^##*/
