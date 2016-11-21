/* Minim Library for sound */
import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;

/* Iterator class */
import java.util.Iterator; 

/*ADI IMPORT*/
import com.leapmotion.leap.SwipeGesture;



/* Leap Motion Library */
import com.leapmotion.leap.Controller;
import com.leapmotion.leap.Gesture;
import com.leapmotion.leap.Finger;
import com.leapmotion.leap.Frame;
import com.leapmotion.leap.Hand;
import com.leapmotion.leap.processing.LeapMotion;
import com.leapmotion.leap.Vector; 


/*ADI VARIABLES*/
PImage cut1A, cut1B, cut2A, cut2B, cut3A, cut3B, cut2Atemp, cut3Atemp, cut4A, cut4B, cut4Atemp, cut1Atemp;
PImage current1A, current1B, current2A, current2B, current3A, current3B;
PImage one_a, one_b, two_a, two_b, three_a, three_b;






boolean toFlipRightToLeft;
boolean toFlipLeftToRight;
float angle;
float angle2 = PI;
boolean toContinue;
SwipeGesture swipe;
int page = 0;
int directionTurned = 1;

int z = 0;
int secondCount = 1;
int currentTimeInState = 0;
int timeToStayInState = 100;



/* Fisica library for the physics of the game */
import fisica.*;

int lives = 3;             // Blobs lives
int numLives = 3;          // Number of lives the blob starts with
int state;                 // Game state 
int level;                 // Level of the game we are currently in
float scrollSpeed = 8;     // Speed at which the game scrolls (in pixels/frame)
float roll = 0;            // Roll angle of right hand
float rollThresh = 0.3;    // Threshold for roll to have an effect of the blob
LeapMotion leap;           // Leap object
PImage eyes;               // Eye image for the blob 
PImage eyes2;              // Eye partially closed image
PImage eyes3;              // Eye closed image
PImage thermometer;        // Thermometer image for the blob for when it gets sick
FWorld world;              // Fisica World
Blob b;                    // Our blob character
FBox bed;                  // FBox for the blob to rest on inthe final hospital scene
float startX, startY;      // Start x and y positions for the blob
Platform p;                // Platform object to hold up the blob
float pWidth;              // Width of the platform
ArrayList<Obstacles> ob;   // Obstacles
FLine firstLine;           // Initial line at beginning of game
float bg1x, bg2x, bg3x;    // X values for the background images (y values are constant)
int bgCount;               // Count for the number of background images loaded
int bgPerLevel = 2;        // Number of times a background image is loaded per level (MUST BE EVEN)
int gameTimer;             // Number of frames since the start of the game
int gameOverTimer;         // Timer to handle the game over animation
int gameOverTime = 540;    // Number of frames the game over animation lasts
int winGameTimer;          // Timer to assist with the win game animation
int winGameTime = 900;     // Number of frames the win game animation lasts
boolean newGame;           // Is a new game being started
boolean startScreenStart;  // First frame of the Start Screen 
boolean gameOver;          // Has the blob lost all of its lives
boolean transition;        // If the next image to be loaded is a transition slide
boolean inTransition;      // If The game is currently scrolling through a transition slide
boolean newLevel;          // Have we reached a new level
boolean isDead;            // Has the blob fallen off screen
Vector rightHandPos;       // Right hane position 
int extRFingers = 0;       // Number of extended right hand fingers detected by leap
boolean rightHand = false; // if a right hand is detected by leap
boolean leftHand = false;  // if a left hand is detected by leap

/* Images */
PImage start_screen;       // Start screen image
PImage win_screen;         // Screen displayed if the game was won
PImage bg1;                // Background image 1
PImage bg2;                // Background image 2
PImage bg3;                // Background image 3 (used for last background in game)
boolean lastBG;            // Tells if we've reached the last background
boolean end;               // The last background has reached hit the end of the screen
ParticleSystemRight s;     // create a particle system for the winning screen
ParticleSystemLeft l;


/* Audio controllers and files */
Minim minim;
AudioPlayer flatline;
AudioPlayer beep;
AudioPlayer inGame;
AudioPlayer winGame;
AudioPlayer startScreen;
boolean isBeep = true;

