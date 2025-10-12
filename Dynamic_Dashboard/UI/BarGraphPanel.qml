import QtQuick 2.15
import QtQuick.Controls 2.15
import QtCharts 2.15

Rectangle {
    id: root
    width: 500
    height: 150
    color: "#2b2b2b"
    radius: 10

    property string params: ""

    Text {
        anchors.centerIn: parent
        text: "BarGraph Panel\nParams: " + root.params
        color: "white"
        font.pixelSize: 18
        horizontalAlignment: Text.AlignHCenter
    }
}
