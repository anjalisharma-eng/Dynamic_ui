#pragma once
#include <QObject>
#include <QTimer>
#include <QVector>

class ForecastData : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QVector<double> values READ values NOTIFY dataChanged)
    Q_PROPERTY(double minValue READ minValue NOTIFY dataChanged)
    Q_PROPERTY(double maxValue READ maxValue NOTIFY dataChanged)
    Q_PROPERTY(double avgValue READ avgValue NOTIFY dataChanged)

public:
    explicit ForecastData(QObject *parent = nullptr);

    QVector<double> values() const { return m_forecastValues; }
    double minValue() const { return m_minValue; }
    double maxValue() const { return m_maxValue; }
    double avgValue() const { return m_avgValue; }

public slots:
    void startUpdates();

signals:
    void dataChanged();

private slots:
    void updateForecast();

private:
    QTimer m_timer;
    QVector<double> m_forecastValues;
    double m_minValue;
    double m_maxValue;
    double m_avgValue;
};
