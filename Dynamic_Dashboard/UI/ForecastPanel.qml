////import QtQuick 2.15
////import QtQuick.Controls 2.15
////import QtCharts

////Rectangle {
////    id: forecastPanel
////    width: 640
////    height: 480
////    color: "#1e1f26"
////    radius: 8
////    border.color: "#1e2c63"
////    border.width: 2

////    property var forecastData: ({ series: null })   // optional: external data source

////    ChartView {
////        id: chart
////        anchors.fill: parent
////        antialiasing: true
////        theme: ChartView.ChartThemeDark
////        backgroundColor: "#1e1f26"
////        legend.visible: true
////        legend.labelColor: "#cfd8dc"
////        legend.alignment: Qt.AlignTop

////        // ===== X-Axis (Time / Hour) =====
////        ValueAxis {
////            id: xAxis
////            min: 0
////            max: 48
////            tickCount: 9
////            labelFormat: "%.0fh"
////            labelsColor: "#cfd8dc"
////            gridLineColor: "#37474f"
////        }

////        // ===== Y-Axis (Power in MWh) =====
////        ValueAxis {
////            id: yAxis
////            min: 0
////            max: 9
////            tickCount: 10
////            labelsColor: "#cfd8dc"
////            gridLineColor: "#37474f"
////        }

////        // ===== Blue Bars: Planned Power =====
////        BarSeries {
////            id: barSeries
////            axisX: xAxis
////            axisY: yAxis
////            name: "Power [MWh] forecast @ planned heading"

////            BarSet {
////                color: "#2196f3"
////                label: "Planned"
////                borderColor: "transparent"
////                values: [6.3, 6.1, 6.4, 6.5, 6.2, 6.0, 6.3, 6.7, 6.4, 6.2, 6.5, 6.1]
////            }
////        }

////        // ===== Red Line: Best Heading =====
////        LineSeries {
////            id: lineSeries
////            axisX: xAxis
////            axisY: yAxis
////            name: "Power [MWh] @ best heading"
////            color: "#e53935"
////            width: 2
////            useOpenGL: true

////            XYPoint { x: 0;  y: 3.2 }
////            XYPoint { x: 6;  y: 3.4 }
////            XYPoint { x: 12; y: 3.6 }
////            XYPoint { x: 18; y: 3.8 }
////            XYPoint { x: 24; y: 3.9 }
////            XYPoint { x: 30; y: 4.0 }
////            XYPoint { x: 36; y: 4.1 }
////            XYPoint { x: 42; y: 4.2 }
////            XYPoint { x: 48; y: 4.3 }
////        }

////        Component.onCompleted: {
////            // optional: dynamically attach external data series
////            if (forecastData.series)
////                chart.addSeries(forecastData.series, xAxis, yAxis)

////            // force correct scaling (avoid negative values)
////            yAxis.min = 0
////            yAxis.max = 9
////        }
////    }

////    // === Optional dynamic function for runtime updates ===
////    function addSeries() {
////        if (forecastData.series)
////            chart.addSeries(forecastData.series, xAxis, yAxis)
////    }
////}

/////*##^##
////Designer {
////    D{i:0;autoSize:true;height:480;width:640}
////}
////##^##*/
//import QtQuick 2.15
//import QtQuick.Controls 2.15
//import QtCharts 2.15

//Rectangle {
//    id: forecastPanel
//    width: 640
//    height: 480
//    color: "#1e1f26"
//    radius: 8
//    border.color: "#1e2c63"
//    border.width: 2

//    // Delay chart loading until visible to avoid OpenGL init crash
//    property bool chartReady: false

//    Component.onCompleted: {
//        // Wait a short time so the window's scenegraph is fully initialized
//        Qt.callLater(() => chartReady = true)
//    }

//    Loader {
//        id: chartLoader
//        anchors.fill: parent
//        active: forecastPanel.chartReady
//        asynchronous: true

//        sourceComponent: ChartView {
//            id: chart
//            anchors.fill: parent
//            antialiasing: true
//            theme: ChartView.ChartThemeDark
//            backgroundColor: "#1e1f26"
//            legend.visible: true
//            legend.labelColor: "#cfd8dc"
//            legend.alignment: Qt.AlignTop