void setup()
{ 
  // TODO test with OPENGL as well
  size(800, 400, OPENGL);
  smooth();


  leap = new LeapMotion(this);    // Leap object
  state = 0;                      // Initialize the state to 0;
  startScreenStart = true;
  rightHandPos = new Vector(0, 0, 0);
  Fisica.init(this);              // Initialize the fisica library 
  world = new FWorld();           // Fisica world object
  world.setGravity(0, 150);       // Set the gravity of the world
  pWidth = 200;                   // Set width of the platform
  minim = new Minim(this);
  flatline = minim.loadFile("flatline.wav");
  beep = minim.loadFile("beep.wav");
  inGame = minim.loadFile("inGame.mp3");
  startScreen = minim.loadFile("startScreen.mp3");
  winGame = minim.loadFile("winGame.wav");

  /* Start the blob at (width/2 - 20, height/2 - 40) */
  startX = width/2 - 100;
  startY = height/2 - 40;

  /* Construct ArrayLists */
  ob= new ArrayList<Obstacles>();

  /* Load images */
  start_screen = loadImage("start_screen.png");  
  win_screen = loadImage("win_screen.png");
  eyes = loadImage("eyes02.png");
  eyes2 = loadImage("eyes02_2.png");
  eyes3 = loadImage("eyes02_3.png");

  /*ADI VARIABLES*/

  cut1A = loadImage("page_1A.png");
  cut1B = loadImage("page_1B.png");
  cut2A = loadImage("page_2A.png");
  cut2B = loadImage("page_2B.png");
  cut3A = loadImage("page_3A.png");
  cut3B = loadImage("page_3B.png");
  cut4A = loadImage("countdown_1A.png");
  cut4B = loadImage("countdown_1B.png");
  cut2Atemp = loadImage("page_2Atemp.png");
  cut3Atemp = loadImage("page_3Atemp.png");
  cut4Atemp = loadImage("countdown_1Atemp.png");
  cut1Atemp = loadImage("page_1Atemp.png");
  one_a = loadImage("countdown_1A.png");
  one_b = loadImage("countdown_1B.png");
  two_a = loadImage("countdown_2A.png");
  two_b = loadImage("countdown_2B.png");
  three_a = loadImage("countdown_3A.png");
  three_b = loadImage("countdown_3B.png");


  current1A = cut1A;
  current1B = cut1B;
  current2A = cut2A;
  current2B = cut2B;
  current3A = cut3A;
  current3B = cut3B;


  toContinue = true; 
  /*END ADI VARIABLES*/
}


