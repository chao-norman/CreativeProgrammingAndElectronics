/*
   Main method which holds both setup() and draw(), as well as all the global variables
 and arduino communication functions.
 
 Sunset Cruise: This game is a relaxing late night drive experience with lofi hip hop beats playing on the radio.
 You can steer using the steering wheel attached to the rotary encoder module, cycle through songs on the radio
 using two buttons, and see what song is currently playing on the LCD screen.
 */

import processing.sound.*;
import processing.serial.*;

// Game Variables -----------------------------------------------------//

// BG: gradient
int Y_AXIS = 1;
int X_AXIS = 2;
color grad1 = color(146, 0, 117);
color grad2 = color(24, 24, 89);
color grad3 = color(47, 24, 151);
color grad4 = color(228, 68, 240);
color grad5 = color(17, 11, 61);
color grad6 = color(13, 2, 33);
color black = color(0, 0, 0);

// BG: stars
float[] xPos = new float[250];
float[] yPos = new float[250];
float[] xVel = new float[250];
float[] yVel = new float[250];
float[] s = new float[250];
int a = 0;
int b = 0;
int c = 100;
int p = 10;

// BG: road
int roadBuffer = 2;

// BG: sunset
int sunDisplace = 0;
int sunReverseCounter = 0; // reverse when counter hits 60
boolean sunReverseBoolean = false; // boolean to track whether reverse or not

// BG: title screen + play button + instructions
PImage titleLogo;
float titleDisplace = 0;
float titleReverseCounter = 0; // reverse when counter hits 30
boolean titleReverseBoolean = false; // boolean to track whether reverse or not
PImage playButton;
PFont font;

// Car
int carCurrSprite = 4; // left most = 0, middle = 4, right most = 8
int carX = 1920/2;
int carY = 1080/2 + 340;
int carBuffer = 2;
PImage[] carSprite = new PImage[9];

// game
int gameState = 0;
int speed = 0;
boolean musicPlaying = false;

// music/radio
int currSong = 0;
int prevSong = 0;
int radioBuffer = 20;
SoundFile[] radioMusic = new SoundFile[7];

// serial input/output
Serial port;
int[] inByte;
int rotaryEncoderCurr = 0;
int rotaryEncoderPrev = 0;
int backButton;
int forwardButton;
int backCheck;
int forwardCheck;

// Setup and Draw Functions ------------------------------------------ //

void setup() {

  // set game resolution
  size(1920, 1080, P2D);

  smooth();

  // load game files from file path on computer
  loadGameFiles(); 
  // load random configuration of stars
  loadStars();

  // list all available serial ports in output pane (connect arduino)
  //println(Serial.list());

  // open port that arduino board is connected to (in my case, port index 1)
  // opens port at same speed arduino is using (currently 9600bps)
  port = new Serial(this, Serial.list()[1], 9600);

  // don't generate serialEvent() unless you get a newline character
  port.bufferUntil('\n');
}


void draw() {

  // if gameState == 0: title screen
  if (gameState == 0) {
    titleScreen();

    // play first track on the radio when the game starts
    if (musicPlaying == false) {
      writeToArduino();
      radioMusic[currSong].loop(1, 0.05);
      musicPlaying = true;
    }

    // if gameState == 1: game in progress
  } else if (gameState == 1) {
    gameInProgress();

    // update buffers (to ensure smooth animations)
    carBuffer -= 1;
    radioBuffer -= 1;
    roadBuffer -= 1;

    // if user changed the song, update song and write to arduino to change LCD output
    if (currSong != prevSong) {
      writeToArduino();
      radioMusic[prevSong].stop();
      radioMusic[currSong].loop(1, 0.05);
      prevSong = currSong;
    }
  }
}

void serialEvent(Serial port) {
  // get ASCII string
  String inString = port.readStringUntil('\n');

  if (inString != null) {
    // trim off any whitespace
    inString = trim(inString);
    // convert to an int and set to inByte
    inByte = int(split(inString, ","));

    // rotary encoder processing
    rotaryEncoderCurr = inByte[0];
    if (rotaryEncoderCurr > rotaryEncoderPrev) {
      if (carCurrSprite < 8) {
        carCurrSprite += 1;
        carX += 150;
      }
    } else if (rotaryEncoderCurr < rotaryEncoderPrev) {
      if (carCurrSprite > 0) {
        carCurrSprite -= 1;
        carX -= 150;
      }
    }
    rotaryEncoderPrev = rotaryEncoderCurr;

    // radio button processing
    backCheck = inByte[1];
    forwardCheck = inByte[2];
    // check if either button is pressed
    if (backCheck == 1 && backButton == 0) {
      backButton = 1;
    }
    if (forwardCheck == 1 && forwardButton == 0) {
      forwardButton = 1;
    }
    // if button pressed and buffer is 0, then we update the song index
    if (radioBuffer == 0) {
      if (backButton == 1) {
        backButton = 0;
        if (currSong <= 0) {
          currSong = 6;
        } else {
          currSong -= 1;
        }
      } else if (forwardButton == 1) {
        forwardButton = 0;
        if (currSong >= 6) {
          currSong = 0;
        } else {
          currSong += 1;
        }
      }
      radioBuffer = 20;
    }
  }
}

// writes to arduino to display the correct LED color
void writeToArduino() {
  port.write(currSong);
}
