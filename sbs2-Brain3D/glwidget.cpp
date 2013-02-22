#include "glwidget.h"

#if defined(Q_OS_MAC)
#include <OpenGL.h>
#endif

GLWidget::GLWidget(QWidget *parent) :
    QGLWidget(parent),
    timer(new QBasicTimer)
{

    setAttribute(Qt::WA_PaintOnScreen);
    setAttribute(Qt::WA_NoSystemBackground);
    setAutoBufferSwap(false);
    //model = new Model(Sbs2Common::getRootAppPath() + QString("vertface_brain_reduced.obj"));
    model = new Model("/Users/arks/Downloads/mesh_ctx_5124.obj");
    //model = new Model("/Users/arks/Desktop/BrainV2.obj");

    sourceRecOn = 0;

    dragX = dragY = 0;
    gyroX = gyroY = 0;
    dragging = 0;

    logoPixmap.load(":/dtu.jpg");
    epicenterPixmap.load(":/LOGO-EPICENTER-4.png");
    infoPressed = 0;

    resetFreqs();
    changeFrequency("alpha");

    headMovementOn = 1;
    zeroRotation = 1;
    infoText = "looking for device...";
    devicePresent = 0;
    dataFlowing = 0;
}

void GLWidget::changeFrequency(QString name)
{
    resetFreqs();
    if (name.compare("delta") == 0)
    {
	deltaOn = 1;
    }
    if (name.compare("theta") == 0)
    {
	thetaOn = 1;
    }
    if (name.compare("alpha") == 0)
    {
	alphaOn = 1;
    }
    if (name.compare("lowBeta") == 0)
    {
	lowBetaOn = 1;
    }
    if (name.compare("beta") == 0)
    {
	betaOn = 1;
    }


    emit changeBand(name);
}

void GLWidget::resetFreqs()
{
    deltaOn = 0;
    thetaOn = 0;
    alphaOn = 0;
    lowBetaOn = 0;
    betaOn = 0;

}

void GLWidget::quit()
{
    timer->stop();
}

void GLWidget::resizeGL(int w, int h)
{
    aspectRatio = (qreal) w / (qreal) h;
    quitRect = QRect(w-20-80,20,80,80);

    //toggleRectEmocap = QRect(220,20,180,80);

    //frequency buttons
    int buttonWidth = 180;
    int buttonWMargin = 20;
    toggleRect = QRect(buttonWMargin,10,buttonWidth,60);
    deltaRect = QRect(buttonWMargin,120, buttonWidth, 60);
    thetaRect = QRect(buttonWMargin,120 + 60 + 10, buttonWidth, 60);
    alphaRect = QRect(buttonWMargin,120+2*(60+10), buttonWidth, 60);
    lowBetaRect = QRect(buttonWMargin,120+3*(60+10), buttonWidth, 60);
    betaRect = QRect(buttonWMargin,120+4*(60+10), buttonWidth, 60);
    logoRect = QRect(w - logoPixmap.width() - 90, 20, logoPixmap.width(), logoPixmap.height());
    infoRect = QRect(w/2 - 500, h/2 - 320, 1000, 640);
    websiteRect = QRect(20, h  - 40, 800, 80);

    infoTextRect = QRect(w/2 - 500, h/2 - 320, 1000, 640);

    rotationRect = QRect(w-buttonWidth,120,buttonWidth,60);

    rect1 = QRect(buttonWMargin,height()/2,80,0);
    rect2 = QRect(buttonWMargin+80,height()/2,80,0);
}

void GLWidget::initializeGL()
{
#if defined(Q_OS_MAC)
    const GLint swapInterval = 1;
    CGLSetParameter(CGLGetCurrentContext(), kCGLCPSwapInterval, &swapInterval);
#endif

    glClearColor(0.f, 0.0f, 0.0f, 1.0f);
    camera = QVector3D(0, -50, 20);
    dragX = 0;
    model->setFragmentShaderFile(QString(":/fshader.normals.glsl"));
    model->setVertexShaderFile(QString(":/vshader.normals.glsl"));
    model->linkShaderProgram();
    model->initShaderProgram();

    timer->start(20, this);

}

