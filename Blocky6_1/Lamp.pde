class Lamp extends Obstacles{

FCircle top;
FBox bob;
FRevoluteJoint rod;
PImage lampPic;

int tick = 1;
boolean tickedLeft = true;
boolean tickedRight = false;


 Lamp(){
  
  lampPic = loadImage("lampshade.png");
  top = new FCircle(10);
  top.setPosition(width, -10);
  top.setFill(0);
  top.setNoStroke();
  top.setStatic(true);
  
  bob = new FBox(70,50);
  bob.setPosition(width, 170);
  bob.attachImage(lampPic);
  bob.setFill(255, 0, 0);
  bob.setNoStroke();
  bob.setDamping(0);
  
  rod = new FRevoluteJoint(top, bob, width, -10);
  //rod.setStrokeWeight(3); 
  //rod.setEnableLimit(true);
  //rod.setLowerAngle(15);
  //rod.setUpperAngle(-15);
  super.location  =  new PVector(0,0);
  world.add(top);
  world.add(bob);
  world.add(rod);
}


 void update(){
  
  if(abs(bob.getVelocityX()) < 4)
  {
    if(bob.getX() > 250 && !tickedRight)
    {
      tick++;
      tickedRight = true;
      tickedLeft = false;
    }
    if(bob.getX() < 250 && !tickedLeft)
    {
      tick++;
      tickedRight = false;
      tickedLeft = true;
    }
  }
  
  top.adjustPosition(-2,0); 
  
 }
 
 void removeWorld(){
   
   world.remove(top);
   world.remove(bob); 
   world.remove(rod); 

 }
 
 boolean hit(float x, float y){
   
   return false; 
 }
 
  void display(){
    
   
  }
  
  
  float getHeight(){
    return 0; 
  }
  
  

}

