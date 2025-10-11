#include "ThrusterData.h"
#include <QRandomGenerator>
#include <QtMath>

ThrusterData::ThrusterData(QObject *parent)
    : QObject(parent),
      m_pod1Power(2.0),
      m_pod2Power(3.0),
      m_prevAvg(0.0)
{
    connect(&m_timer, &QTimer::timeout, this, &ThrusterData::updateData);
    updateData();        // Initialize with first values
}

void ThrusterData::updateData()
{
    // Helper lambda to generate random double [0.0–1.0]
    auto random = []() { return QRandomGenerator::global()->generateDouble(); };

    // Simulate random fluctuations between 2.0 – 5.0
    m_pod1Power = 2.0 + random() * (5.0 - 2.0);
    m_pod2Power = 3.0 + random() * (5.0 - 3.0);

    // Calculate average and trend
    double avg = (m_pod1Power + m_pod2Power) / 2.0;
    QString trendNow = avg > m_prevAvg ? "Up" : (avg < m_prevAvg ? "Down" : "Stable");
    m_prevAvg = avg;

    emit dataChanged();
}

QString ThrusterData::trend() const
{
    double avg = (m_pod1Power + m_pod2Power) / 2.0;

    if (avg > m_prevAvg)
        return "Up";
    else if (avg < m_prevAvg)
        return "Down";
    else
        return "Stable";
}

void ThrusterData::startUpdates()
{
    if (!m_timer.isActive()) {
        m_timer.start(1500);
    }
}
