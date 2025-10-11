import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    id: thrusterPanel
    property real scale: 1.0
    property real thrusterValue: 0.12
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

    // Outer grid for two sections
    ColumnLayout {
        id: thrusterLayout
        anchors.fill: parent
        anchors.margins: 20 * scale
        spacing: 20 * scale

        // ===============================
        //  TOP BOX — Power Progress Bar
        // ===============================
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
                anchors.margins: 15* scale
                spacing:5 * scale
                Repeater {
                    model: 3
                    delegate: Item {
                        Layout.fillWidth: true
                        Layout.fillHeight: true

                        Row {
                            width: 600
                            anchors.centerIn: parent
                            spacing: 8 * scale

                            Text {
                                width: 237
                                text: "Pod " + (index + 1)+ " MWH"
                                color: "#00eaff"
                                font.pixelSize: 16 * scale
                                horizontalAlignment: Text.AlignHCenter
                            }

                            Text {
                                id: trend
                                width: 60
                                text: thrusterValue.toFixed(2)   // show 2 decimal places
                                color: "white"
                                font.pixelSize: 16 * scale
                                font.bold: true
                                horizontalAlignment: Text.AlignHCenter
                            }

                            ProgressBar {
                                width: 90
                                height: 20
                                value: 20 + index * 5
                            }
                            Text {
                                id:limit
                                text: thrusterValue.toFixed(2)   // show 2 decimal places
                                color: "white"
                                font.pixelSize: 16 * scale
                                font.bold: true
                                horizontalAlignment: Text.AlignHCenter
                            }
                            Text {
                                width: 48
                                text: thrusterValue.toFixed(2)   // show 2 decimal places
                                color: "white"
                                font.pixelSize: 16 * scale
                                font.bold: true
                                horizontalAlignment: Text.AlignHCenter
                            }

                            Text {
                                width: 170
                                text: Math.round(value) + "%"
                                color: "lightgray"
                                font.pixelSize: 13 * scale
                                clip: false
                            }
                        }
                    }
                }

                //                Text {
                //                    text: "Thrust Forecast"
                //                    color: "#00eaff"
                //                    font.pixelSize: 18 * scale
                //                    font.bold: true
                //                    horizontalAlignment: Text.AlignHCenter
                //                    Layout.alignment: Qt.AlignHCenter
                //                }

                //                ProgressBar {
                //                    id: thrustBar
                //                    from: 0
                //                    to: 100
                //                    value: thrusterData.power
                //                    Layout.fillWidth: true
                //                    height: 20 * scale

                //                    background: Rectangle {
                //                        color: "#1b2530"
                //                        radius: 10 * scale
                //                    }

                //                    contentItem: Rectangle {
                //                        color: thrusterData.power > 70 ? "#4caf50" : "#00bcd4"
                //                        radius: 10 * scale
                //                        width: (thrustBar.visualPosition * parent.width)
                //                        height: parent.height
                //                    }
                //                }

                //                Text {
                //                    text: thrusterData.power.toFixed(0) + "%"
                //                    color: "lightgray"
                //                    font.pixelSize: 16 * scale
                //                    horizontalAlignment: Text.AlignHCenter
                //                    Layout.alignment: Qt.AlignHCenter
                //                }
                //            }
            }

            // ===============================
            //  BOTTOM BOX — Thruster Info
            // ===============================
        }

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
                spacing: 10 * scale

                Text {
                    id: text1
                    text: "Direction: " + thrusterData.direction
                    color: "white"
                    font.pixelSize: 18 * scale
                }

                Text {
                    text: "Status: " + thrusterData.status
                    color: thrusterData.status === "Active" ? "#4caf50" : "#f44336"
                    font.pixelSize: 18 * scale
                }

                Rectangle {
                    height: 2 * scale
                    width: parent.width
                    color: "#1e2c63"
                }

                // Extra placeholder (e.g. RPM or pressure)
                Text {
                    text: "RPM: " + Math.round(thrusterData.power * 30)
                    color: "lightgray"
                    font.pixelSize: 16 * scale
                }

                Text {
                    text: "Temperature: " + (30 + thrusterData.power * 0.5).toFixed(1) + " °C"
                    color: "lightgray"
                    font.pixelSize: 16 * scale
                }
            }
        }
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}D{i:9}
}
##^##*/
