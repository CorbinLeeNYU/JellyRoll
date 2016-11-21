class Anchors extends Obstacles {
  
  int len = (int)random(4,9); 
  int heig = (int) random(100,250);  
  float frequency = 2;
  float damping = 1; 
  float yPosition; 
  FCircle anchor; 
  float x; 
  float boxPosition = width-20; 
  int boxWidth = 12; 
  Organs or; 
  FDistanceJoint jo;
  
  
   Anchors(){
    println(len);
    yPosition = 0; 
    super.location = new PVector(0,0);
    
//    for(int i = 0; i< steps.length; i++){
//      steps[i] = new FBox(boxWidth, 10);
//      steps[i].setPosition(width+50,  yPosition); 
//      steps[i].setNoStroke(); 
//      steps[i]. setFill(120,200,120); 
//      world.add(steps[i]); 
//    }
    
//    
//    for(int i = 1; i<steps.length; i++){
//     FDistanceJoint j = new FDistanceJoint(steps[i-1], steps[i]); 
//     j.setAnchor1(boxWidth/2 , 0);
//     j.setAnchor2(-boxWidth/2 , 0);
//     j.setFrequency(frequency);
//     j.setDamping(damping); 
//     j.setFill(255); 
//     j.calculateLength();
//     //j.setLength(10);
//     world.add(j); 
//   }
     
     
    anchor = new FCircle(10); 
    anchor.setStatic(true);
    anchor.setPosition(width+60,yPosition); 
    anchor.setDrawable(false);
    world.add(anchor); 
    
    // connect anchor to the first box 
//    FDistanceJoint jp = new FDistanceJoint(steps[0], anchor);
//    jp.setAnchor1(-boxWidth/2, 0);
//    jp.setAnchor2(boxWidth/2, 0);
//    jp.setFrequency(frequency);
//    jp.setDamping(damping);
//    jp.calculateLength();
//    jp.setFill(0);
//    jp.setLength(25);
//    world.add(jp);
     
//   FBody lastBox = steps[steps.length-1];
     
   or = new Organs(width+60 , heig/2);   // lastBox.getY()
   jo = new FDistanceJoint(anchor, or.getBody());
   jo.setAnchor1(boxWidth/2,0);
   jo.setAnchor2(0,-20); 
   jo.setFrequency(frequency); 
   jo.setDamping(damping);
   jo.calculateLength(); 
   jo.setFill(0);
   jo.setLength(heig);
   world.add(jo); 
     
     
   }
  
   void removeWorld()
   {
     world.remove(anchor);
     world.remove(jo);
     or.removeWorld(); 
   }
    
   boolean hit(float x, float y )
   {
     if(or.hit(x,y)) {
       return true; 
     }
     else {
       return false; 
     }
   }
  
  void display(){
  }
  
  float getHeight(){
    return 0; 
  }
    
  void update(){
   
   anchor.adjustPosition(x, 0);
   float swing = random(1); 
   if(swing < 0.8){
       x = -2;
   }
   
   or.update(); 
  
  }
    
    
  
}