void GLWidget::paintGL()
{

    QPainter painter;
    painter.begin(this);

    painter.beginNativePainting();


    glClearColor(0.0f, 0.0f, 0.0f, 1.0f);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

    glFrontFace(GL_CW);
    glCullFace(GL_FRONT);
    glEnable(GL_CULL_FACE);
    glEnable(GL_DEPTH_TEST);
    /* Disable for opaque colors. */
    glEnable(GL_BLEND);
    glBlendFunc (GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);



    mainModelView = QMatrix4x4(); // reset
    mainModelView.perspective(45.0, aspectRatio, 1.0, 400.0);
    mainModelView.lookAt(camera,QVector3D(0,0,0),QVector3D(0.0,1.0,0.0));

    mainModelView.translate(0,-1,0);

/*
    dragX += gyroX * 0.008 * (1-dragging) * (headMovementOn);
    dragY += gyroY * 0.008 * (1-dragging) * (headMovementOn);

    if (zeroRotation && !dragging)
    {
	if (dragX > 0) dragX -= 0.01*dragX;
	if (dragX < 0) dragX -= 0.01*dragX;

	if (dragX < 0.009 && dragX > -0.009) dragX = 0;

	if (dragY > 0) dragY -= 0.01*dragY;
	if (dragY < 0) dragY -= 0.01*dragY;

	if (dragY < 0.009 && dragY > -0.009) dragY = 0;
    }

    if (dragX > 360) dragX -= 360;
    if (dragX < -360) dragX += 360;
*/

    if (dragY > 360) dragY -= 360;
    if (dragY < -360) dragY += 360;


    mainModelView.rotate(dragY,1,0,0);
    mainModelView.rotate(dragX,0,0,1);

    mainModelView.rotate(180,0.0,0.0,1.0);
    mainModelView.translate(0,1,0);
    mainModelView.scale(1/4.5);


    model->draw(mainModelView);

    glDisable(GL_DEPTH_TEST);
    glDisable(GL_CULL_FACE);
    glDisable(GL_BLEND);

    painter.endNativePainting();


    //Onscreen control



#ifdef Q_OS_MAC
#else
    painter.fillRect(quitRect,QColor(255,0,0,20));
    painter.drawRect(quitRect);
#endif


    if (sourceRecOn == 0)
    {
#ifdef Q_OS_MAC
	painter.setFont(QFont("helvetica",42,QFont::Bold));
#endif
	painter.setPen(QColor("white"));

	/*
	painter.fillRect(toggleRect,QColor(49,154,49));
	painter.drawText(toggleRect, Qt::AlignCenter, "start");
	*/
    }


    if (sourceRecOn)
    {
#ifdef Q_OS_MAC
	painter.setFont(QFont("helvetica",36,QFont::Bold));
#endif
	painter.setPen(QColor("white"));

	if (!deltaOn)
	    painter.fillRect(deltaRect,QColor(239,150,8));
	else
	    painter.fillRect(deltaRect,QColor(49,154,49));

	painter.drawText(deltaRect,Qt::AlignCenter,"1-4Hz"); //delta

	if (!thetaOn)
	    painter.fillRect(thetaRect,QColor(239,150,8));
	else
	    painter.fillRect(thetaRect,QColor(49,154,49));
	painter.drawText(thetaRect,Qt::AlignCenter,"4-8Hz"); //theta

	if (!alphaOn)
	    painter.fillRect(alphaRect,QColor(239,150,8));
	else
	    painter.fillRect(alphaRect,QColor(49,154,49));
	painter.drawText(alphaRect,Qt::AlignCenter,"8-12Hz"); //alpha

	if (!lowBetaOn)
	    painter.fillRect(lowBetaRect,QColor(239,150,8));
	else
	    painter.fillRect(lowBetaRect,QColor(49,154,49));
	painter.drawText(lowBetaRect,Qt::AlignCenter,"12-16Hz"); //low beta

	if (!betaOn)
	    painter.fillRect(betaRect,QColor(239,150,8));
	else
	    painter.fillRect(betaRect,QColor(49,154,49));
	painter.drawText(betaRect,Qt::AlignCenter,"16-20Hz"); //beta

    }

#ifdef Q_OS_MAC
    painter.setFont(QFont("helvetica",36,QFont::Bold));
#endif
    painter.setPen(QColor("white"));

    /*
    painter.fillRect(rotationRect,QColor(156,81,0));
    if (!headMovementOn)
	painter.drawText(rotationRect,Qt::AlignCenter,"rotation 1");
    if (headMovementOn && !zeroRotation)
	painter.drawText(rotationRect,Qt::AlignCenter,"rotation 2");
    if (headMovementOn && zeroRotation)
	painter.drawText(rotationRect,Qt::AlignCenter,"rotation 3");
*/

    painter.fillRect(rect1,QColor("#90CA77"));
    painter.fillRect(rect2,QColor("#9E3B33"));

#ifdef Q_OS_MAC
    painter.setFont(QFont("helvetica",36,QFont::Bold));
#endif
    painter.setPen(QColor(165,0,255));
   // painter.drawText(infoTextRect,Qt::AlignCenter, infoText);



    painter.drawPixmap(logoRect, logoPixmap);
    painter.drawPixmap(width()-epicenterPixmap.width()-10,height()-epicenterPixmap.height()+45, epicenterPixmap.width(),epicenterPixmap.height(),epicenterPixmap);
    painter.setPen(QColor(255,255,255,255));
    //painter.drawRect(logoRect.x()-5, logoRect.y()-5, logoRect.width()+10, logoRect.height()+20);
#ifdef Q_OS_MAC
    painter.setFont(QFont("helvetica",14,QFont::Bold));
#endif
    painter.drawText(websiteRect,QString("powered by github.com/SmartphoneBrainScanner"));


    if (infoPressed)
    {
	painter.fillRect(infoRect,QColor(0,0,0,180));
	painter.setPen(QColor(255,255,255));
	painter.drawRect(infoRect);
	painter.drawText(infoRect,Qt::AlignCenter, QString("Technical University of Denmark \n\n SmartphoneBrainScanner2: Tech Demo \n\n Jakob Eg Larsen, jel@imm.dtu.dk \n Arkadiusz Stopczynski, arks@imm.dtu.dk \n Carsten Stahlhut, cs@imm.dtu.dk \n Michael Kai Petersen, mkp@imm.dtu.dk \n Lars Kai Hansen, lkh@imm.dtu.dk"));
    }

    painter.setFont(QFont("helvetica",20,QFont::Bold));
    painter.setPen(QColor("white"));
    painter.drawLine(0,height()/2,200,height()/2);
    painter.drawText(200,height()/2,"baseline");
    painter.drawText(30,height()/2,"4-7Hz");
    painter.drawText(100,height()/2,"11-15Hz");

  //   painter.setFont(QFont("helvetica",40,QFont::Bold));
  //  painter.drawText(20,60,"EpiCenter: Neurofeedback Training");

    painter.end();
    swapBuffers();

}

