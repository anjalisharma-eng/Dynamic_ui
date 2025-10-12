import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    id: thrusterPanel
    property real scale: 1.0
    property var thrusterData: ({
        power: 65,             // %
        direction: "Forward",  // or "Reverse"
        status: "Active"       // or "Idle"
    })

    Layout.fillWidth: true
    Layout.fillHeight: true
    Layout.minimumWidth: 400 * scale
    Layout.minimumHeight: 250 * scale

    color: "#263238"
    radius: 12 * scale
    border.color: "#1f464b"
    border.width: 3 * scale
    clip: true

    ColumnLayout {
        id: thrusterLayout
        anchors.fill: parent
        anchors.margins: 20 * scale
        spacing: 20 * scale

        // ==========================================================
        //  TOP BOX — Thruster Forecast Section (like screenshot top)
        // ==========================================================
        Rectangle {
            id: powerBox
            Layout.fillWidth: true
            Layout.fillHeight: true
            color: "#30343d"
            radius: 10 * scale
            border.color: "#1e2c63"
            border.width: 2 * scale
            anchors.margins: 10 * scale

            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 15 * scale
                spacing: 10 * scale

                // Header row
                RowLayout {
                    Layout.fillWidth: true
                    spacing: 30 * scale
                    Text { text: "Pod"; color: "#00eaff"; font.bold: true; font.pixelSize: 15 * scale }
                    Text { text: "Trend (8H)"; color: "#00eaff"; font.bold: true; font.pixelSize: 15 * scale }
                    Text { text: "Forecasted (8H MPE)"; color: "#00eaff"; font.bold: true; font.pixelSize: 15 * scale }
                    Text { text: "Limit"; color: "#00eaff"; font.bold: true; font.pixelSize: 15 * scale }
                    Text { text: "Alarm In"; color: "#00eaff"; font.bold: true; font.pixelSize: 15 * scale }
                }

                // Data rows (Pods)
                Repeater {
                    model: 4
                    delegate: RowLayout {
                        Layout.fillWidth: true
                        spacing: 30 * scale

                        Text {
                            text: "Pod " + (index + 1) + " MWh"
                            color: "white"
                            font.pixelSize: 12 * scale
                            width: 120 * scale
                        }

                        Text {
                            text: (index % 2 === 0 ? "+1.2" : "+0.1")
                            color: "#ff6f61"
                            font.pixelSize: 12 * scale
                            width: 70 * scale
                        }

                        // Forecast bar
                        Rectangle {
                            width: 100 * scale
                            height: 18 * scale
                            radius: 4 * scale
                            color: (index % 2 === 0 ? "#ffa726" : "#4caf50") // orange or green
                            border.color: "#222"
                            Text {
                                anchors.centerIn: parent
                                text: (index % 2 === 0 ? "2.6" : "3.2")
                                color: "white"
                                font.pixelSize: 11.5 * scale
                                font.bold: true
                            }
                        }

                        Text {
                            text: (index % 2 === 0 ? "3.0" : "5.0")
                            color: "white"
                            font.pixelSize: 12 * scale
                            width: 50 * scale
                        }

                        Text {
                            text: (index % 2 === 0 ? "21 h" : "-")
                            color: (index % 2 === 0 ? "red" : "lightgray")
                            font.pixelSize: 12 * scale
                            width: 50 * scale
                        }
                    }
                }
            }
        }

        // ==========================================================
        //  BOTTOM BOX — Auxiliary Power Selection (like screenshot bottom)
        // ==========================================================
        Rectangle {
            id: infoBox
            Layout.fillWidth: true
            Layout.fillHeight: true
            color: "#30343d"
            radius: 10 * scale
            border.color: "#1e2c63"
            border.width: 2 * scale
            anchors.margins: 10 * scale

            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 15 * scale
                spacing: 15 * scale

                // Header Row
                RowLayout {
                    Layout.fillWidth: true
                    spacing: 40 * scale
                    Text { text: "Auxiliary"; color: "#00eaff"; font.bold: true; font.pixelSize: 15 * scale }
                    Text { text: "Available Power"; color: "#00eaff"; font.bold: true; font.pixelSize: 15 * scale }
                    Text { text: "Max Available (MWh)"; color: "#00eaff"; font.bold: true; font.pixelSize: 15 * scale }
                }

                // Auxiliary Rows
                Repeater {
                    model: 2
                    delegate: RowLayout {
                        Layout.fillWidth: true
                        spacing: 40 * scale

                        Text {
                            text: "Aux " + (index + 1) + " MWh"
                            color: "white"
                            font.pixelSize: 12 * scale
                            width: 120 * scale
                        }

                        Rectangle {
                            width: 100 * scale
                            height: 18 * scale
                            radius: 4 * scale
                            color: "#2196f3"
                            border.color: "#222"
                            Text {
                                anchors.centerIn: parent
                                text: (index === 0 ? "2.6" : "3.2")
                                color: "white"
                                font.pixelSize: 11.5 * scale
                                font.bold: true
                            }
                        }

                        Text {
                            text: "5.0"
                            color: "white"
                            font.pixelSize: 12 * scale
                            width: 50 * scale
                        }
                    }
                }
            }
        }
    }
}
