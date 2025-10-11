//#pragma once

//#include <QObject>
//#include <QTimer>
//#include <QVector>

//class ForecastData : public QObject
//{
//    Q_OBJECT
//    Q_PROPERTY(QVector<double> forecastValues READ forecastValues NOTIFY dataChanged)
//    Q_PROPERTY(double avgValue READ avgValue NOTIFY dataChanged)
//    Q_PROPERTY(double maxValue READ maxValue NOTIFY dataChanged)
//    Q_PROPERTY(double minValue READ minValue NOTIFY dataChanged)

//public:
//    explicit ForecastData(QObject *parent = nullptr);

//    QVector<double> forecastValues() const { return m_forecastValues; }
//    double avgValue() const { return m_avgValue; }
//    double maxValue() const { return m_maxValue; }
//    double minValue() const { return m_minValue; }
//    void startUpdates();

//signals:
//    void dataChanged();

//private slots:
//    void updateForecast();

//private:
//    QVector<double> m_forecastValues;
//    double m_avgValue;
//    double m_maxValue;
//    double m_minValue;
//    QTimer m_timer;
//};
#pragma once
#include <QObject>
#include <QTimer>
#include <QLineSeries>

class ForecastData : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QLineSeries* series READ series CONSTANT)
    Q_PROPERTY(double minValue READ minValue NOTIFY dataChanged)
    Q_PROPERTY(double maxValue READ maxValue NOTIFY dataChanged)
    Q_PROPERTY(double avgValue READ avgValue NOTIFY dataChanged)

public:
    explicit ForecastData(QObject *parent = nullptr);

    QLineSeries* series() const { return m_series; }
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
    QLineSeries* m_series;
    QTimer m_timer;
    double m_minValue;
    double m_maxValue;
    double m_avgValue;
};