void draw() {
  
  background(0);



  if (state == 0)        /* Start Screen */
  {
    background(0);
    println("toContinue: " + toContinue);

    if (startScreenStart)
    {
      // Play the music
      startScreen.pause();
      startScreen.rewind();
      startScreen.loop();
      startScreenStart = false;
    }



    //start page state
    if (page == 0) {

      if (directionTurned == 1) {
        //image of next page that is uploaded after 1B is turned
        //image 2B uploaded when 1B is turned
        pushMatrix();
        translate(width/2, 0, z);
        image(cut2B, 0, 0, width/2, height);
        popMatrix();

        //image 1A, the image that will be replaced with 2A once page is turned
        pushMatrix();
        translate(0, 0, z);
        image(current1A, 0, 0, width/2, height);
        popMatrix();

        //image 1B, the image that is being turned
        pushMatrix();
        //fill(r2, g2, b2);
        translate(width/2, 0, z);
        rotateY(angle);
        //current1B is set to cut 1B initially. 
        //when it gets turned -90 degrees, current 1B = cut2A
        image(current1B, 0, 0, width/2, height);
        popMatrix();
      } else if (directionTurned == 0) {
        println("HI!!!!!!!!!!!!!!");
        println("DIC = 0");
        //will appear when page is turned backward
        pushMatrix();
        translate(0, 0, z);
        image(cut4A, 0, 0, width/2, height);
        popMatrix();

        //image 1B, gets replaced by image 4B once completely turned
        pushMatrix();
        translate(width/2, 0, z);
        image(cut1B, 0, 0, width/2, height);
        popMatrix();


        //current1A is set to cut1A at steady state
        //When it is turned, after 90 degrees, switches to 4B
        pushMatrix();
        translate(width/2, 0, z);
        rotateY(angle2);
        image(current1A, 0, 0, width/2, height);
        popMatrix();
      }
    }

    //story page state
    else if (page == 1) {   


      if (directionTurned == 1) {

        //will appear when page is turned forward
        pushMatrix();
        translate(width/2, 0, z);
        image(cut3B, 0, 0, width/2, height);
        popMatrix();

        //image 2A, the image that replaces 1A once page completely turns
        pushMatrix();
        translate(0, 0, z);
        image(cut2A, 0, 0, width/2, height);
        popMatrix();


        //current2B is set to cut2B at steady state.
        //When it is turned, after -90 degrees, switches to 3A
        pushMatrix();
        //fill(r2, g2, b2);
        translate(width/2, 0, z);
        rotateY(angle);
        image(current2B, 0, 0, width/2, height);
        popMatrix();
      }

      //directionTurned = 0, means we are turning left to right, so upload cut2A

      else if (directionTurned == 0) {

        println("DIC = 0");
        //will appear when page is turned backward
        pushMatrix();
        translate(0, 0, z);
        image(cut1A, 0, 0, width/2, height);
        popMatrix();

        //image 2B, gets replaced by image 1B once completely turned
        pushMatrix();
        translate(width/2, 0, z);
        image(cut2B, 0, 0, width/2, height);
        popMatrix();


        //current2A is set to cut2A at steady state
        //When it is turned, after 90 degrees, switches to 1B
        pushMatrix();
        translate(width/2, 0, z);
        rotateY(angle2);
        image(current2A, 0, 0, width/2, height);
        popMatrix();
      }
    } else if (page == 2) {   


      if (directionTurned == 1) {

        //will appear when page is turned 
        pushMatrix();
        translate(width/2, 0, z);
        image(cut4B, 0, 0, width/2, height);
        popMatrix();

        //image 4A, the image that replaces 3A once page completely turns
        pushMatrix();
        translate(0, 0, z);
        image(cut3A, 0, 0, width/2, height);
        popMatrix();


        //current3B is set to cut3B at steady state.
        //When it is turned, after -90 degrees, switches to 3A
        pushMatrix();
        //fill(r2, g2, b2);
        translate(width/2, 0, z);
        rotateY(angle);
        image(current3B, 0, 0, width/2, height);
        popMatrix();
      } else if (directionTurned == 0) { 

        //will appear when page is turned backward
        pushMatrix();
        translate(0, 0, z);
        image(cut2A, 0, 0, width/2, height);
        popMatrix();

        //image 3B, gets replaced by image 2B once completely turned
        pushMatrix();
        translate(width/2, 0, z);
        image(cut3B, 0, 0, width/2, height);
        popMatrix();


        //current3A is set to cut3A at steady state
        //When it is turned, after 90 degrees, switches to 2B
        pushMatrix();
        //fill(r2, g2, b2);
        translate(width/2, 0, z);
        rotateY(angle2);
        image(current3A, 0, 0, width/2, height);
        popMatrix();
      }
    }

    //toFlip will be returned false if no swipe detected and during animation

    //start game if page -1, this is when you swipe left to right from start page 
    if (page == -1) {
      //this.state = 1, start game


      currentTimeInState += 1;

      println("SECONDS: " + secondCount);

      if (secondCount == 1) {
        //image 4A, the image that replaces 3A once page completely turns
        pushMatrix();
        translate(0, 0, z);
        image(one_a, 0, 0, width/2, height);
        popMatrix();

        pushMatrix();
        translate(width/2, 0, z);
        image(one_b, 0, 0, width/2, height);
        popMatrix();
      } else if (secondCount == 2) {

        pushMatrix();
        translate(0, 0, z);
        image(two_a, 0, 0, width/2, height);
        popMatrix();

        pushMatrix();
        translate(width/2, 0, z);
        image(two_b, 0, 0, width/2, height);
        popMatrix();
      } else if (secondCount == 3) {

        pushMatrix();
        translate(0, 0, z);
        image(three_a, 0, 0, width/2, height);
        popMatrix();

        pushMatrix();
        translate(width/2, 0, z);
        image(three_b, 0, 0, width/2, height);
        popMatrix();
      } else {
        currentTimeInState = 0;
        this.state = 1;
        newGame = true;
        page = 0;
        startScreen.pause();
        startScreen.rewind();
      }
      if (currentTimeInState >= timeToStayInState) {
        secondCount += 1;
        currentTimeInState = 0;
      }
    }

    if (page == 0) {
      if (this.toFlipRightToLeft) {
        flipImage1ATo2B();
      }

      if (this.toFlipLeftToRight) {
        flipImage1BTo4A();
      }
    } else if (page == 1) {

      if (this.toFlipRightToLeft) {
        flipImage2ATo3B();
      }

      if (this.toFlipLeftToRight) {
        flipImage2BTo1A();
      }
    } else if (page == 2) {

      if (this.toFlipRightToLeft) {
        println("UIUIUIIUUI");
        flipImage3ATo4B();
      }
      if (this.toFlipLeftToRight) {
        flipImage3BTo2A();
      }
    } else if (page == 3) {



      currentTimeInState += 1;

      println("SECONDS: " + secondCount);

      if (secondCount == 1) {
        //image 4A, the image that replaces 3A once page completely turns
        pushMatrix();
        translate(0, 0, z);
        image(one_a, 0, 0, width/2, height);
        popMatrix();

        pushMatrix();
        translate(width/2, 0, z);
        image(one_b, 0, 0, width/2, height);
        popMatrix();
      } else if (secondCount == 2) {

        pushMatrix();
        translate(0, 0, z);
        image(two_a, 0, 0, width/2, height);
        popMatrix();

        pushMatrix();
        translate(width/2, 0, z);
        image(two_b, 0, 0, width/2, height);
        popMatrix();
      } else if (secondCount == 3) {

        pushMatrix();
        translate(0, 0, z);
        image(three_a, 0, 0, width/2, height);
        popMatrix();

        pushMatrix();
        translate(width/2, 0, z);
        image(three_b, 0, 0, width/2, height);
        popMatrix();
      } else {
        currentTimeInState = 0;
        this.state = 1;
        page = 0;
        this.toContinue = true;
        newGame = true;

        startScreen.pause();
        startScreen.rewind();
      }
      if (currentTimeInState >= timeToStayInState) {
        secondCount += 1;
        currentTimeInState = 0;
      }
    }

    println("PAGE!!! " + page);
    println("Direction: " + directionTurned);
  }

  if (state == 1)        /* In Game */
  {
    // If this is a new game initialize everything
    if (newGame)
    {
      lives = numLives;
      level = 1;
      gameTimer = 0;
      bgCount = 0;
      winGameTimer = 0;
      gameOver = false;
      isDead = false;
      lastBG = false;
      b = new Blob(startX, startY);
      bg2 = loadImage("bg10.png");
      bg1 = loadImage("bg11.png");
      bgCount = 2;
      bg2x = 0;
      bg1x = width;
      transition = false;
      inTransition = false;
      s = new ParticleSystemRight(new PVector(width,height+10));
      l= new ParticleSystemLeft(new PVector(0,height+10));

      startScreen.pause();
      startScreen.rewind();


      // Set next image loaded to be the transition image (only applies if bgPerLevel == 2)
      if (bgPerLevel == 2)
      {
        transition = true;
      }

      /* Construct an initial platform under the blob */
      float initY = height/2+20;          // Set the initial y value of the platform
      float initX = startX - pWidth/2; // Set the initial x value of the platform
      float finalX = initX + pWidth;      // Set the final x position of the platform being created
      p = new Platform(initX, initY);     // Construct the Platform object
      // Construct each line for the starting platform
      for (int i = 0; i < pWidth; i += scrollSpeed)
      {
        p.addLine(scrollSpeed, -1, true);
      }

      // Start the looping game song
      inGame.rewind();
      inGame.loop();


      newGame = false;
    }

    // If the blob is dead
    if (isDead && !gameOver)
    {
      // get previousX and previousY from platform, so blob starts on the platform 
      float toStartX = p.prevX - p.numLines; 
      float toStartY = p.prevY - 40; 
      b = new Blob(toStartX, toStartY);   // startX, startY 
      isDead = false;
    }

    /* Display update and move the background images */
    displayMoveUpdateBG();

    /* Update blobX and blobY */
    float blobX = b.getX();
    float blobY = b.getY();


    /* Compute the hand y position so that it can reach all parts of the screen easily */
    if (!gameOver)
    {
      float handY = height - rightHandPos.getY() + 60;
      //float handX = map(rightHandPos.getX() + width/2, 100, 700, 0, width);
      float handX = rightHandPos.getX()*1.5 + width/2;
      

      if (rightHand) {                  // If a right hand is detected, use it's
        p.addLine(handX, handY, false);        // y position to make the line
      } else {                          // If no right hand is detected, input -1 so the new line
        p.addLine(scrollSpeed, -1, true);     // will have the same y val as the most recently added line
      }
    } else
    {
      gameOverAnimation();
    }

    /* Remove the last line in the platform */
    p.removeLastLine();

    /* Update the position of the platform */
    p.move(-scrollSpeed, 0);

    /* Adjust blob movement */
    blobMovement(blobX, blobY);

    /* Step through the physics of the world and draw it on the screen */
    world.step();
    world.draw();

    /* Translate the canvas foward slightly so the images will appear in front of everything else */
    pushMatrix();
    translate(0, 0, 1);

    /* Display the lives */
    displayLives();

    popMatrix();

    /* Draw the blob's features if it's not dead */
    if (!isDead)
    {
      drawBlobFeatures(blobX, blobY);
    }

    /* Check for death */
    checkForDeath(blobX, blobY);


    
    if(frameCount % 170 == 0  && level==1  && !inTransition && !isDead && !gameOver){
      firstLevelObstacle(); 
    }
    else if(frameCount % 130 == 0 && level==2 && !inTransition && !isDead  && !gameOver){
      secondLevelObstacle(); 
    }
    else if(frameCount % 120 == 0 && level == 3 && !inTransition && !isDead  &&!gameOver){
      thirdLevelObstacle(); 
    }

    if(!gameOver) {
    updateObstacle(); 
    }
    else{
     clearObstacle();
    }
    

    /* Increment game timer */
    gameTimer++;
  } else if ( state == 2 )        /* Win Screen */
  {

    // clear the obstacles 
  


    if (winGameTimer == 0)
    {
      b.addForce(1000, -1000);
      // Remove all objects except the blob
      p.removeAllLines();
      clearObstacle(); 
    }
    if (winGameTimer < int(winGameTime/5))
    {
      image(bg1, bg1x, 0);

      world.step();
      world.draw();      

      drawBlobFeatures(b.getX(), b.getY());    

      pushMatrix();
      translate(0, 0, .1);
      image(bg3, bg3x, 0);
      popMatrix();
    } else if (winGameTimer < winGameTime)
    {
      if (winGameTimer == int(winGameTime/5))
      {
        world.remove(b.getBlob());
        b = new Blob(width/2, height/2);
        bed = new FBox(width, 20);
        bed.setPosition(width/2, 4*height/5);
        bed.setStatic(true);
        bed.setFill(0, 0);
        bed.setRestitution(1);
        bed.setStroke(0, 0);
        world.add(bed);

        // Manage sounds
        inGame.pause();
        inGame.rewind();
        winGame.rewind();
        winGame.play();
      }

      image(win_screen, 0, 0);

      world.step();
      world.draw();
      
      PVector gravity = new PVector(0,0.06);
      s.addParticle();
      s.applyForce(gravity);
      s.run();
      
      l.addParticle();
      l.applyForce(gravity);
      l.run();
      

      drawBlobFeatures(b.getX(), b.getY());
    } else
    {
      winGame.pause();
      winGame.rewind();
      state = 0;
      startScreenStart = true;
    }

    /* Increment timer */
    winGameTimer++;
  }
}

