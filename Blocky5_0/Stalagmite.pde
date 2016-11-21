class Stalagmite extends Obstacles{
  
  // PVector location;
   FPoly l; 
   boolean hitBlob = false; 
   PImage bottomObstacle; 
   float obstacleHeight; 
  // int obstacleHeight = (int)(random(250,height-100));
   
   
   Stalagmite(float givenHeight){
   obstacleHeight = givenHeight; 
   bottomObstacle = loadImage("Stalagmite.png");
   l = new FPoly(); 
   l.vertex(width,height);
   l.vertex(width+100,height);
   l.vertex(width+50,obstacleHeight);
   l.setStrokeWeight(3); 
   l.setFill(120, 120, 190);
   l.setStatic(true); 
    //l.setNoFill();
   // l.setNoStroke();
   smooth(); 
   world.add(l);
   super.location = new PVector(width-50,height);
  
  }
  
   void update(){
    l.adjustPosition(-2,0);
    super.location.x-=2;
    imageMode(CORNERS);
    //image(bottomObstacle, super.location.x+20,height/2);
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
   
   
 } 
 
 
}
