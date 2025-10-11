import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
    id: root
    width: 300
    height: 120

    // ✅ Declare this property first
    property string params: "Default Status"

    Rectangle {
        anchors.fill: parent
        color: "#2E3B4E"
        radius: 10
        border.color: "white"
        border.width: 1
        opacity: 0.95
    }

    property string params: ""

    Text {
        anchors.centerIn: parent
        text: root.params      // ✅ use the declared property here
        color: "white"
        font.pixelSize: 20
        font.bold: true
    }
}
