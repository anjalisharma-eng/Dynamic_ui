//import QtQuick 2.15
//import QtQuick.Controls 2.15
//import QtCharts 2.15

////Rectangle {
////    id: forecastPanel
////    width: 400
////    height: 250
////    color: "#1b1f2a"
////    radius: 10
////    border.color: "#00bcd4"
////    border.width: 2

////    Column {
////        anchors.fill: parent
////        anchors.margins: 10
////        spacing: 8

////        property string params: ""

////        Text {
////            text: "Forecast Data"
////            color: "#ffffff"
////            font.pixelSize: 20
////            font.bold: true
////        }

////        ChartView {
////            id: chart
////            width: parent.width - 20
////            height: 180
////            antialiasing: true
////            backgroundColor: "transparent"
////            legend.visible: false

////            ValueAxis {
////                id: yAxis
////                min: 0
////                max: 100
////                labelsColor: "#ffffff"
////            }

////            ValueAxis {
////                id: xAxis
////                min: 0
////                max: 10
////                labelsColor: "#ffffff"
////            }

////            LineSeries {
////                id: forecastSeries
////                axisX: xAxis
////                axisY: yAxis
////                color: "#03a9f4"
////                width: 2

////                // Dynamic data update
////                Component.onCompleted: {
////                    for (let i = 0; i < forecastData.forecastValues.length; ++i)
////                        append(i, forecastData.forecastValues[i])
////                }

////                Connections {
////                    target: forecastData
////                    function onDataChanged() {
////                        clear()
////                        for (let i = 0; i < forecastData.forecastValues.length; ++i)
////                            append(i, forecastData.forecastValues[i])
////                    }
////                }
////            }
////        }

////        Row {
////            spacing: 20

////            Text { text: "Min: " + forecastData.minValue.toFixed(1); color: "#8bc34a" }
////            Text { text: "Avg: " + forecastData.avgValue.toFixed(1); color: "#ffc107" }
////            Text { text: "Max: " + forecastData.maxValue.toFixed(1); color: "#f44336" }
////        }
////    }

//Rectangle {
//    width: 1140
//    height: 150
//    color: "transparent"
//    property string params: ""

//    ChartView {
//        anchors.fill: parent
//        theme: ChartView.ChartThemeDark
//        antialiasing: true
//        legend.visible: false

//        ValueAxis {
//            id: axisX
//            min: 0
//            max: 10
//        }

//        ValueAxis {
//            id: axisY
//            min: 0
//            max: 100
//        }

//        LineSeries {
//            id: forecastSeries
//            axisX: axisX
//            axisY: axisY
//            color: "#00e676"

//            Component.onCompleted: {
//                forecastData.onDataChanged.connect(updateData)
//                updateData()
//            }

//            function updateData() {
//                clear()
//                let values = forecastData.forecastValues
//                for (let i = 0; i < values.length; ++i)
//                    append(i, values[i])
//            }
//        }
//    }
//}
import QtQuick 2.15
import QtQuick.Controls 2.15
import QtCharts 2.15

Rectangle {
    id: forecastPanel
    color: "transparent"
    radius: 8
    border.color: "#00bcd4"
    border.width: 1

    ChartView {
        anchors.fill: parent
        theme: ChartView.ChartThemeDark
        antialiasing: true
        legend.visible: false

        ValueAxis {
            id: xAxis
            min: 0
            max: 10
        }

        ValueAxis {
            id: yAxis
            min: 0
            max: 100
        }

        LineSeries {
            id: series
            axisX: xAxis
            axisY: yAxis
            useOpenGL: true
            color: "#00e676"
            width: 2
            // The series comes directly from C++
            Component.onCompleted: forecastPanel.addSeries()
        }
    }

    function addSeries() {
        if (forecastData.series)
            chart.addSeries(forecastData.series, xAxis, yAxis)
    }
}

