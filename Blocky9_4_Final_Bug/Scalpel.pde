class Scalpel extends Obstacles {

  FCircle c; 
  PImage scalpel; 
  float force = -1000; 
  float rad = 0; 
  int constant = 3; 
  
  Scalpel(){
    
     c = new FCircle(50); 
     c.setPosition(width,height); 
     scalpel = loadImage("scalpel.png");
   //  c.attachImage(scalpel); 
     c.setFill(255,255,255); 
     c.setRestitution(0.5);
     c.setRotatable(true); 
     world.add(c); 
     super.location = new PVector(0,0); 
   
   }

  
  void update(){
    
    c.addForce(-500,force); 
    c.setRotation(rad);
    force+=constant; 
    rad -= 0.05;
  }
  
  
  void display(){
     
    image(scalpel, c.getX(), c.getY());
  
  }


  void removeWorld(){
    
    world.remove(c); 
    
  }
  
  
  boolean hit(float x, float y ){
    
    return false; 
  }
  
  
  float getHeight(){
    
    return 0; 
    
  }
    

}
