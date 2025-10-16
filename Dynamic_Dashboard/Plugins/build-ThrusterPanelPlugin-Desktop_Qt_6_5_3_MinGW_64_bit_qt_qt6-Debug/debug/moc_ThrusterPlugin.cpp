/****************************************************************************
** Meta object code from reading C++ file 'ThrusterPlugin.h'
**
** Created by: The Qt Meta Object Compiler version 68 (Qt 6.5.3)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../ThrusterPanelPlugin/ThrusterPlugin.h"
#include <QtCore/qmetatype.h>
#include <QtCore/qplugin.h>

#if __has_include(<QtCore/qtmochelpers.h>)
#include <QtCore/qtmochelpers.h>
#else
QT_BEGIN_MOC_NAMESPACE
#endif


#include <memory>

#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'ThrusterPlugin.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 68
#error "This file was generated using the moc from 6.5.3. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

#ifndef Q_CONSTINIT
#define Q_CONSTINIT
#endif

QT_WARNING_PUSH
QT_WARNING_DISABLE_DEPRECATED
QT_WARNING_DISABLE_GCC("-Wuseless-cast")
namespace {

#ifdef QT_MOC_HAS_STRINGDATA
struct qt_meta_stringdata_CLASSThrusterPanelPluginENDCLASS_t {};
static constexpr auto qt_meta_stringdata_CLASSThrusterPanelPluginENDCLASS = QtMocHelpers::stringData(
    "ThrusterPanelPlugin"
);
#else  // !QT_MOC_HAS_STRING_DATA
struct qt_meta_stringdata_CLASSThrusterPanelPluginENDCLASS_t {
    uint offsetsAndSizes[2];
    char stringdata0[20];
};
#define QT_MOC_LITERAL(ofs, len) \
    uint(sizeof(qt_meta_stringdata_CLASSThrusterPanelPluginENDCLASS_t::offsetsAndSizes) + ofs), len 
Q_CONSTINIT static const qt_meta_stringdata_CLASSThrusterPanelPluginENDCLASS_t qt_meta_stringdata_CLASSThrusterPanelPluginENDCLASS = {
    {
        QT_MOC_LITERAL(0, 19)   // "ThrusterPanelPlugin"
    },
    "ThrusterPanelPlugin"
};
#undef QT_MOC_LITERAL
#endif // !QT_MOC_HAS_STRING_DATA
} // unnamed namespace

Q_CONSTINIT static const uint qt_meta_data_CLASSThrusterPanelPluginENDCLASS[] = {

 // content:
      11,       // revision
       0,       // classname
       0,    0, // classinfo
       0,    0, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       0,       // signalCount

       0        // eod
};

Q_CONSTINIT const QMetaObject ThrusterPanelPlugin::staticMetaObject = { {
    QMetaObject::SuperData::link<QObject::staticMetaObject>(),
    qt_meta_stringdata_CLASSThrusterPanelPluginENDCLASS.offsetsAndSizes,
    qt_meta_data_CLASSThrusterPanelPluginENDCLASS,
    qt_static_metacall,
    nullptr,
    qt_incomplete_metaTypeArray<qt_meta_stringdata_CLASSThrusterPanelPluginENDCLASS_t,
        // Q_OBJECT / Q_GADGET
        QtPrivate::TypeAndForceComplete<ThrusterPanelPlugin, std::true_type>
    >,
    nullptr
} };

void ThrusterPanelPlugin::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    (void)_o;
    (void)_id;
    (void)_c;
    (void)_a;
}

const QMetaObject *ThrusterPanelPlugin::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *ThrusterPanelPlugin::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_meta_stringdata_CLASSThrusterPanelPluginENDCLASS.stringdata0))
        return static_cast<void*>(this);
    if (!strcmp(_clname, "IPanelPlugin"))
        return static_cast< IPanelPlugin*>(this);
    if (!strcmp(_clname, "com.anjali.DynamicDashboard.IPanelPlugin/1.0"))
        return static_cast< IPanelPlugin*>(this);
    return QObject::qt_metacast(_clname);
}

int ThrusterPanelPlugin::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    return _id;
}

#ifdef QT_MOC_EXPORT_PLUGIN_V2
static constexpr unsigned char qt_pluginMetaDataV2_ThrusterPanelPlugin[] = {
    0xbf, 
    // "IID"
    0x02,  0x78,  0x2c,  'c',  'o',  'm',  '.',  'a', 
    'n',  'j',  'a',  'l',  'i',  '.',  'D',  'y', 
    'n',  'a',  'm',  'i',  'c',  'D',  'a',  's', 
    'h',  'b',  'o',  'a',  'r',  'd',  '.',  'I', 
    'P',  'a',  'n',  'e',  'l',  'P',  'l',  'u', 
    'g',  'i',  'n',  '/',  '1',  '.',  '0', 
    // "className"
    0x03,  0x73,  'T',  'h',  'r',  'u',  's',  't', 
    'e',  'r',  'P',  'a',  'n',  'e',  'l',  'P', 
    'l',  'u',  'g',  'i',  'n', 
    // "MetaData"
    0x04,  0xa3,  0x6b,  'd',  'e',  's',  'c',  'r', 
    'i',  'p',  't',  'i',  'o',  'n',  0x78,  0x27, 
    'D',  'y',  'n',  'a',  'm',  'i',  'c',  ' ', 
    'D',  'a',  's',  'h',  'b',  'o',  'a',  'r', 
    'd',  ' ',  'T',  'h',  'r',  'u',  's',  't', 
    'e',  'r',  ' ',  'P',  'a',  'n',  'e',  'l', 
    ' ',  'P',  'l',  'u',  'g',  'i',  'n',  0x64, 
    'n',  'a',  'm',  'e',  0x72,  'T',  'h',  'u', 
    's',  't',  'e',  'r',  'P',  'a',  'n',  'e', 
    'l',  'P',  'l',  'u',  'g',  'i',  'n',  0x67, 
    'v',  'e',  'r',  's',  'i',  'o',  'n',  0x63, 
    '1',  '.',  '0', 
    0xff, 
};
QT_MOC_EXPORT_PLUGIN_V2(ThrusterPanelPlugin, ThrusterPanelPlugin, qt_pluginMetaDataV2_ThrusterPanelPlugin)
#else
QT_PLUGIN_METADATA_SECTION
Q_CONSTINIT static constexpr unsigned char qt_pluginMetaData_ThrusterPanelPlugin[] = {
    'Q', 'T', 'M', 'E', 'T', 'A', 'D', 'A', 'T', 'A', ' ', '!',
    // metadata version, Qt version, architectural requirements
    0, QT_VERSION_MAJOR, QT_VERSION_MINOR, qPluginArchRequirements(),
    0xbf, 
    // "IID"
    0x02,  0x78,  0x2c,  'c',  'o',  'm',  '.',  'a', 
    'n',  'j',  'a',  'l',  'i',  '.',  'D',  'y', 
    'n',  'a',  'm',  'i',  'c',  'D',  'a',  's', 
    'h',  'b',  'o',  'a',  'r',  'd',  '.',  'I', 
    'P',  'a',  'n',  'e',  'l',  'P',  'l',  'u', 
    'g',  'i',  'n',  '/',  '1',  '.',  '0', 
    // "className"
    0x03,  0x73,  'T',  'h',  'r',  'u',  's',  't', 
    'e',  'r',  'P',  'a',  'n',  'e',  'l',  'P', 
    'l',  'u',  'g',  'i',  'n', 
    // "MetaData"
    0x04,  0xa3,  0x6b,  'd',  'e',  's',  'c',  'r', 
    'i',  'p',  't',  'i',  'o',  'n',  0x78,  0x27, 
    'D',  'y',  'n',  'a',  'm',  'i',  'c',  ' ', 
    'D',  'a',  's',  'h',  'b',  'o',  'a',  'r', 
    'd',  ' ',  'T',  'h',  'r',  'u',  's',  't', 
    'e',  'r',  ' ',  'P',  'a',  'n',  'e',  'l', 
    ' ',  'P',  'l',  'u',  'g',  'i',  'n',  0x64, 
    'n',  'a',  'm',  'e',  0x72,  'T',  'h',  'u', 
    's',  't',  'e',  'r',  'P',  'a',  'n',  'e', 
    'l',  'P',  'l',  'u',  'g',  'i',  'n',  0x67, 
    'v',  'e',  'r',  's',  'i',  'o',  'n',  0x63, 
    '1',  '.',  '0', 
    0xff, 
};
QT_MOC_EXPORT_PLUGIN(ThrusterPanelPlugin, ThrusterPanelPlugin)
#endif  // QT_MOC_EXPORT_PLUGIN_V2

QT_WARNING_POP
