class Bee extends Obstacles {
 
  // make a fisica body 
  FCircle bee;
  float chosenHeight;  
  float chosenWidth; 
  float adjustY; 
  boolean hitBlob = false; 
  
  Bee(){
   
    // around here
    chosenHeight= random(30,height-30);
    chosenWidth = random(width, width+100);
    
    if(chosenHeight < height/2){
       adjustY = random(0,1);
    }
    else{
      adjustY = random(-1,0);
    }
    super.location = new PVector(chosenWidth, chosenHeight);
    bee = new FCircle(30);
    bee.setStrokeWeight(3); 
    bee.setStroke(190);
    bee.setStatic(true); 
    bee.setPosition(width, chosenHeight); 
    world.add(bee);
  }
 
  void update(){
    bee.adjustPosition(-2, adjustY);
    location.x-=2;
  }
  
  void display(){
    
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
  
  
  
}
