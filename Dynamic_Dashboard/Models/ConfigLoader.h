//#pragma once

//#include <QObject>
//#include <QList>
//#include <QString>
//#include <QVariant>

//struct ComponentInfo {
//    QString source;
//    int x;
//    int y;
//    int width;
//    int height;
//    QString params;
//};

//class ConfigLoader : public QObject
//{
//    Q_OBJECT
//    Q_PROPERTY(QList<QVariant> components READ components NOTIFY componentsChanged)

//public:
//    explicit ConfigLoader(QObject *parent = nullptr);
//    void loadConfig(const QString &filePath);
//    QList<QVariant> components() const;

//signals:
//    void componentsChanged();

//private:
//    QList<QVariant> m_components;
//};

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

    // Returns true on success, false on failure
    bool loadConfig(const QString &filePath);

    QVariantList components() const;

signals:
    void componentsChanged();

private:
    QVariantList m_components;
};

