#include "CompassData.h"
#include <QtMath>

CompassData::CompassData(QObject *parent)
    : QObject(parent), m_angle(0.0)
{
}

void CompassData::setAngle(double newAngle)
{
    // Keep angle between 0 and 360
    if (newAngle < 0)
        newAngle += 360;
    else if (newAngle >= 360)
        newAngle = fmod(newAngle, 360.0);

    if (qFuzzyCompare(m_angle, newAngle))
        return;

    m_angle = newAngle;
    emit angleChanged();
    emit directionChanged();
}

QString CompassData::direction() const
{
    if (m_angle >= 337.5 || m_angle < 22.5)
        return "N";
    if (m_angle < 67.5)
        return "NE";
    if (m_angle < 112.5)
        return "E";
    if (m_angle < 157.5)
        return "SE";
    if (m_angle < 202.5)
        return "S";
    if (m_angle < 247.5)
        return "SW";
    if (m_angle < 292.5)
        return "W";
    return "NW";
}

void CompassData::updateAngle()
{
    setAngle(m_angle + 10.0);
}
