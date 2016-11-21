class Blob {

  FBlob bobby;        // FBlob object
  float size;         // Size of the blob
  int vCount = 20;    // Vertex count

  // Default Constructor
  Blob()
  {
    size = 30; 
    bobby= new FBlob(); 
    bobby.setAsCircle(startX, startY, 30, 20);
    //bobby.setStroke(142, 68, 173);
   // bobby.setStrokeWeight(3);
    bobby.setFill(155, 89, 182); 
    bobby.setFriction(4);
    bobby.setGrabbable(false);    
    bobby.setNoStroke(); 
    world.add(bobby);
  }

  // Constructor
  Blob(float startX, float startY)
  {
    size = 30; 
    bobby= new FBlob(); 
    bobby.setAsCircle(startX, startY, 28, 20);
   // bobby.setStroke(142, 68, 173);
    bobby.setNoStroke(); 
    bobby.setStrokeWeight(3);
    bobby.setFill(155, 89, 182); 
    bobby.setFriction(4);
    bobby.setGrabbable(false);    
    world.add(bobby);
  }


  /*
   * Adds a force to the blob relative to the angle of roll passed in
   */
  public void accelerate(float roll)
  {
    bobby.addForce(map(roll, 2, -2, -45, 45), -6);
  }
  
  public void decelerate(){
    bobby.addForce(-60,5); 
  }
  
  /*
   * Adds a force of dx to the x direction and dy to the y direction
   */
  public void addForce(float dx, float dy)
  {
    bobby.addForce(dx, dy);
  }

  
  /*
  // Jump method for the blog (blob can only jump when touching
  // and on top of the platform)
  void jump(ArrayList<FLine> lines)
  {
    int numLines = lines.size();
    // skip 10 verticles 
    for (int i = 0; i < numLines; i++)
    {
      // Check if the blob is touching the box and above it
      if (isTouchingBody((FBody)lines.get(i))) //&& getY() < lines.get(i).getY())
      {
        bobby.addForce(3, -1000);
        return;
      }
    }
  }
  */
  
  /*
   * Returns true if one of the vertices of this blob is touching
   * the FBody passed in (created my own method because the one
   * in the fisica library doesn't work for blobs)
   */
  boolean isTouchingBody(FBody body)
  {
    for (int i = 0; i < vCount; i++)
    {
      if (((FBody)bobby.getVertexBodies().get(i)).isTouchingBody(body))
      {
        return true;
      }
    }
    return false;
  }


  /*
   * Get and Set methods
   */
  FBlob getBlob() { return bobby; }
  
  /*
   * getX() and getY() return the average x and y values of the vertices of the 
   * blob, respectively.
   */
  public float getX() {
    float x = 0;
    vCount = bobby.getVertexBodies().size();
    for (int i = 0; i < vCount; i++)
    {
      x += ((FBody)bobby.getVertexBodies().get(i)).getX();
    }
    x /= vCount;

    return x;
  }
  public float getY() {
    float y = 0;
    vCount = bobby.getVertexBodies().size();
    for (int i = 0; i < vCount; i++)
    {
      y += ((FBody)bobby.getVertexBodies().get(i)).getY();
    }
    y /= vCount;

    return y;
  }  
  
}

