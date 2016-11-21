class Ball extends Obstacles{

  FCircle c; 
  PImage ball; 
  float force = -1000; 
 
  int constant = (int)random(3,5); 
  
  Ball(){
    
     c = new FCircle(50); 
     c.setPosition(width,height); 
     ball = loadImage("ball.png");
     c.attachImage(ball);
     c.setRestitution(0.5);
     world.add(c); 
     super.location = new PVector(0,0); 
   
   }

  
  void update(){
    
    c.addForce(-500,force); 
    force+=constant; 

  }
  
  
  void display(){
     
  
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
