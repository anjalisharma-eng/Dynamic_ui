#pragma once

#include <QObject>
#include <QVariantList>
#include <QString>

class ConfigLoader : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QVariantList components READ components NOTIFY componentsChanged)

public:
    explicit ConfigLoader(QObject *parent = nullptr);

    bool loadConfig(const QString &filePath);

    QVariantList components() const;

signals:
    void componentsChanged();

private:
    QVariantList m_components;
};

