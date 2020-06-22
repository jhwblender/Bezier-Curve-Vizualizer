class Curve
{
  ArrayList<Point> points;
  color hue; 
  
  Curve()
  {
    points = new ArrayList<Point>();
    clear();
  }
  
  void draw()
  {
    strokeWeight(4);
    stroke(hue);
    for(int i = 0; i < points.size() - 1; i++)
    {
      line(points.get(i).x, points.get(i).y, points.get(i+1).x, points.get(i+1).y);
    }
  }
  
  void push(Point point)
  {
    points.add(new Point(point));
  }
  
  void pop()
  {
    if(points.size() > 0)
      points.remove(points.size()-1);
  }
  
  void clear()
  {
    points.clear();
    hue = color(random(255), random(255), random(255));
  }

}
