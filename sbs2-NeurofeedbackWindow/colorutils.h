#ifndef COLORUTILS_H
#define COLORUTILS_H

#include <QMap>
#include <QColor>

class ColorUtils : public QObject
{
    Q_OBJECT

public:
    ColorUtils(QObject *parent = 0);

    Q_INVOKABLE void addColor(qreal key, int red, int green, int blue);
    Q_INVOKABLE QColor getColor(qreal key) const;
    Q_INVOKABLE void reset() { m_colorStops.clear(); }

private:
    QMap<qreal,QColor> m_colorStops;
};

#endif // COLORUTILS_H