/*
 * Displays, moves, and updates the background images. Moving them
 * across the screen at half the scrollSpeed to give a parallax 
 * scrolling effect. Updating them at each level.
 */
void displayMoveUpdateBG()
{
  /* Display the background images */
  imageMode(CORNER);
  image(bg1, bg1x, 0);
  image(bg2, bg2x, 0);
  if (lastBG)
  {
    translate(0, 0, 0.1);
    image(bg3, bg3x, 0);
    translate(0, 0, -0.1);
  }    

  /* Move the images */
  if (!end && !gameOver)              // Only move the images if we haven't reached the end
  {
    bg1x -= scrollSpeed/2;
    bg2x -= scrollSpeed/2;

    // Update bg3 as well if it has been loaded
    if (lastBG)
      bg3x -= scrollSpeed/2;
  }

  /* Update the images */
  if (bgCount < bgPerLevel*3)
  {
    if (bg1x <= -width)
    {
      bg1 = loadImage("bg" + level + "1.png");
      bg1x = width;
      bgCount++;

      /* Update transition variable */
      if (bgCount%bgPerLevel == 0)
      {
        inTransition = false;
        transition = true;
      } else if (bgCount%bgPerLevel == 2)
      {
        transition = false;
        inTransition = false;
      }
    } else if (bg2x <= -width)
    {
      if (transition)
      {
        level++;
        bg2 = loadImage("bg" + level + "0.png");
        inTransition = true;
      } else 
        bg2 = loadImage("bg" + level + "2.png");
      bg2x = width;
      bgCount++;
    }
  } else /* We reached the last two backgrounds of the game */
  {
    if (bg2x <= -width)
    {
      if (!lastBG)
      {
        bg2 = loadImage("bg32.png");
        bg2x = width;
        bgCount++;
      } else
      {
        end = true;
        state = 2;
        winGameTimer = 0;
      }
    } else if (bg1x <= -width)
    {
      bg1 = loadImage("bg401.png");
      bg1x = width;
      bg3 = loadImage("bg402.png");
      bg3x = bg1x + bg1.width - bg3.width;
      bgCount++;
      lastBG = true;
    }
  }
}
int blink = 0;
boolean isBlink = false;
/*
 * Draws the blob's features
 */
