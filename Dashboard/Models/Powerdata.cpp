#include "PowerData.h"
#include <QtMath>
#include <QRandomGenerator>

PowerData::PowerData(QObject *parent)
    : QObject(parent),
      m_availablePower(6.0),
      m_usedPower(4.0),
      m_totalPower(10.0)
{
    connect(&m_timer, &QTimer::timeout, this, &PowerData::updateData);
    updateData();
}

void PowerData::updateData()
{
    // Generate random power usage safely (between 3.0 MW and 8.0 MW)
    double random = QRandomGenerator::global()->generateDouble(); // returns 0.0–1.0
    m_usedPower = 3.0 + random * (8.0 - 3.0); // scale to [3.0, 8.0]

    // Compute available power
    m_availablePower = m_totalPower - m_usedPower;

    emit dataChanged();
}

void PowerData::startUpdates()
{
    if (!m_timer.isActive()) {
        m_timer.start(1500);
    }
}
