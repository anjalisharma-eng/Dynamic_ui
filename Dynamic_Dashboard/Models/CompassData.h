#pragma once
#include <QObject>

class CompassData : public QObject
{
    Q_OBJECT
    Q_PROPERTY(double angle READ angle WRITE setAngle NOTIFY angleChanged)
    Q_PROPERTY(QString direction READ direction NOTIFY directionChanged)

public:
    explicit CompassData(QObject *parent = nullptr);

    double angle() const { return m_angle; }
    QString direction() const;

public slots:
    void setAngle(double newAngle);
    void updateAngle();

signals:
    void angleChanged();
    void directionChanged();

private:
    double m_angle;  // angle in degrees (0–360)
};
