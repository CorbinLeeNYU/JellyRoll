class Platform{
  
  // map out the color according to height 
  
  PVector location; 
  float r,g,b;
  
  
  Platform(float x,float y ){
    
    location = new PVector(x,y);
   
    float mappedBlue = map(y,0,500,0,255);
    r = 215; 
    g = 90;
    b = mappedBlue; 
    
  }
  
  void display(){
  
    fill(r,g,b,70); 
    noStroke();
    rect(location.x-3,location.y, 8, height-location.y); 
    
  }

   void adjust(){
   
    location.x-=2;
   
   }
   
   
}
  
