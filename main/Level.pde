class Level
{
  Point[] points;
  Level nextLevel;
  boolean first;
  color hue;
  int max;
  
  //init
  Level(boolean first, int length, int max)
  {
    this.max = max;
    this.first = first;
    points = new Point[length];
    for(int i = 0; i < length; i++)
    {
      points[i] = new Point();
      points[i].shade = 255 - 255/(float)length;
      if(first)
        points[i].randomize(width,height);
    }
    if(length >= 2)
      nextLevel = new Level(false, length - 1, max);
    hue = randomColor(points.length, max);
  }
  
  Point update(float t)
  {
    if(points.length > 2)
      return nextLevel.updateInner(t, points);
    else
      return points[0];
  }
  
  Point updateInner(float t, Point[] prev)
  {
    for(int i = 0; i < prev.length-1; i++)
    {
      points[i].x = prev[i].x * (1-t) + prev[i+1].x * t;
      points[i].y = prev[i].y * (1-t) + prev[i+1].y * t;
    }
    if(points.length >= 2)
      return nextLevel.updateInner(t, points);
    else
      return points[0];
  }
  
  void randomize(float maxX, float maxY, int max)
  {
    for(int i = 0; i < points.length; i++)
      points[i].randomize(maxX, maxY);
    hue = randomColor(points.length, max);
    if(points.length >= 2)
      nextLevel.hue = randomColor(points.length - 1, max);
  }
  
  color randomColor(int level, int max)
  {
    //return color(random(255), random(255), 255 - 255/(float)level);
    return color(255 - 255/level);
  }
  
  //draw lines
  void draw()
  {
    //draw points and lines of current level
    for(int i = 0; i < points.length-1; i++)
    {
      points[i].draw();
      strokeWeight(2);
      stroke(hue);
      line(points[i].x,points[i].y, points[i+1].x, points[i+1].y);
    }
    points[points.length-1].draw();
    
    //draw next level
    if(points.length >= 2)
      nextLevel.draw();
  }
}
