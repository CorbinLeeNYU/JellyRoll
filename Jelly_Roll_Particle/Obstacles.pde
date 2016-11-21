public abstract class Obstacles{
  
  PVector location;
  abstract float getHeight();
  abstract void update();
  abstract void removeWorld();
  abstract boolean hit(float x, float y);
  abstract void display();
  
}
