class FallingStalagtite extends Obstacles{
  
   
  FPoly l; 
  PImage topObstacle;
  int obstacleHeight;
  boolean hitBlob = false; 
  FallingStalagtite(){
    
   obstacleHeight = (int)(random(50,200));
   topObstacle = loadImage("Stag.png");
   l = new FPoly(); 
   super.location = new PVector(width,0);
   l.vertex(width,0);
   l.vertex(width+120,0);
   l.vertex(width+50,obstacleHeight);
   l.setStrokeWeight(3); 
   l.setStroke(190);
   l.setStatic(true); 
   l.setFill(201,139,242);
   //l.setNoStroke();
                             
 //  l.setNoFill();
   smooth(); 
   world.add(l);
    
  
  }
  
  
  
   void update(){
   
    if(location.x < width/2-80){
      l.adjustPosition(-2,3);
    }
    else{
      l.adjustPosition(-2,0);
    }
    location.x-=2;
    imageMode(CORNERS);
  //  image(topObstacle, super.location.x-50,super.location.y-150);
    
  }
  
  
  
  void removeWorld(){
    
    world.remove(l);
    
  }
  
  
    public boolean hit(float x, float y){
    
       ArrayList<FContact> contactingbody = l.getContacts();
    
       if(contactingbody.size() > 0){
       
       for(int i = 0; i< contactingbody.size(); i++){
        
         if( contactingbody.get(i).getBody2() instanceof FCircle){
            contactingbody.remove(i);
            if(!hitBlob){
             hitBlob = true; 
             return true; 
            }
         }
         
         
       }
       
       
     }
     
     return false; 
    
  } 
  
  
  public void display(){
    
    
  }
  
  
  
  
  
  
}
