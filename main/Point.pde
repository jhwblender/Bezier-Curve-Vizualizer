class Point
{
  float x, y;
  float shade = 0;
  
  Point()
  {
    x=0;
    y=0;
  }
  Point(int x, int y)
  {
    this.x = x;
    this.y = y;
  }
  Point(Point copy)
  {
    x = copy.x;
    y = copy.y;
  }
  
  void randomize(float maxX, float maxY)
  {
    x = random(maxX);
    y = random(maxY);
  }
  
  void draw()
  {
    strokeWeight(10);
    stroke(shade);
    point(x, y);
  }
}
