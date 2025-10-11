#pragma once

#include <QObject>
#include <QTimer>

class ThrusterData : public QObject
{
    Q_OBJECT
    Q_PROPERTY(double pod1Power READ pod1Power NOTIFY dataChanged)
    Q_PROPERTY(double pod2Power READ pod2Power NOTIFY dataChanged)
    Q_PROPERTY(QString trend READ trend NOTIFY dataChanged)

public:
    explicit ThrusterData(QObject *parent = nullptr);

    double pod1Power() const { return m_pod1Power; }
    double pod2Power() const { return m_pod2Power; }
    QString trend() const;
    void startUpdates();

signals:
    void dataChanged();

private slots:
    void updateData();

private:
    double m_pod1Power;
    double m_pod2Power;
    double m_prevAvg;
    QTimer m_timer;
};