void GLWidget::mousePressEvent(QMouseEvent* event)
{
    if (event->button() == Qt::LeftButton)
    {
#ifdef Q_OS_MAC
#else
	if (quitRect.contains(event->pos()))
	    QApplication::quit();
#endif

	if (rotationRect.contains(event->pos()))
	{
	    if (!headMovementOn)
	    {
		headMovementOn = 1;
		zeroRotation = 0;
	    }
	    else if (headMovementOn && !zeroRotation)
	    {
		headMovementOn = 1;
		zeroRotation = 1;
	    }
	    else if (headMovementOn && zeroRotation)
	    {
		headMovementOn = 0;
		zeroRotation = 0;
	    }
	}


	if (toggleRect.contains(event->pos()))
	{
	    if (sourceRecOn)
	    {

	    }
	    else
	    {
		sourceRecOn = 1;
		setInfoText("loading...");
		this->updateGL();
#ifdef Q_WS_MAEMO_5
		emit turnSourceReconstructionPowerOn(128,32,8*1,8*60, "emotiv");
#else
		emit turnSourceReconstructionPowerOn(128,16,8*1,8*30, QString("emotiv"));
#endif

	    }
	}


	if (deltaRect.contains(event->pos()))
	    changeFrequency("delta");
	if (thetaRect.contains(event->pos()))
	    changeFrequency("theta");
	if (alphaRect.contains(event->pos()))
	    changeFrequency("alpha");
	if (lowBetaRect.contains(event->pos()))
	    changeFrequency("lowBeta");
	if (betaRect.contains(event->pos()))
	    changeFrequency("beta");
	if (logoRect.contains(event->pos()))
	    infoPressed = !infoPressed;
	else if (infoRect.contains(event->pos()))
	    infoPressed = 0;


	dragLastPosition = dragStartPosition = event->pos();
    }
}

void GLWidget::mouseMoveEvent(QMouseEvent* event)
{
    if(!(event->buttons() & Qt::LeftButton))
	return;

    if(dragging)
    {

	dragX -= (dragLastPosition.x() - event->pos().x())/2.0;
	dragY -= (dragLastPosition.y() - event->pos().y())/2.0;
    }
    dragLastPosition = event->pos();
    dragging = true;

}

void GLWidget::mouseReleaseEvent(QMouseEvent* event)
{
    dragging = false;
}


void GLWidget::timerEvent(QTimerEvent *e)
{
    updateGL();
    dragX += 0.1;
}

void GLWidget::updateColorForVertex(int vertex, double r, double g, double b, double a)
{
    setInfoText("");
    model->updateColorForVertex(vertex, r, g, b, a);
}

void GLWidget::updateGyroX(double gyroX_)
{
    gyroX = gyroX_;
    if (abs(gyroX - 1650) < 20) gyroX = 1650;
    gyroX -= 1650;
}

void GLWidget::updateGyroY(double gyroY_)
{
    dataFlowing = 1;
    setInfoText("");
    gyroY = gyroY_;
    if (abs(gyroY - 1650) < 20) gyroY = 1650;
    gyroY -= 1650;
}

void GLWidget::setInfoText(QString text)
{
    infoText = text;
}

void GLWidget::deviceFound(QMap<QString, QVariant> params)
{
    devicePresent = 1;
    setInfoText("waiting for data...");
}

void GLWidget::updateValues(double value1_, double value2_)
{
    value1 = value1_;
    value2 = value2_;
    int currentValue1 = value1*100;
    int currentValue2 = -value2*100;
    rect1.setHeight(currentValue1);
    rect2.setHeight(currentValue2);
}
