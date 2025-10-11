#pragma once

#include <QObject>
#include <QTimer>

class PowerData : public QObject
{
    Q_OBJECT
    Q_PROPERTY(double availablePower READ availablePower NOTIFY dataChanged)
    Q_PROPERTY(double usedPower READ usedPower NOTIFY dataChanged)
    Q_PROPERTY(double totalPower READ totalPower NOTIFY dataChanged)

public:
    explicit PowerData(QObject *parent = nullptr);

    double availablePower() const { return m_availablePower; }
    double usedPower() const { return m_usedPower; }
    double totalPower() const { return m_totalPower; }
    void startUpdates();

signals:
    void dataChanged();

private slots:
    void updateData();

private:
    double m_availablePower;
    double m_usedPower;
    double m_totalPower;
    QTimer m_timer;
};
