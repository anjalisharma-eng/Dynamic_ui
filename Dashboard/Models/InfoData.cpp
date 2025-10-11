#include "InfoData.h"
#include <QRandomGenerator>
#include <QtMath>

InfoData::InfoData(QObject *parent)
    : QObject(parent),
      m_speed(0.0),
      m_heading(0.0),
      m_windSpeed(0.0),
      m_temperature(25.0)
{
    connect(&m_timer, &QTimer::timeout, this, &InfoData::updateData);
    updateData();        // Initialize first values
}

void InfoData::updateData()
{
    // Generate random double safely (0.0 to 1.0)
    auto random = []() { return QRandomGenerator::global()->generateDouble(); };

    // Scale values manually to avoid ambiguity
    m_speed = random() * 30.0;                 // 0–30 knots
    m_heading = random() * 360.0;              // 0–360 degrees
    m_windSpeed = random() * 20.0;             // 0–20 m/s
    m_temperature = 15.0 + random() * (35.0 - 15.0); // 15–35 °C

    emit dataChanged();
}

void InfoData::startUpdates()
{
    if (!m_timer.isActive()) {
        m_timer.start(1500);
    }
}
