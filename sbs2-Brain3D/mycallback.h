#ifndef MYECALLBACK_H
#define MYECALLBACK_H

#include <sbs2callback.h>
#include <sbs2datahandler.h>
#include <glwidget.h>
#include <QDateTime>
#include <source_reconstruction/loreta/sbs2sourcereconstruction_loreta.h>
#include <sbs2region.h>

class MyCallback : public Sbs2Callback
{
    Q_OBJECT
public:
    explicit MyCallback(GLWidget* glwidget_, QObject *parent = 0);
    void getData(Sbs2Packet *packet);


private:
    DTU::DtuArray2D<double>* verticesData;
    GLWidget* glwidget;
    DTU::DtuArray2D<double>* colorData;

    int lowFreq; //included
    int highFreq; //excluded

    QVector<double>* maxValues;
    QVector<double>* minValues;
    double meanPower;
    int meanWindowLength;
    QVector<double> cmap;



    int collectedSamples;
    int visualized;
    QTimer* updateSimulationTimer;

    double currentPowerValue1;
    double currentPowerValue2;
    int simulationLimit;
    int simulationFrames;



private:
    void createColorMatrix(DTU::DtuArray2D<double>* verticesData_);
    void updateModel();

    void createColorMatrix2(DTU::DtuArray2D<double>* verticesData_);
    void createColorMatrix3();



signals:

public slots:
    void soureReconstructionPowerReady();
    void changeBand(QString name);
    void updateColorMap(int colorMap);
    void sourceReconstructionReady();
    void updateSimulation();

};

#endif // MYCALLBACK_H
