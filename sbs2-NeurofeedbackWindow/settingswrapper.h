#ifndef SETTINGSWRAPPER_H
#define SETTINGSWRAPPER_H

#include <QCoreApplication>
#include <QSettings>
#include <QDebug>

class SettingsWrapper : public QSettings
{
    Q_OBJECT

public:
    explicit SettingsWrapper(QObject *parent = 0) : QSettings(QSettings::IniFormat,
                                                       QSettings::UserScope,
                                                       QCoreApplication::instance()->organizationName(),
                                                       QCoreApplication::instance()->applicationName(),
                                                       parent) {
        qDebug() << "Settings file:  " << fileName();
    }

    Q_INVOKABLE inline void setValue(const QString &key, const QVariant &value) { QSettings::setValue(key, value); }
    Q_INVOKABLE inline QVariant value(const QString &key, const QVariant &defaultValue = QVariant()) const { return QSettings::value(key, defaultValue); }
};

Q_DECLARE_METATYPE(SettingsWrapper*)

#endif // SETTINGSWRAPPER_H
