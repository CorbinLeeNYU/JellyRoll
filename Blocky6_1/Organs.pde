class Organs extends Obstacles{
  
  FCircle f; 
  float rad=0; 
  PImage brain; 
  PImage kidney; 
  PImage heart; 
  
  Organs(){
    
    int pickX = (int)random(150,width-150);
    int pickY = (int)random(-100,-10);
    f = new FCircle(30); 
    f.setPosition(pickX, pickY); 
    f.setRotatable(true); 
    f.setRestitution(0.5);
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
    
    f.setRotation(rad); 
    rad+=0.01; 
    
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
