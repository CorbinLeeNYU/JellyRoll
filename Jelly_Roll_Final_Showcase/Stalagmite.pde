class Stalagmite extends Obstacles{
  
  // PVector location;
   FPoly l; 
   boolean hitBlob = false; 
   PImage bottomObstacle; 
   PImage bottomObstacle2; 
   PImage bottomObstacle3; 
   float obstacleHeight; 
   PImage toDisplay; 
  // int obstacleHeight = (int)(random(250,height-100));
 
 
   Stalagmite(float givenHeight){
   obstacleHeight = givenHeight; 
   bottomObstacle = loadImage("soda_bottle.png");
   bottomObstacle2 = loadImage("soda_bottle_2.png");
   bottomObstacle3= loadImage("soda_bottle_3.png");
   
     l = new FPoly(); 
     l.setStrokeWeight(3); 
     //l.setFill(120, 120, 190);
     l.setStatic(true); 
      l.setNoFill();
      l.setNoStroke();
   
   float pickRandomPic = random(1);
   if(pickRandomPic<0.333333){
     toDisplay = bottomObstacle;
     l.vertex(width+5,height);
     l.vertex(width+85,height);
     l.vertex(width+85, obstacleHeight+45);
     l.vertex(width+65, obstacleHeight+45);
     l.vertex(width+65,obstacleHeight+15);
     l.vertex(width+25, obstacleHeight+15);
     l.vertex(width+25,obstacleHeight+45);
     l.vertex(width+5, obstacleHeight+45);
   }
   else if(pickRandomPic<0.66666666){
     toDisplay = bottomObstacle2;
      l.vertex(width+5,height);
      l.vertex(width+85,height);
      l.vertex(width+85, obstacleHeight+45);
      l.vertex(width+65, obstacleHeight+45);
      l.vertex(width+65,obstacleHeight+15);
      l.vertex(width+20, obstacleHeight+15);
      l.vertex(width+20,obstacleHeight+45);
      l.vertex(width+5, obstacleHeight+45);
   }
   else{
      toDisplay = bottomObstacle3; 
     
      l.vertex(width+10,height);
      l.vertex(width+90,height);
      l.vertex(width+90, obstacleHeight+20);
      l.vertex(width+10,obstacleHeight+20);
 
     
   }
  
   smooth(); 
   world.add(l);
   super.location = new PVector(width-50,height);
  
  }
  
   void update(){
    l.adjustPosition(-scrollSpeed,0);
    super.location.x-=scrollSpeed;
  }
  
  
  void removeWorld(){
    
    world.remove(l);
    
  }
  
   public boolean hit(float x, float y){
    
       ArrayList<FContact> contactingbody = l.getContacts();
    
       if(contactingbody.size() > 0){
       
       for(int i = 0; i< contactingbody.size(); i++){
        
         // check if it came in contact with the blob 
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
    imageMode(CORNERS);
    image(toDisplay, super.location.x+50,obstacleHeight);  // will have to be a variable
 } 
 
 
   
  public float getHeight(){
    return obstacleHeight; 
  }

 
}
