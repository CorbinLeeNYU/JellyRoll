// press space bar to begin

import com.leapmotion.leap.Controller;
import com.leapmotion.leap.Gesture;
import com.leapmotion.leap.Finger;
import com.leapmotion.leap.Frame;
import com.leapmotion.leap.Hand;
import com.leapmotion.leap.processing.LeapMotion;
import com.leapmotion.leap.Vector; 

import fisica.*;

// Leap

LeapMotion leap; 
// physics 
PImage eyes; 
int state; 
FWorld world;
Blob b;


ArrayList<Obstacles> ob;
ArrayList<Platform> hills; 
ArrayList<FLine> lines; 
ArrayList<Float> points; 
ArrayList<Shooter> s; 
ArrayList<Bee> bees;


FLine firstLine; 
Platform firstHill;
PImage jellyBackground;
PImage bg_11, bg_12; //level 1
PImage bg_21, bg_22; //level 2
PImage bg_31, bg_32; //level 3


// hand attributes
Vector rightHandPosition; 
int fingers = 0; 
boolean rightHand = false; 
boolean leftHand = false; 

float bg_1x = 0;
float bg_2x = 800;
void setup(){
  
  // leap 
  
  leap = new LeapMotion(this);
  // physics 
  jellyBackground = loadImage("start_screen.png");
  
  // background scrolling
  bg_11 = loadImage("kitchen_bg_1.png");
  bg_12 = loadImage("kitchen_bg_2.png");
  bg_21 = loadImage("park_bg_1.png");
  bg_22 = loadImage("park_bg_2.png");
  
  // set state
  state = 0; 
  size(800, 400);
  rightHandPosition = new Vector(0,0,0);
  
  // set world 
  Fisica.init(this); 
  world = new FWorld(); 
  world.setGravity(0, 100);
  
  hills = new ArrayList<Platform>(); 
  lines = new ArrayList<FLine>(); 
  points = new ArrayList<Float>(); 
  ob= new ArrayList<Obstacles>(); 
  s= new ArrayList<Shooter>();
  bees = new ArrayList<Bee>();
  
  b= new Blob(); 
  
  eyes = loadImage("eyes02.png");
  smooth(); 
  
  // set at the center of the blob
   firstLine = new FLine(width/2-40,height/2+20, width/2,height/2+20);
   firstHill = new Platform(width/2-40,height/2+20);
   
   // i would need to know where the previous x is to connect it to the next line
   firstLine.setStatic(true); 
   firstLine.setStrokeWeight(2);
   firstLine.setStroke(183,146,245); 
   
   lines.add(firstLine);  // add line to arrayListy
   float firstHeight = height/2+20;
   points.add(firstHeight); // add the height location of the first line to the array 
   world.add(firstLine); 
   hills.add(firstHill); 
}


float count = 0; 
float xPos = width/2; 
float yPos = 0;

