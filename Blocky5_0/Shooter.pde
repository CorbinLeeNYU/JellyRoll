class Shooter {
  
  PVector location;
  
  Shooter(float x, float y){
    
    location = new PVector(x,y);
    
  }
  
  void update(){
    
    location.x+=2;
    
  }
  
  void display(){
    
    stroke(0);
    strokeWeight(2);
    fill(175,100);
    ellipse(location.x,location.y,10,10);
   
  }
  
  boolean leftScreen(){
    if(location.x > width+10){
      return true; 
    }
    else{
      return false; 
    }
  }
  
  boolean shot(Bee b){
    
    if( location.x == b.location.x  && location.y == b.location.y  ){
      return true;
    }
    else{
      return false;
    }
    
  }
  
  
  
}