void drawBlobFeatures(float blobX, float blobY)
{
  imageMode(CORNER);
  
  if (frameCount%20 == 0)
  {
    if ((int)random(33) == 0)
    {
      isBlink = true;
    }
  }
  
  if (isBlink)
  {
    if (blink < 2)
    {
      image(eyes2, blobX-10, blobY-20);
      blink++; 
    } else if (blink < 5)
    {
      image(eyes3, blobX-10, blobY-20);    
      blink++; 
    } else 
    {
      image(eyes3, blobX-10, blobY-20);    
      blink = 0;
      isBlink = false;
    }
  } else
  {
    image(eyes, blobX-10, blobY-20);
    blink = 0;
  }
}
/*
 * Check if the blob is off screen and if so, decrement lives by 1
 * Also checks if the game is over (blob lost all its lives)
 */
void checkForDeath(float blobX, float blobY) 
{
  if (blobX > width || blobX < 0 || blobY > height || blobY < 0)
  {
    lives--;
    if (lives < 1) 
    {
      gameOver = true;                // The game is over if the blob has no more lives
      gameOverTimer = 0;              // Start the game over timer
      inGame.pause();
      inGame.rewind();
    }

    isDead = true;                  // Set isDead to true
    world.remove(b.getBlob());      // remove the FBlob from the world
  }
}

/*
 * Draws a circle in the upper left corner of the screen for each life the blob has left
 */
public void displayLives() {
  for (int i = 0; i < lives; i++) 
  {
    // Draw an circle in the upper left corner for each life
    fill(155, 89, 182);
    ellipse(20 + i*15, 10, 10, 10);
  }
}