//            ValueAxis { id: xAxis; min: 0; max: 48; tickCount: 9; labelsColor: "#cfd8dc" }
//            ValueAxis { id: yAxis; min: 0; max: 9; tickCount: 10; labelsColor: "#cfd8dc" }

//            BarSeries {
//                id: barSeries
//                axisX: xAxis
//                axisY: yAxis
//                name: "Power [MWh] forecast @ planned heading"
//                BarSet {
//                    label: "Planned"
//                    color: "#2196f3"
//                    borderColor: "transparent"
//                    values: [6.3, 6.1, 6.4, 6.5, 6.2, 6.0, 6.3, 6.7, 6.4, 6.2, 6.5, 6.1]
//                }
//            }

//            LineSeries {
//                id: lineSeries
//                axisX: xAxis
//                axisY: yAxis
//                name: "Power [MWh] @ best heading"
//                color: "#e53935"
//                width: 2
//                XYPoint { x: 0;  y: 3.2 }
//                XYPoint { x: 6;  y: 3.4 }
//                XYPoint { x: 12; y: 3.6 }
//                XYPoint { x: 18; y: 3.8 }
//                XYPoint { x: 24; y: 3.9 }
//                XYPoint { x: 30; y: 4.0 }
//                XYPoint { x: 36; y: 4.1 }
//                XYPoint { x: 42; y: 4.2 }
//                XYPoint { x: 48; y: 4.3 }
//            }
//        }
//    }
//}
import QtQuick 2.15
import QtQuick.Controls 2.15
import QtCharts 2.15

Rectangle {
    id: forecastPanel
    color: "#1e1f26"
    radius: 8
    border.color: "#1e2c63"
    border.width: 2

    property bool chartReady: false

    Component.onCompleted: Qt.callLater(() => chartReady = true)

    Loader {
        id: chartLoader
        anchors.fill: parent
        active: forecastPanel.chartReady
        asynchronous: true

        sourceComponent: ChartView {
            id: chart
            anchors.fill: parent
            antialiasing: true
            theme: ChartView.ChartThemeDark
            backgroundColor: "#1e1f26"
            legend.visible: true
            legend.labelColor: "#cfd8dc"
            legend.alignment: Qt.AlignTop

            // X-axis (time or intervals)
            ValueAxis {
                id: xAxis
                min: 0
                max: 9
                tickCount: 10
                labelsColor: "#cfd8dc"
                gridLineColor: "#37474f"
            }

            // Y-axis (MWh)
            ValueAxis {
                id: yAxis
                min: 0
                max: 100
                tickCount: 6
                labelsColor: "#cfd8dc"
                gridLineColor: "#37474f"
            }

            // --------------------------
            // Bar Series (Planned Power)
            // --------------------------
            BarSeries {
                id: barSeries
                axisX: xAxis
                axisY: yAxis
                name: "Planned Power [MWh]"
                BarSet {
                    id: plannedSet
                    label: "Planned"
                    color: "#2196f3"
                    borderColor: "transparent"
                    values: [65, 70, 68, 72, 75, 73, 77, 78, 80, 76]
                }
            }

            // --------------------------
            // Line Series (Actual Forecast)
            // --------------------------
            LineSeries {
                id: forecastLine
                axisX: xAxis
                axisY: yAxis
                name: "Forecast Power [MWh]"
                color: "#e53935"
                width: 2
            }

            // --------------------------
            // Reactive update from C++
            // --------------------------
            Connections {
                target: forecastData
                function onDataChanged() {
                    if (!forecastData.values || forecastData.values.length === 0)
                        return;

                    forecastLine.clear();
                    for (let i = 0; i < forecastData.values.length; i++) {
                        forecastLine.append(i, forecastData.values[i]);
                    }

                    // Auto-adjust Y-axis dynamically
                    yAxis.min = Math.min(0, forecastData.minValue - 5);
                    yAxis.max = forecastData.maxValue + 5;
                }
            }
        }
    }
}
