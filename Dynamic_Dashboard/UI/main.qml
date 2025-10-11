import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Window 2.15

ApplicationWindow {
    id: root
    visible: true
    width: Screen.width
    height: Screen.height
    color: "#1e1e2e"
    title: "Dynamic Dashboard"

    property real baseWidth: 1600
    property real baseHeight: 900
    property real scaleFactor: Math.min(width / baseWidth, height / baseHeight)

    Behavior on scaleFactor { NumberAnimation { duration: 250; easing.type: Easing.InOutQuad } }

    Rectangle {
        id: dashboard
        anchors.topMargin: 3
        anchors.fill: parent
        color: "transparent"

        GridLayout {
            id: layout
            anchors.fill: parent
            anchors.margins: 20 * scaleFactor
            rowSpacing: 20 * scaleFactor
            columnSpacing: 20 * scaleFactor
            columns: 2

            Repeater {
                id: dynamicRepeater
                model: configLoader.components

                delegate: Loader {
                    id: panelLoader
                    source: modelData.source
                    property real scale: scaleFactor

                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    Layout.row: modelData.row ?? Math.floor(index / layout.columns)
                                                 Layout.column: modelData.col ?? index % layout.columns

                                                                                 onLoaded: if (item && item.hasOwnProperty("scale")) item.scale = scale

                    onStatusChanged: {
                        if (status === Loader.Error)
                            console.error("❌ Error loading:", modelData.source, ":", panelLoader.errorString)
                        else if (status === Loader.Ready)
                            console.log("✅ Loaded", modelData.source, "at", Layout.row, Layout.column)
                    }
                }
            }
        }
    }

//    Text {
//        text: "Dynamic Ship System Dashboard"
//        anchors.top: parent.top
//        anchors.horizontalCenter: parent.horizontalCenter
//        anchors.topMargin: 8
//        color: "#00eaff"
//        font.pixelSize: 22 * scaleFactor
//        font.bold: true
//    }
}