/*
 * Examines information given by the leap and updates the following variables:
 *   - boolean   leftHand
 *   - boolean   rightHand
 *   - int       extRFingers
 *   - Vector    rightHandPos
 *   - float     roll
 */
void detectHands(final Controller controller) {
  /* Default values */
  leftHand = false;
  rightHand = false;
  extRFingers = 0;
  rightHandPos = new Vector(width/2, height/3, 0);
  roll = 0;

  if (controller.isConnected()) {
    Frame frame = controller.frame();
    if (!frame.hands().isEmpty()) {
      for (Hand hand : frame.hands ()) {
        if (hand.isLeft()) {
          leftHand = true;
        } else if (hand.isRight())
        {
          rightHand = true;
          extRFingers = hand.pointables().extended().count();
          rightHandPos = hand.stabilizedPalmPosition();
          roll = hand.palmNormal().roll();
        }
      }
    }
  }
}  

/*
 * Controls the blobs movement
 */
void blobMovement(float blobX, float blobY)
{
  /* Accelerate depending on roll angle of the hand */
  if (abs(roll) > rollThresh)  // Only accelerate if the roll angle is past a certain threshold
  {
    b.accelerate(roll);
  }

  /*
  // Add a force to keep the blob centered on the platform
   if (blobX > startX + 20) {
   // add force so it doesn't fall
   b.addForce(-8, 0);
   }
   if (blobX <  startX - 20) {
   // add force so it doesn't fall
   b.addForce(8, 0);
   }*/
}

// leap required  
void onFrame(final Controller controller)
{
  detectHands(controller);
  if (toContinue) {
    //if user swipes left 
    if (this.toFlipRightToLeft = detectSwipeRightToLeft(controller)) {

      //set flag swipe to true, go to draw and call the swipe function
      this.toFlipRightToLeft = true;
      this.directionTurned = 1;

      println("R TO L");

      //set toContinue to false so detect swipe won't continually return false
      //otherwise page will stop turning
      toContinue = false;
    } 
    if (this.toFlipLeftToRight = detectSwipeLeftToRight(controller)) {
      this.toFlipLeftToRight = true;
      this.directionTurned = 0;
      println("L TO R");
      toContinue = false;
    }
  }
}


void gameOverAnimation()
{
  // Draw the fading black screen
  fill(0, Math.min(255, gameOverTimer));
  rect(0, 0, width, height);

  if (gameOverTimer == 0)
  {
    p.addLine(width/4, height/2, false);
  }
  if (gameOverTimer < 2*gameOverTime/3)
  {
    p.addLine(scrollSpeed, heartBeat(gameOverTimer, height/2, 2*gameOverTime/9), true);
  } else if (gameOverTimer < gameOverTime)
  {
    p.addLine(scrollSpeed, height/2, true);
    flatline.play();
  } else
  {
    flatline.pause();
    flatline.rewind();
    inGame.pause();
    world.clear();
    initializeAdiVariables();
    state = 0;
    startScreenStart = true;
  }
  gameOverTimer++;
}

float heartBeat(float x, float y, int rate)
{
  if (x%rate < rate - 60/scrollSpeed)
    return y;
  else if (x%rate < rate - 44/scrollSpeed)
  {
    if (isBeep)
    {
      beep.rewind();
      beep.play();
      isBeep = false;
    }
    return 0;
  }
  else if (x%rate < rate - 20/scrollSpeed)
    return height;
  else if (x%rate < rate - (8/scrollSpeed))
  {
    isBeep = true;
    return 0;
  } else if (x%rate < rate - 1)
    return height;
  else
    return y;
}




public void firstLevelObstacle() {
  // distribute them 
  Obstacles newest = null;
  float previousSize = 0;
  float num = random(1); 
  
  if (num < 0.35) {   // 0.35
  
    int size = (int)random(120,260);
    Obstacles st= new Stalagtite(size);   //previousSize
    ob.add(st);
  }
  //35%
  else if (num<0.70) {  // 0.70
    int size = (int)random(190,height-150);
    Obstacles sm = new Stalagmite(size);
    ob.add(sm);
  }

  //10 %
  else if (num < 0.80) {  // 0.80
    Obstacles fs = new FallingStalagtite(100);
    ob.add(fs);
  }

  // 20% 
  else {
    // have the difference between them be 50 
    // don't actually change previous size 
    int size  = (int)random(230,height-150);
    int size2 = size+70; 
    Obstacles st = new Stalagtite(size);
    Obstacles sm= new Stalagmite(size2);
    ob.add(st);
    ob.add(sm);
  }
}


public void secondLevelObstacle() {

  float distribution = random(1); 
  if (distribution < 0.40) {
    Obstacles buzz = new Bee(); 
    ob.add(buzz); 
    Obstacles buzz2 = new Bee(); 
    ob.add(buzz2);
    Obstacles buzz3 = new Bee();
    ob.add(buzz3);
  } else if (distribution < 0.55) {
    Obstacles ball = new Ball(); 
    ob.add(ball);
  } 
  
  else {
  }
}


