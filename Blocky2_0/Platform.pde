class Platform
{
  // World where the platform exists
  FWorld world;
  
  // Array list to hold all of the boxes in the platform
  ArrayList<PBox> boxes;
  
  // The x and y pos of the frontmost box
  float headY, headY;
  
  // The x and y pos where a new box will be added
  float x, y;
  
  // Size of the boxes in the platform
  float bSize;
  
  // Constructor
  Platform(FWorld world, float x, float bSize) 
  {
    this.world = world;
    this.x = x;
    this.bSize = bSize;
    boxes = new ArrayList<PBox>();
  }
  
  // Adds dX and dY to the x and y positions, respectively, of all
  // boxes in the platform
  void move(float dX, float dY)
  {
    for (int i = 0; i < boxes.size(); i++)
    {
      boxes.get(i).move(dX, dY);
    }
  }
  
  // Adds a box to the platform
  void addBox(float x, float y, boolean xFlag)
  {
    // Updating the x value is optional since it should be constant
    // for the most part
    if (xFlag) this.x = x;
    this.y = y;
    
    boxes.add(new PBox(world, x, y, bSize));
  }
  
  // Removes the last box in the array list
  void removeLastBox()
  {
    // Remove the FBox from the world
    boxes.get(boxes.size() - 1).removeBox();
    // Remove the PBox from our list
    boxes.remove(boxes.size() - 1);
  }
  
  // Boolean tells if the last box is off the screen
  boolean lastBoxOffScreen()
  {
    return boxes.get(boxes.size() - i).isOffScreen();
  }
}