void draw(){

   if(state == 0){
     
     // sample start screen
     imageMode(CENTER);
     image(jellyBackground, width/2,height/2);
  
     if(keyPressed && key== ' '){
       state = 1; 
     }
     
     
     
   }
  
  // level 1. challenge begins!! 
  if(state == 1){
    
   image(bg_11, bg_1x, 0);
   image(bg_12, bg_2x, 0);
   
   world.step();
   world.draw();
  
   // need a condition to see if right had is detected too 
   
   if(b.getX() > width/2-40){
     // add force so it doesn't fall
    // b.pushBack();
   }
   if(b.getX() <  width/2-80){
     // add force so it doesn't fall
    // b.pushFront();
   }
   
   
   if(fingers == 0 && rightHand){
     b.accelerate();
   }
   
   
   // pick an obstalcle 
   if((frameCount % 175) == 0){ 
     
      firstLevelObstacle();
     
   }
   
   // loop through obstacle 
   for(int i = 0; i<ob.size(); i++)
   {
     Obstacles o = ob.get(i);
     o.update();
     o.display();
     
     if(o.location.x < -600 ){
       ob.remove(o); 
       o.removeWorld();
     }
   }
   
   // create a new platform at everyframe count 
   if((frameCount % 1) == 0){
    
    // get the lastest point 
     int i = points.size()-1; 
     Float chosenY = points.get(i);
     
     // get new mouse location
     // replace mouseY with the y location of hand 
     // this is to calculate right hand position
     float mouseyLocation = 0; 
      
     // only if right hand is present 
     if(rightHand){
        mouseyLocation = height - rightHandPosition.getY(); 
     }
     
     // else get the newest recorded location
     // if only left hand or no hand 
     else{
        mouseyLocation = chosenY; 
     }
    
     // get the difference in height of the previous platform and this platform
     
     float difference =  mouseyLocation - chosenY; 
     // cover both ends of the spectrum 
     if(difference > 15 && mouseyLocation <= height-10 ){
       mouseyLocation = chosenY+0.5; 
     }
    
     else if(difference < -15 && mouseyLocation >= 10){
       mouseyLocation = chosenY-0.5; 
     }
     
     // create a new line
     // only if hand is present 
     // else draw it from chosenY 
     FLine l = new FLine(width/2,chosenY, width/2+2, mouseyLocation); 
     l.setStatic(true);
     l.setStrokeWeight(2); 
     l.setStroke(183,146,245);
     l.setNoFill();
     // create a new platform
     Platform h = new Platform(width/2,mouseyLocation);
     //add everything to their respective lists
     points.add(mouseyLocation);
     lines.add(l);
     world.add(l);
     hills.add(h); 

   }


// only compute size once-- all three arrays have the same size
   for(int i = 0; i< hills.size(); i++){
     
     Platform h = hills.get(i); 
     FLine li = lines.get(i);
     Float p = points.get(i);
     
     // adjust accordingly
     li.adjustPosition(-2,0); 
     h.adjust();
     
     // display hills too
     // h.display(); 
     
     if(h.location.x-10 < 200){
       // get X location from hill
       lines.remove(li);
       world.remove(li); 
       hills.remove(h);
       points.remove(p); 
     }
     
   }
  
  imageMode(CORNER);
  image(eyes,b.getX()-10,b.getY()-20);
 
 
  // skip to state two right away
  
  if(frameCount > 10000){
    state=2;

  }
  
  
  bg_1x -= .2;
  bg_2x -= .2;
  if (bg_1x <= -800)
    bg_1x = width;
  if (bg_2x <= -800)
    bg_2x = width;
 
 }  


  // level 2 
  
  if( state == 2 ){
   
    background(255); 
   
    image(bg_21, bg_1x, 0);
    image(bg_22, bg_2x, 0);
    
     world.step();
     world.draw();
 
  if(b.getX() > width/2-40){
    // b.pushBack();
   }
   if(b.getX() <  width/2-80){
     // add force so it doesn't fall
    // b.pushFront();
   }
  
  
  // accelerate when no fingers extended 
   if(fingers == 0 && rightHand){
     b.accelerate();
   }
   
  
   /// new obstacles!
   
   if(frameCount % 100 == 0){
     
     float distribution = random(1); 
     
     if(distribution < 0.30){
         
       Obstacles buzz = new Bee(); 
       ob.add(buzz); 
       
       Obstacles buzz2 = new Bee(); 
       ob.add(buzz2); 
      
     }
     
     else if (distribution < 0.45){
       
        Obstacles ball = new Ball(); 
        ob.add(ball); 
    
     }
     
     else{
       
       
     }
     
   }
   
   for(int i = 0; i<ob.size(); i++)
   {
     Obstacles o = ob.get(i);
     o.update();
     o.display(); 
     
     // check x y location of blob 
     if(o.hit(b.getX(), b.getY())){
       b.decelerate(); 
     }
 
     if(o.location.x < -600){
       
       // remove from arrayList
       ob.remove(o); 

      // remove from world 
       o.removeWorld();
       
     }

   } 
   
   // create a new platform at everyframe count 
   if((frameCount % 1) == 0){
    
    // get the lastest point 
     int i = points.size()-1; 
     Float chosenY = points.get(i);
     
     // get new mouse location
     // replace mouseY with the y location of hand 
     // this is to calculate right hand position
     float mouseyLocation = 0; 
      
     // only if right hand is present 
     if(rightHand){
        mouseyLocation = height-rightHandPosition.getY(); 
     }
     
     // else get the newest recorded location
     // if only left hand or no hand 
     else{
        mouseyLocation = chosenY; 
     }
    
     // get the difference in height of the previous platform and this platform
     
     float difference =  mouseyLocation - chosenY; 
     // cover both ends of the spectrum 
     if(difference > 15 && mouseyLocation <= height-10 ){
       mouseyLocation = chosenY+0.5; 
     }
    
     else if(difference < -15 && mouseyLocation >= 10){
       mouseyLocation = chosenY-0.5; 
     }
     
     // create a new line
     // only if hand is present 
     // else draw it from chosenY 
     
     FLine l = new FLine(width/2,chosenY, width/2+2, mouseyLocation); 
     l.setStatic(true);
     l.setStrokeWeight(2); 
     l.setStroke(183,146,245);
     l.setNoFill();
     // create a new platform
     Platform h = new Platform(width/2,mouseyLocation);
     //add everything to their respective lists
     points.add(mouseyLocation);
     lines.add(l);
     world.add(l);
     hills.add(h); 
     
   }
    

    for(int i = 0; i< hills.size(); i++){
     
     Platform h = hills.get(i); 
     FLine li = lines.get(i);
     Float p = points.get(i);
     
     // adjust accordingly
     li.adjustPosition(-2,0); 
     h.adjust();
     
     // display hills too
     // h.display(); 
     
     if(h.location.x-10 < 200){
       // get X location from hill
       lines.remove(li);
       world.remove(li); 
       hills.remove(h);
       points.remove(p); 
     }
     
   }
   
   imageMode(CORNER);
   image(eyes,b.getX()-10,b.getY()-20);
 
    
  }

  bg_1x -= .2;
  bg_2x -= .2;
  if (bg_1x <= -800)
    bg_1x = width;
  if (bg_2x <= -800)
    bg_2x = width;
  
 
}
 
 
 
 Vector fingerPosition (final Controller controller){
  

    if (controller.isConnected())
    {
        Frame frame = controller.frame();
        if (!frame.hands().isEmpty())
        {
          for (Hand hand : frame.hands())
          {
            
            if(hand.isRight()){
              // only get position if it's the right hand 
              Vector finger_stabilized = hand.stabilizedPalmPosition();
              return finger_stabilized; 
            }
  
          }
        }
  
    }
    
  Vector none = new Vector(width/2,height/3,0);
  return none; 
 
}
  
