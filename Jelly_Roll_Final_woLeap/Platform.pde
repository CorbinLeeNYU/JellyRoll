/*
 * Platform to hold up the blob. Constructed using an arraylist of FLine objects.
 */
class Platform
{
  ArrayList<FLine> lines;  // List holding all the FLines
  float prevX, prevY;      // Holds the x and y pos of the last line added to the platform
  int numLines;            // Number of FLines in the Platform

  // Constructor
  Platform(float startX, float startY)
  {
    prevX = startX;
    prevY = startY;
    lines = new ArrayList<FLine>();
    numLines = 0;
  }

  /*
   * Adds a line to the platform from (prevX, prevY) to (prevX+dx, y)
   */
  void addLine(float dx, float handY, boolean constantX)
  {
    FLine l;
    
    if (constantX)
    {
      
      // If -1 is passed in for hand Y there is no hand present so we draw a horizontal line from prevY
      if (handY == -1)
      {
        l = new FLine(prevX, prevY, prevX + dx, prevY);
        prevX += dx;   // Update prevX 
      } else
      {
        float dy = handY - prevY;
        if (dy > 10*scrollSpeed) dy = 10*scrollSpeed;          // The line can only have a
        else if (dy < -10*scrollSpeed) dy = -10*scrollSpeed;   // slope between -40 and 40
        l = new FLine(prevX, prevY, prevX + dx, prevY + dy);
        prevX += dx;   // Update prevX
        prevY += dy;   // Update prevY
      }
    } else
    {
      if (handY == -1)
      {
        l = new FLine(prevX, prevY, dx, prevY);  
        prevX = dx;      
      } else
      {
        l = new FLine(prevX, prevY, dx, handY);
        
        prevX = dx;
        prevY = handY;
      }
    }
    
    l.setFriction(0);
    l.setStatic(true);
    l.setStrokeWeight(5); 
    l.setStroke(183, 146, 245);
    l.setNoFill();
    lines.add(l);    // Add the FLine to the ArrayList
    world.add(l);    // Add the FLine to the FWorld
    numLines++;      // Increment numLines
  }

  /*
   * Removes the last line on the platform (first line in the list)
   */
  void removeLastLine()
  {
    world.remove(lines.get(0));    // Remove the FLine from the FWorld
    lines.remove(0);               // Remove the FLine from the ArrayList
    numLines--;                    // Decrement numLines
  }
  
  /*
   * Removes All lines from the list and the world
   */
  void removeAllLines()
  {
    int numLines = lines.size();
    while (!lines.isEmpty())
    {
      world.remove(lines.get(0));    // Remove the FLine from the FWorld
      lines.remove(0);               // Remove the FLine from the ArrayList
      numLines--;                    // Decrement numLines
    }
  }

  /*
   * Adds dx and dy to the x and y positions, respectively, of all the lines in the platform 
   */
  void move(float dx, float dy)
  {
    for (int i = 0; i < numLines; i++)
    {
      lines.get(i).adjustPosition(dx, dy);
    }
    prevX += dx;    // Adjust prev x position 
    prevY += dy;    // Adjust prev y position
  }
  
  /*
   * Get and set methods
   */
  int getNumLines() { return lines.size(); }
}

