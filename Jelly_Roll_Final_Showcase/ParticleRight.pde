class ParticleRight{
  
   PVector location; 
   PVector velocity; 
   PVector acceleration; 
   float lifespan; 
   float mass = 1; 
  // PImage particleImage; 
    int red = (int)random(50,250);
    int green = 10;
    int blue = (int)random(50,250);
  
  ParticleRight(PVector l){
    
    acceleration = new PVector(); 
    velocity = new PVector(random(-4,-3), random(-5.5,0)); 
    location = l.get(); 
    lifespan = 255; 
  
  }
  
  
  void run(){
    
    update();
    display();
  }
  
  void update(){
    velocity.add(acceleration);
    location.add(velocity); 
    acceleration.mult(0); 
    lifespan-=2.5; 
  }
   
  void display(){
    
     float theta = map(location.x,0,width,0,TWO_PI * 2);
     
     pushMatrix();
     translate(location.x,location.y);
     rotate(theta);
     fill(red,green,blue,lifespan); 
     noStroke(); 
     rect(0,0,8,8); 
     popMatrix(); 
    
  }
  
  
   boolean isDead(){
    
    if(lifespan<0.0){
      return true; 
    }
    else{
      return false; 
    }
    
    
  }
  
  
  void applyForce(PVector force){
    
    PVector f = force.get();
    f.div(mass);
    acceleration.add(f); 
    
    
  }
  
  
}
