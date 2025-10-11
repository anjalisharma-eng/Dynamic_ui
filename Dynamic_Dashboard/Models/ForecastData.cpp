//#include "ForecastData.h"
//#include <QRandomGenerator>
//#include <numeric> // for accumulate
//#include <algorithm> // for min/max_element

//ForecastData::ForecastData(QObject *parent)
//    : QObject(parent),
//      m_avgValue(0),
//      m_maxValue(0),
//      m_minValue(0)
//{
//    connect(&m_timer, &QTimer::timeout, this, &ForecastData::updateForecast);
//    updateForecast();
//}

//void ForecastData::updateForecast()
//{
//    m_forecastValues.clear();

//    for (int i = 0; i < 10; ++i) {
//        // Force MinGW to call the double overload explicitly
//        double randomValue = QRandomGenerator::global()->generateDouble() * 100.0;
//        m_forecastValues.append(randomValue);
//    }

//    m_maxValue = *std::max_element(m_forecastValues.begin(), m_forecastValues.end());
//    m_minValue = *std::min_element(m_forecastValues.begin(), m_forecastValues.end());
//    m_avgValue = std::accumulate(m_forecastValues.begin(), m_forecastValues.end(), 0.0) / m_forecastValues.size();

//    emit dataChanged();
//}

//void ForecastData::startUpdates()
//{
//    if (!m_timer.isActive()) {
//        m_timer.start(1500);
//    }
//}
#include "ForecastData.h"
#include <QRandomGenerator>
#include <numeric>
#include <algorithm>
#include <QPointF>

ForecastData::ForecastData(QObject *parent)
    : QObject(parent),
      m_series(new QLineSeries(this)),
      m_minValue(0),
      m_maxValue(0),
      m_avgValue(0)
{
    connect(&m_timer, &QTimer::timeout, this, &ForecastData::updateForecast);
    updateForecast();
}

void ForecastData::updateForecast()
{
    QList<QPointF> points;
    points.reserve(10);

    for (int i = 0; i < 10; ++i) {
        double val = QRandomGenerator::global()->bounded(100.0);
        points.append(QPointF(i, val));
    }

    m_series->replace(points);

    std::vector<double> values;
    values.reserve(points.size());
    for (const QPointF &p : points)
        values.push_back(p.y());

    m_minValue = *std::min_element(values.begin(), values.end());
    m_maxValue = *std::max_element(values.begin(), values.end());
    m_avgValue = std::accumulate(values.begin(), values.end(), 0.0) / values.size();

    emit dataChanged();
}

void ForecastData::startUpdates()
{
    if (!m_timer.isActive())
        m_timer.start(1500);
}
