class Organs extends Obstacles{
  
  FCircle f; 
  float rad=0; 
  PImage brain; 
  PImage kidney; 
  PImage heart; 
  boolean hitBlob = false; 
  
  Organs(float x, float y){
    
    f = new FCircle(30); 
    f.setPosition(x,y); 
    f.setRotatable(true); 
    //f.setRestitution(0.5);
   // f.setStatic(true); 
    brain = loadImage("brain.png");
    kidney = loadImage("kidney.png");
    heart = loadImage("heart.png");
    super.location = new PVector(0,0); 
    
    float pickPicture = random(1); 
    
    if(pickPicture < 0.33333){
      f.attachImage(brain); 
    }
    else if (pickPicture<0.66666){
      f.attachImage(kidney); 
    }
    else{
      f.attachImage(heart);
    }
    world.add(f); 
  }
  
  
  void removeWorld(){
    world.remove(f); 
  }
  
  void update(){
    
    f.addForce(-100,1000);
    
  }
  
  boolean hit(float x, float y){
  float distance = dist(x,y,f.getX(), f.getY());
  
//  
//   if( distance < 100){
//     // println("too close!!");
//      //return true; 
//    }

    return false; 

  }
 
  
  void display(){
  }
  
  
  float getHeight(){
    return 0; 
  }
  
  FCircle getBody(){
    return f ; 
  }
  
}
