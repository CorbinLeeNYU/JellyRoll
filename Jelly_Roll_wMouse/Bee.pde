class Bee extends Obstacles {
 
  // make a fisica body 
  FCircle bee;
  float chosenHeight;  
  float chosenWidth; 
  float adjustY, adjustX; 
  boolean hitBlob = false; 
  Animation beez;
  float range;
  float perlinY;
  float perlinX;
  
  Bee(){
   
    // around here
    chosenHeight= random(30,height-30);
    chosenWidth = random(width, width+500);
    beez= new Animation("bee0",3);
    perlinY = random(10000);
    perlinX = random(10000);
    
//    if(chosenHeight < height/2){
//      range = 1.2;
//    }
//    else{
//      range = -1.2;
//    }
    
    range = 2;
    
    super.location = new PVector(chosenWidth, chosenHeight);
    bee = new FCircle(30);
    bee.setStrokeWeight(3); 
    bee.setStroke(190);
    bee.setNoStroke();
    bee.setNoFill();
    bee.setStatic(true); 
    bee.setPosition(chosenWidth, chosenHeight); 
    world.add(bee);
  }
 
  void update(){
    adjustY = map(noise(perlinY), 0, 1, -range, range);
    adjustX = map(noise(perlinX), 0, 1, -scrollSpeed - range, -scrollSpeed + range);
    
    bee.adjustPosition(adjustX, adjustY);
    location.x-=scrollSpeed;
    
    // Update perlinY
    perlinY += 0.01;
    perlinX += 0.01;
  }
  
  void display(){
    beez.display(bee.getX(), bee.getY());
  }
  
  void removeWorld(){
    
   world.remove(bee); 
    
  }
  
  public boolean hit(float x, float y){
   
   ArrayList<FContact> contactingbody = bee.getContacts();
    
       if(contactingbody.size() > 0){
       
       for(int i = 0; i< contactingbody.size(); i++){
        
         // check if it came in contact with the blob 
         if( contactingbody.get(i).getBody2() instanceof FCircle){
           
           
           if(!hitBlob){
             return true; 
           }

         }
         
         
       }
       
       
     }
     
    return false; 
    
  }
  
  
  public float getHeight(){
    
    return 0;
    
  }
  
  
  
}
