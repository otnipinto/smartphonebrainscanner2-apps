#include "colorutils.h"

#include <QPropertyAnimation>

#include <QDebug>

ColorUtils::ColorUtils(QObject *parent) : QObject(parent)
{
}

void ColorUtils::addColor(qreal key, int red, int green, int blue)
{
    m_colorStops[key] = QColor(red,green,blue);
}

QColor ColorUtils::getColor(qreal key) const
{
    QColor result;

    key = key < 0.0 ? 0.0 : key > 1.0 ? 1.0 : key;

    if (m_colorStops.contains(key)) {
        result = m_colorStops.value(key);
    } else {
        QPropertyAnimation pa;
        pa.setEasingCurve(QEasingCurve::Linear);
        pa.setDuration(100.0);
        foreach(qreal key, m_colorStops.keys())
        {
            pa.setKeyValueAt(key, m_colorStops.value(key));
        }
        pa.setCurrentTime(key*100.0) ;

        result = pa.currentValue().value<QColor>();
    }

    // qDebug() << result;

    return result;
}
