class Stalagtite extends Obstacles{
  
 // create a 
  FPoly l; 
  boolean hitBlob = false; 
  PImage toDisplay; 
  PImage topObstacle1;
  PImage topObstacle2; 
  PImage topObstacle3;
  PImage topObstacle4; 
  
  float obstacleHeight;
  
   Stalagtite(float givenHeight){
   //obstacleHeight = (int)(random(100,200));
   obstacleHeight = givenHeight; 
   topObstacle1 = loadImage("top_ooze_1.png");   
   topObstacle2 = loadImage("top_ooze_2.png");
   topObstacle3= loadImage("top_ooze_3.png");
   topObstacle4 = loadImage("top_ooze_4.png");
   
   l = new FPoly(); 
   super.location = new PVector(width,0);
   
   l.setNoStroke();                          
   l.setNoFill();
  
  float pictureDistribution = random(1);
  
  if(pictureDistribution < 0.33333){
    toDisplay = topObstacle1; 
    l.vertex(width+10,0);
    l.vertex(width+75,0); 
    l.vertex(width+75,obstacleHeight);
    l.vertex(width+50,obstacleHeight);
    l.vertex(width+10, obstacleHeight-50);  // obstacleheight - 550
  }
  else if(pictureDistribution <0.6666666){
    
   toDisplay = topObstacle2;
   l.vertex(width+10,0); //1
   l.vertex(width+80,0);   //2
   l.vertex(width+80,obstacleHeight-10);  //3 
   l.vertex(width+40,obstacleHeight-10);  //4   l.vertex(width+40, obstacleHeight-100);  //5
   l.vertex(width+10,obstacleHeight-200);  // 6
  }
  
  else{
    
   toDisplay = topObstacle3;
    l.vertex(width+10,0); //1
    l.vertex(width+75,0);   //2
    l.vertex(width+75, obstacleHeight);  // 7
    l.vertex(width+50, obstacleHeight); // 8
    l.vertex(width+50,obstacleHeight-50); //9
    l.vertex(width+10, obstacleHeight-50); //10
  
  }
  
   l.setStatic(true); 
   world.add(l);

  
  }
  
  void update(){
    
    l.adjustPosition(-scrollSpeed,0);
    location.x-=scrollSpeed;
  
    
  }
  
  
  void removeWorld(){
    
    world.remove(l);
    
  }
  
   public boolean hit(float x, float y){
    
     ArrayList<FContact> contactingbody = l.getContacts();
   
     if(contactingbody.size() > 0){
       
       for(int i = 0; i< contactingbody.size(); i++){
         
         if( contactingbody.get(i).getBody2() instanceof FCircle){
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
     
      float y =  obstacleHeight-300;
      imageMode(CORNERS);
      image(toDisplay, super.location.x, y );
   } 
 
 
   
  public float getHeight(){
    
    return obstacleHeight; 
    
  }

}
