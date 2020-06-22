boolean saveImage = false;
int maxLayers = 15;
float fps = 60;
float secondsPerCurve = 10;

float speed;
float pauseTime = 1;

//TODO, save images to render video

Level firstLayer;
float t = 0;
float tPause = 0;
Point drawPoint;
Curve curve;
boolean pause = false;
int frameNum = 0;

import java.io.File;

void settings()
{
  size(1280,720);
  //fullScreen();
}

void setup()
{
  clearDirectory();
  
  firstLayer = new Level(true, maxLayers, maxLayers);
  curve = new Curve();
  
  //setting framerate based on whether it's for viewing or saving
  if(!saveImage)
    frameRate(fps);
  else
    frameRate(1000000);
  
  speed = 1/(fps * secondsPerCurve);
  println("speed: "+speed);
}

void draw()
{
  clear();
  background(255);
  
  animate();
  if(saveImage)
  {
    save("frames/"+frameNum+".jpg");
    frameNum++;
  }
}

void animate()
{
  firstLayer.draw();
  curve.draw();
  
  if(!pause) //STATE = NOT PAUSED
  {
      
    drawPoint = firstLayer.update(t);  
    curve.push(drawPoint);
   
    if(t == 0 || t >=1)
    {
      pause = true;
      tPause = 0;
    }
    
    //handle time
    t += speed;
    
    //SET PAUSE
    if(t > 1)
      t = 1;
  }
  else // STATE = PAUSED
  {
    pause();
    if(t == 1 && !pause)
      reset();
  }
}

void pause()
{
  tPause += (speed * secondsPerCurve);
  if(tPause >= pauseTime)
  {
    pause = false;
  }
}

void reset()
{
  t = 0;
  curve.clear();
  firstLayer = new Level(true, (int)random(3,maxLayers), maxLayers);
}

void clearDirectory()
{
  int num = 0;
  boolean done = false;
  File f;
  do
  {
    String fileName = dataPath(sketchPath() + "\\frames\\" + num + ".jpg");
    f = new File(fileName);
    if (f.exists()) {
      f.delete();
      println("deleting: "+sketchPath() + "\\frames\\" + num + ".jpg");
    }
    else
      done = true;
    num++;
  }while(!done);
}

void keyPressed()
{
  firstLayer.randomize(width, height, maxLayers);
  if(key == '3' || key == '4' || key == '5' || key == '6' || key == '7' || key == '8' || key == '9')
    firstLayer = new Level(true, (int)key - 48, maxLayers);
  curve.clear();
  t = 0;
}