public void thirdLevelObstacle() {
  float distribute = random(1); 

  if (distribute < .15) {
    Obstacles lamp = new Lamp(); 
    ob.add(lamp);
    
  } else if (distribute < 0) {
    Scalpel s = new Scalpel();
    ob.add(s);
  } else if(distribute < 0.7){
    Anchors a = new Anchors();
    ob.add(a); 
     
  }
}

public void updateObstacle() {
  
  for (int i = 0; i < ob.size(); i++)
  {
    Obstacles o = ob.get(i);
    o.update();
    o.display();
    
    if(o.hit(b.getX(), b.getY())){
       b.decelerate(); 
    }

    if (o.location.x < -600) {
      ob.remove(o); 
      o.removeWorld();
    }
  }
}


public void clearObstacle(){
  
  while(!ob.isEmpty())
  {
    ob.get(0).removeWorld();
    ob.remove(0);
  }
//  for(int i = 0; i< ob.size(); i++){
//      Obstacles o = ob.get(i); 
//      o.removeWorld();
//      ob.remove(o); 
//  } 
}




/////////////////////////////ADI//////////////
///////////////////////////////////////////////
///////////////////////////////////////////////


//flip animation from 1A to 2B
void flipImage1ATo2B() {

  println("1A to 2B called");
  //keep turning the page until it's on top of the page1A
  //once page turns, upload image 2B on the right side
  if (degrees(angle) >= -180) {
    this.current1A = cut1A;
    angle-=0.03;
  }

  if (degrees(angle) <=0 && degrees(angle) >= -30) {
    if ( z > -100) {
      z -= 3;
    }
  }

  //once hit 90 degrees, switch to backside of page 1B, which is page 2A
  if (degrees(angle) < -90) {
    current1B = cut2Atemp;
  }


  if (degrees(angle) < -120) {
    if ( z <= 0) {    
      z += 2;
    }
  }

  //switch state to page 1 once done flipping
  if (degrees(angle) < -180) {
    this.page = 1;
    //set toConinue flag to true after 180 degrees swipe is done
    this.toContinue = true;
    this.angle = 0;
  }
  println(degrees(angle));
}

void flipImage2ATo3B() {
  println("2A to 3B called");
  //keep turning the page until it's on top of the page1A
  //once page turns, upload image 2B on the right side
  if (degrees(angle) >= -180) {
    angle-=0.03;
  }

  if (degrees(angle) <=0 && degrees(angle) >= -30) {
    if ( z > -100) {
      z -= 3;
    }
  }

  //once hit 90 degrees, switch to backside of page 1B, which is page 2A
  if (degrees(angle) < -90) {
    current2B = cut3Atemp;
  }

  if (degrees(angle) < -120) {
    if ( z <= 0) {    
      z += 2;
    }
  }

  //switch graphics to page 3A 
  if (degrees(angle) < -180) {
    this.page = 2;
    this.toContinue = true;
    this.angle = 0;
    this.current3B = cut3B;
  }
}

void flipImage3ATo4B() {
  println("3A to Game Called");
  //keep turning the page until it's on top of the page1A
  //once page turns, upload image 2B on the right side
  if (degrees(angle) >= -180) {
    angle-=0.03;
    current1A = cut1A;
  }

  if (degrees(angle) <=0 && degrees(angle) >= -30) {
    if ( z > -100) {
      z -= 3;
    }
  }

  //once hit 90 degrees, switch to backside of page 1B, which is page 2A
  if (degrees(angle) < -90) {
    current3B = cut4Atemp;
  }

  if (degrees(angle) < -120) {
    if ( z <= 0) {    
      z += 2;
    }
  }

  //switch graphics to page 2A 
  if (degrees(angle) < -180) {
    this.page = 3;
    this.toContinue = true;
    this.angle = 0;
    this.current1B = cut1B;
    this.current1A = cut1A;
  }
}


void flipImage1BTo4A() {
  println("1B to 4A called");
  println("DEEEEEGREE " + degrees(angle2));
  if (degrees(angle2) >= 175) {
    angle2 += 0.03;
    current1A = cut1Atemp;
  }

  if (degrees(angle2) >= 180 && degrees(angle2) <= 210) {
    println("Z is: " + z);
    if ( z > -100) {
      z -= 3;
    }
  }


  if (degrees(angle2) > 270) {
    current1A = cut4B;
  }

  if (degrees(angle2) > 300) {
    if ( z <= 0) {    
      z += 2;
    }
  }


  //switch graphics to page 1A
  if (degrees(angle2) >= 360) {
    this.page = -1;
    this.toContinue = true;
    this.angle2 = PI;
    this.current1B = cut1B;
    this.current1A = cut1Atemp;
  }
}



