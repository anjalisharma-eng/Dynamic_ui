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
        anchors.fill: parent
        color: "transparent"

        GridLayout {
            id: layout
            anchors.fill: parent
            anchors.margins: 20 * scaleFactor
            rowSpacing: 20 * scaleFactor
            columnSpacing: 20 * scaleFactor
            columns: 3
            rows: 4

            // Compass — spans 3 rows, first column
            Loader {
                id: compassPanel
                source: "qrc:/CompassPanelPlugin/CompassPanel.qml"
                Layout.row: 0
                Layout.column: 0
                Layout.rowSpan: 3
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.preferredWidth: parent.width * 0.40
            }

            // Thruster — spans 3 rows, middle column
            Loader {
                id: thrusterPanel
                source: "qrc:/ThrusterPanelPlugin/ThrusterPanel.qml"
                Layout.row: 0
                Layout.column: 1
                Layout.rowSpan: 3
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.preferredWidth: parent.width * 0.38
            }

            // Power — bottom left (smaller height)
            Loader {
                id: powerPanel
                source: "qrc:/PowerPanelPlugin/PowerPanel.qml"
                Layout.row: 3
                Layout.column: 0
                Layout.fillWidth: true
                Layout.fillHeight: false
                Layout.preferredWidth: parent.width * 0.40
                Layout.preferredHeight: parent.height * 0.18
            }

            // Info — bottom middle (same smaller height)
            Loader {
                id: infoPanel
                source: "qrc:/InfoPanelPlugin/InfoPanel.qml"
                Layout.row: 3
                Layout.column: 1
                Layout.fillWidth: true
                Layout.fillHeight: false
                Layout.preferredWidth: parent.width * 0.38
                Layout.preferredHeight: parent.height * 0.18
            }

            // System Summary — right column, spans all rows
            Loader {
                id: summaryPanel
                source: "qrc:/SummaryPanelPlugin/SummaryPanel.qml"
                Layout.row: 0
                Layout.column: 2
                Layout.rowSpan: 4
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.preferredWidth: parent.width * 0.22
            }
        }



    }
}