// count extended fingers
int countExtendedFingers(final Controller controller)
{
  int fingers = 0;
  if (controller.isConnected())
  {
    Frame frame = controller.frame();
    if (!frame.hands().isEmpty())
    {
      for (Hand hand : frame.hands())
      {
        int extended = 0;
        // count left fingers
        if(hand.isRight()){
        for (Finger finger : hand.fingers())
        {
          if (finger.isExtended())
          {
            extended++;
          }
        }
        fingers = Math.max(fingers, extended);
        }
      }
    }
  }
  return fingers;
}

boolean rightHandThere(final Controller controller){
  
  if(controller.isConnected()){
    
    Frame frame = controller.frame();
    if(!frame.hands().isEmpty()){
      
      for(Hand hand : frame.hands()){
        
        
        if(hand.isRight()){
          return true; 
        }  
      }

    }
    
  }
  
  return false; 
  
}


boolean leftHandThere(final Controller controller){
  
  if(controller.isConnected()){
    
    Frame frame = controller.frame();
    if(!frame.hands().isEmpty()){
      
      for(Hand hand : frame.hands()){
        
        
        if(hand.isLeft()){
          return true; 
        }  
      }

    }
    
  }
  
  return false; 
  
}  
 
 
// leap required  
void onFrame(final Controller controller)
{
  
  fingers = countExtendedFingers(controller);
  rightHandPosition = fingerPosition(controller);  //
  rightHand = rightHandThere(controller);
  leftHand = leftHandThere(controller);
  
//  Frame frame = controller.frame();  
//
//  
//  // Gesture detection
//  for (Gesture gesture : frame.gestures())
//  {
//    if ("TYPE_SWIPE".equals(gesture.type().toString()) && "STATE_START".equals(gesture.state().toString())) 
//    {
//      b.jump(lines);
//      println("JUMP");
//    }
//  }
}




