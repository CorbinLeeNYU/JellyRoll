import fisica.*;
import de.voidplus.leapmotion.*;
import development.*;

// Our world for the game
FWorld world; 
// The blob character
FBlob b;
// ADD COMMENT
//FBox platform; 
ArrayList<FBox> platform; 
ArrayList<FCircle> bubbles;
ArrayList<FBlob> blobs; 
FLine firstLine; 
ArrayList<FLine> lines; 




void setup() {

  size(740, 680);
  Fisica.init(this); 
  world = new FWorld(); 
  world.setGravity(0, 300);
  b= new FBlob(); 
  b.setAsCircle(width/2-40, height/2, 30, 20);
  b.setStroke(52, 73, 94);
  b.setStrokeWeight(3);
  b.setFill(46, 204, 113);
  b.setFriction(4);
  platforms = new ArrayList<FBox>(); 
  bubbles = new ArrayList<FCircle>();
  lines = new ArrayList<FLine>(); 
  blobs = new ArrayList<FBlob>(); 

  // firstLine = new FLine(5,height-50, 15,height-50);
  // firstLine.setStatic(true); 
  // firstLine.setStrokeWeight(8);
  // lines.add(firstLine); 
  //world.add(firstLine); 


  world.add(b); 
  // world.add(l);
  // world.add(platform);
}

// Starting x, y pos for the blob
float xPos = width/2; 
float yPos = 0;
void draw() {  
  background(255); 
  float bound = b.getX();

  //  if(bound >= width/2){
  // b.addForce(-3,0);
  /// }
  //else if(bound<=width/2-100){
  // b.addForce(3,0);
  //}

  /*
  if(keyPressed)
   {
   if(key==' '){
   b.addForce(3,-50);
   }
   }*/

  if ((frameCount % 1) == 0) {

    FCircle c = new FCircle(5);
    c.setFill(241, 196, 15);  
    c.setNoStroke();
    c.setStatic(true); 
    c.setPosition(width/2, mouseY); 
    // FBox f = new FBox(40,2);
    // f.setFill(0);
    // f.setStatic(true);
    // f.setPosition(width/2 ,mouseY);
    bubbles.add(c); 
    world.add(c);
  }


  if ((frameCount % 50)== 0) {
  }

  for (int i = 0; i< bubbles.size (); i++) {
    //FBox box = platforms.get(i);
    // box.adjustPosition(-1, 0);
    // if(box.getX() > width){
    //platforms.remove(i);
    //}

    FCircle circle = bubbles.get(i); 
    circle.adjustPosition(-1, 0);

    if (circle.getX () <  0) {
      world.remove(circle);
    }
  }




  world.step();
  world.draw();

  xPos+=0.5;
}


