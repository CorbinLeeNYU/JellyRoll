class Anchors extends Obstacles {
  
  int len = (int)random(2,6); 
  int lenSpring = (350 - 30 * len) / len;
  int heig = (int) random(100,250);  
  float frequency = 0;
  float damping = 10; 
  float yPosition; 
  Organs[] steps = new Organs[len];
  FCircle anchor; 
  
  float x; 
  float boxPosition = width-20; 
  int boxWidth = 12; 
  //Organs[] or = new Organs[3];
  FDistanceJoint jo;
  
  
   Anchors(){
    println(len);
    yPosition = 0; 
    int lenSpring2 = lenSpring;
    super.location = new PVector(width+60, yPosition);
    float yPos = 30; 
    for(int i = 0; i< steps.length; i++){
      steps[i] = new Organs(width + 60, lenSpring2);
     // steps[i].setPosition(width+50,  yPosition); 
     // steps[i].setNoStroke(); 
     // steps[i]. setFill(120,200,120); 
     // world.add(steps[i]); 
     yPos+=100; 
     lenSpring2+=lenSpring; 
    }
    
    
    for(int i = 1; i<steps.length; i++){
     FDistanceJoint j = new FDistanceJoint(steps[i-1].getBody(), steps[i].getBody()); 
     j.setAnchor1(0 , -15);
     j.setAnchor2(0 , 15);
     j.setFrequency(frequency);
     j.setDamping(damping); 
     j.setFill(255); 
    // j.setStroke(255);
    // j.setStrokeWeight(2);
     j.calculateLength();
     j.setLength(lenSpring);
     world.add(j); 
   }
     
     
    anchor = new FCircle(10); 
    anchor.setStatic(true);
    anchor.setPosition(width+60,yPosition); 
    anchor.setDrawable(false);
    world.add(anchor); 
    
    // connect anchor to the first box 
    FDistanceJoint jp = new FDistanceJoint(steps[0].getBody(), anchor);
    jp.setAnchor1(0, 15);
    jp.setAnchor2(0, 0);
    jp.setFrequency(frequency);
    jp.setDamping(damping);
    jp.calculateLength();
    jp.setFill(255);
    //jp.setStroke(255); 
   // jp.setStrokeWeight(2); 
    jp.setLength(lenSpring);
    world.add(jp);
     
//   FBody lastBox = steps[steps.length-1];
     
//   or = new Organs(width+60 , heig/2);   // lastBox.getY()
//   jo = new FDistanceJoint(anchor, or.getBody());
//   jo.setAnchor1(boxWidth/2,0);
//   jo.setAnchor2(0,-20); 
//   jo.setFrequency(frequency); 
//   jo.setDamping(damping);
//   jo.calculateLength(); 
//   jo.setFill(0);
//   jo.setLength(heig);
//   world.add(jo); 
//     
     
   }
  
    void removeWorld(){
    for(int i = 0; i<steps.length; i++){
      
      Organs o = steps[i]; 
      o.removeWorld(); 
    }
   }
    
   boolean hit(float x, float y ){
   for(int i = 0; i<steps.length; i++){
      Organs o = steps[i]; 
      if(o.hit(x,y)){
        println("hey@");
        return true;  
      }
      else{
        return false; 
      }
    }
    // no object
    return false; 
  }
  
  void display(){
  }
  
  float getHeight(){
    return 0; 
  }
    
  void update(){
    
   anchor.adjustPosition(-scrollSpeed, 0);
   //or.update(); 
   
    for(int i = 0; i<steps.length; i++){
      Organs o = steps[i]; 
      o.update(); 
    }
   super.location.x-=scrollSpeed; 
  }
    

  
}