//// Enable gestures
//void onInit(final Controller controller)
//{
//  controller.enableGesture(Gesture.Type.TYPE_SWIPE);
//  // enable background policy
//  controller.setPolicyFlags(Controller.PolicyFlag.POLICY_BACKGROUND_FRAMES);
//}


public void firstLevelObstacle(){
  
      // distribute them 
//     Obstacles newest = null;
//     float previousSize = 0;
//     float num = random(1); 
//     
//     // check that there at least is one obstacle in the arraylist
//     // get the lastest obstacle added
//     
//     if(ob.size() > 0){
//        //
//        float heightDistribution = random(1);
//        newest = ob.get(ob.size()-1); 
//        previousSize = newest.getHeight();
//        
//        if(heightDistribution < 0.50){
//          
//          previousSize-=25;
//          
//        }
//        else{
//          previousSize+=25;
//        }
//     }
//     // else if there is nothing 
//     else{
//        previousSize = height/2;
//     }
//     
//     
//     // between 0 and fourty create the top obstacle 
//     // 35 % 
//     if(num < 0.35){   // 0.35
//     
//     if(previousSize < 70){
//      previousSize= 75; 
//     }
//     
//     else if(previousSize > 280){
//       previousSize= 280 ; 
//     }
//      
//       Obstacles st= new Stalagtite(previousSize);   //previousSize
//       ob.add(st);
//
//     }
//    
//     //35%
//     else if(num<0.70){  // 0.70
//         
//         if(previousSize  < 150){
//           previousSize = 150;
//        }
//      
//        if(previousSize > height-80){
//            previousSize = height-125;
//         }
//          
//        Obstacles sm = new Stalagmite(previousSize);
//        ob.add(sm);
//     }
//     
//     //10 %
//     else if(num < 0.80){  // 0.80
//       Obstacles fs = new FallingStalagtite(100);
//      ob.add(fs);  
//     }
//     
//     // 20% 
//     else{
//         // have the difference between them be 50 
//         // don't actually change previous size 
//         float previousSize2 = previousSize + 70;
//         
//         if(previousSize2>280 ){
//           previousSize2 = 280; 
//         }
//         
//         Obstacles st = new Stalagtite(previousSize);
//         Obstacles sm= new Stalagmite(previousSize2);
//         ob.add(st);
//         ob.add(sm);
//     }

    float distribute = random(1); 
    
    if(distribute < 0.10){
      
      Obstacles lamp = new Lamp(); 
      ob.add(lamp);  
    }
    
    else if(distribute < 0.30){
      Scalpel s = new Scalpel();
     ob.add(s); 
    }
    
    else if(distribute < 0.70){
      Organs o = new Organs(); 
      ob.add(o); 
      
      Organs o2= new Organs();
      ob.add(o2); 
    }
       
  
}

public void secondLevelObstacle(){
  
  
  
  
  
  
  
}