void flipImage2BTo1A() {
  println("2B to 1A called");
  println("DEEEEEGREE " + degrees(angle2));
  if (degrees(angle2) >= 175) {
    angle2 += 0.03;
    current2A = cut2Atemp;
  }

  if (degrees(angle2) >= 180 && degrees(angle2) <= 210) {
    println("Z is: " + z);
    if ( z > -100) {
      z -= 3;
    }
  }


  if (degrees(angle2) > 270) {
    current2A = cut1B;
  }

  if (degrees(angle2) > 300) {
    if ( z <= 0) {    
      z += 2;
    }
  }


  //switch graphics to page 1A
  if (degrees(angle2) >= 360) {
    this.page = 0;
    this.toContinue = true;
    this.angle2 = PI;
    this.current1B = cut1B;
    this.current1A = cut1Atemp;
  }
}


void flipImage3BTo2A() {
  println("3B to 2A called");
  println("DEEEEEGREE " + degrees(angle2));
  if (degrees(angle2) >= 175) {
    angle2 += 0.03;
    current3A = cut3Atemp;
  }


  if (degrees(angle2) >= 180 && degrees(angle2) <= 210) {
    println("Z is: " + z);
    if ( z > -100) {
      z -= 3;
    }
  }

  if (degrees(angle2) > 270) {
    current3A = cut2B;
  }

  if (degrees(angle2) > 300) {
    if ( z <= 0) {    
      z += 2;
    }
  }


  //switch graphics to page 1A
  if (degrees(angle2) >= 360) {
    this.page = 1;
    this.toContinue = true;
    this.angle2 = PI;
    this.current2B = cut2B;
    this.current2A = cut2Atemp;
  }
}


void onInit(final Controller controller)
{
  controller.enableGesture(Gesture.Type.TYPE_CIRCLE);
  controller.enableGesture(Gesture.Type.TYPE_KEY_TAP);
  controller.enableGesture(Gesture.Type.TYPE_SCREEN_TAP);
  controller.enableGesture(Gesture.Type.TYPE_SWIPE);
  // enable background policy
  controller.setPolicyFlags(Controller.PolicyFlag.POLICY_BACKGROUND_FRAMES);
}


int detectSwipe(final Controller controller) {
  Vector swipeDirection;
  Frame frame = controller.frame();
  for (Gesture gesture : frame.gestures ())
  {
    swipe = new SwipeGesture(gesture);
    if ("TYPE_SWIPE".equals(gesture.type().toString()) && "STATE_START".equals(gesture.state().toString())) {
      if (swipe.direction().getX() < 0) {
        swipeDirection = swipe.direction();
        float x = swipe.direction().getX();
        println("swipe direction x (R to L): "  + x);
        //System.exit(0);
        println(swipeDirection);
        println("swipe RIGHT to LEFT");
        return 0;
      } 

      if (swipe.direction().getX() > 0) {
        swipeDirection = swipe.direction();
        float x = swipe.direction().getX();
        println("swipe direction x (L to R): "  + x);
        println(swipeDirection);
        println("swipe LEFT to RIGHT");
        return 1;
      }
    }
  }
  return 2;
}

boolean detectSwipeRightToLeft(final Controller controller) {
  Vector swipeDirection;
  Frame frame = controller.frame();
  for (Gesture gesture : frame.gestures ())
  {
    swipe = new SwipeGesture(gesture);
    if ("TYPE_SWIPE".equals(gesture.type().toString()) && "STATE_START".equals(gesture.state().toString())) {
      if (swipe.direction().getX() < 0) {
        swipeDirection = swipe.direction();
        float x = swipe.direction().getX();
        println("swipe direction x (R to L): "  + x);
        //System.exit(0);
        println(swipeDirection);
        println("swipe RIGHT to LEFT");
        return true;
      }
    }
  }
  return false;
}

boolean detectSwipeLeftToRight(final Controller controller) {

  Vector swipeDirection;
  Frame frame = controller.frame();
  for (Gesture gesture : frame.gestures ())
  {
    swipe = new SwipeGesture(gesture);
    if ("TYPE_SWIPE".equals(gesture.type().toString()) && "STATE_START".equals(gesture.state().toString())) {
      if (swipe.direction().getX() > 0) {
        swipeDirection = swipe.direction();
        float x = swipe.direction().getX();
        println("swipe direction x (L to R): "  + x);
        println(swipeDirection);
        println("swipe LEFT to RIGHT");
        return true;
      }
    }
  }
  return false;
}

void initializeAdiVariables() {

  this.toContinue = true;
  this.page = 0;
  current1A = cut1A;
  current1B = cut1B;
  current2A = cut2A;
  current2B = cut2B;
  current3A = cut3A;
  current3B = cut3B;
  this.angle = 0;
  this.angle2 = PI;
  this.directionTurned = 1;
  this.z = 0;
  this.secondCount = 1;
  this.currentTimeInState = 0;
  this.timeToStayInState = 100;
}  

