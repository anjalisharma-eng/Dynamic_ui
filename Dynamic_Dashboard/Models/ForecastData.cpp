#include "ForecastData.h"
#include <QRandomGenerator>
#include <numeric>
#include <algorithm>

ForecastData::ForecastData(QObject *parent)
    : QObject(parent),
      m_minValue(0),
      m_maxValue(0),
      m_avgValue(0)
{
    connect(&m_timer, &QTimer::timeout, this, &ForecastData::updateForecast);
    updateForecast();
}

void ForecastData::updateForecast()
{
    m_forecastValues.clear();
    for (int i = 0; i < 10; ++i) {
        m_forecastValues.append(QRandomGenerator::global()->bounded(100.0));
    }

    m_minValue = *std::min_element(m_forecastValues.begin(), m_forecastValues.end());
    m_maxValue = *std::max_element(m_forecastValues.begin(), m_forecastValues.end());
    m_avgValue = std::accumulate(m_forecastValues.begin(), m_forecastValues.end(), 0.0) / m_forecastValues.size();

    emit dataChanged();
}

void ForecastData::startUpdates()
{
    if (!m_timer.isActive())
        m_timer.start(1500);
}
