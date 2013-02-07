#ifndef SETTINGSWRAPPER_H
#define SETTINGSWRAPPER_H

#include <QCoreApplication>
#include <QSettings>
#include <QDebug>

#include <QDir>

class SettingsWrapper : public QSettings
{
    Q_OBJECT

public:
#if defined(Q_OS_ANDROID)
    explicit SettingsWrapper(QObject *parent = 0) : QSettings(
                                                       "/sdcard/smartphonebrainscanner2_data/NeurofeedbackWindow.ini",
                                                       QSettings::IniFormat,
                                                       parent) {
#else
explicit SettingsWrapper(QObject *parent = 0) : QSettings(
                                                   QDir::toNativeSeparators(QDir::homePath())+"/smartphonebrainscanner2_data/NeurofeedbackWindow.ini",
                                                   QSettings::IniFormat,
                                                   parent) {
#endif
        qDebug() << "Settings file:  " << fileName();
    }

    Q_INVOKABLE inline void setValue(const QString &key, const QVariant &value) { QSettings::setValue(key, value); sync();}
    Q_INVOKABLE inline QVariant value(const QString &key, const QVariant &defaultValue = QVariant()) const { return QSettings::value(key, defaultValue); }
};

Q_DECLARE_METATYPE(SettingsWrapper*)

#endif // SETTINGSWRAPPER_H
