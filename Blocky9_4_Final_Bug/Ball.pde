class Ball extends Obstacles{
  FCircle c; 
  PImage ball; 
  int r = (int)random(350,390);  // 
  float theta = PI/4;
  boolean hitBlob = false; 

  int constant = (int)random(3,5); 
  
  Ball(){
    
     c = new FCircle(42); 
     c.setPosition(width,height); 
     ball = loadImage("ball.png");
     c.setStatic(true); 
     c.setFill(0); 
     c.attachImage(ball);
     world.add(c); 
     super.location = new PVector(width,height); 
   }

  
  void update(){
   
 
    location.x = ((r*cos(theta)) + width/2)  ;
    location.y = ((r * sin(theta)) + width/2) + 130 ;
    c.setPosition(location.x,location.y); 
    theta-=0.01;

  }
  
  
  void display(){
    
    imageMode(CENTER); 
    image(ball, c.getX(), c.getY()); 
  }


  void removeWorld(){ 
    world.remove(c); 
  }
  
  
  boolean hit(float x, float y ){
    
       ArrayList<FContact> contactingbody = c.getContacts();
    
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
  
  
  float getHeight(){
    
    return 0; 
    
  }
    

}
