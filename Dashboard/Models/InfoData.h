#pragma once

#include <QObject>
#include <QTimer>

class InfoData : public QObject
{
    Q_OBJECT
    Q_PROPERTY(double speed READ speed NOTIFY dataChanged)
    Q_PROPERTY(double heading READ heading NOTIFY dataChanged)
    Q_PROPERTY(double windSpeed READ windSpeed NOTIFY dataChanged)
    Q_PROPERTY(double temperature READ temperature NOTIFY dataChanged)

public:
    explicit InfoData(QObject *parent = nullptr);

    double speed() const { return m_speed; }
    double heading() const { return m_heading; }
    double windSpeed() const { return m_windSpeed; }
    double temperature() const { return m_temperature; }
    void startUpdates();

signals:
    void dataChanged();

private slots:
    void updateData();

private:
    double m_speed;
    double m_heading;
    double m_windSpeed;
    double m_temperature;
    QTimer m_timer;
};
