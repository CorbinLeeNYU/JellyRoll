class Bee extends Obstacles {
 
  // make a fisica body 
  FCircle bee;
  float chosenHeight;  
  float chosenWidth; 
  float adjustY; 
  boolean hitBlob = false; 
  Animation beez;
  
  Bee(){
   
    // around here
    chosenHeight= random(30,height-30);
    chosenWidth = random(width, width+500);
    beez= new Animation("bee0",3);
    
    if(chosenHeight < height/2){
       adjustY = random(0,0.6);
    }
    else{
      adjustY = random(-0.6,0);
    }
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
    bee.adjustPosition(-scrollSpeed, adjustY);
    location.x-=scrollSpeed;
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
