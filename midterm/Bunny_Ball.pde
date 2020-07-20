/*
 This is a game where you're playing dodgeball with bunnies! Except you're the only one throwing balls
 and if you touch the bunnies you instantly lose (at least in this version)! If you manage to hit all the bunnies 
 successfully, you'll advance to the next stage and the difficulty will increase. Try to survive the longest and 
 get the highest score!
 
 IF YOU'RE PLAYING THIS ON YOUR OWN COMPUTER, READ THIS:
 - Because this game loads in files from the menu, sprite, and sounds folders that were uploaded to github, you'll need to
 update the paths for these files in the code. All of the paths that you'll need to update is in the entityLoad.pde file.
 
 Inspiration:
 - I play an iOS/Android game called "Archero" when I'm bored and they're currently having their 1 year anniversary.
 I thought that it might be fun to try and make a "bullet-hell" game similar to Archero. Although the enemies shooting
 bullets might be a bit much for me to do for the first version.
 
 Warning:
 The game takes a little while to load (~5-10 seconds or so) due to how Processing loads sounds from your computer. Please
 give it some time to boot to the menu screen! :)
 */

import processing.sound.*;

// Variables -------------------------------------------------------------------------------------//

// player variables
float playerX = 640;
float playerY = 620;
float playerWidth = 45;
float playerHeight = 55;
float playerHealth = 0;
float playerDamageBuffer = 60;
float playerSpd;
int currSprite; // decides next sprite in sprite array to display
PImage[] playerSprite = new PImage[2]; // sprite array for animated characters

// enemy variables
float enemyWidth = 45;
float enemyHeight = 70;
int enemyNum;
int enemyHit;
float enemySpd;
// float enemyBallSpd = 5; // shoot ball at player direction, without ballDir variable
PImage[] bunnySprite = new PImage[4];
PImage[] throwerBunnySprite = new PImage[4];
Bunny[] bunnies;

// ball variables
float ballWidth = 50;
float ballHeight = 50;
float ballSpd = 10; // ballSpd default 10
String ballDir;
int ballStock = 5;
int ballReloadTimer = 60;
int ballRefreshTimer = 120;
boolean spacePressed = false;
PImage ballStockSprite;
ArrayList<Ball> playerBalls = new ArrayList<Ball>();
ArrayList<Ball> enemyBalls = new ArrayList<Ball>();
PImage[] playerBallSprite = new PImage[4];
PImage[] enemyBallSprite = new PImage[4];

// game variables
int score = 0;
int highScore = 0;
int collisionBuffer = 25; // pixel buffer before you touch a bunny
int buttonWidth = 240;
int buttonHeight = 100;
boolean gamePaused = false;

// game assets
PFont font;
PImage background;
PImage titleImg;
PImage playButton;
SoundFile gameMusic;
SoundFile menuMusic;
SoundFile playerHitSound;
SoundFile enemyHitSound;
SoundFile ballThrowSound;
SoundFile ballReloadSound;
boolean gameMusicPlaying = false;
boolean menuMusicPlaying = false;
boolean playButtonHit = false;
int playerHealthSpriteNum = 0;
PImage[] playerHealthSprite = new PImage[4];
PImage[] enemyHealthSprite = new PImage[2];

// movement control variables
boolean upPressed = false;
boolean downPressed = false;
boolean leftPressed = false;
boolean rightPressed = false;

// Setup and Draw functions ----------------------------------------------------------------------//

void setup() {

  // Set game resolution
  size(1280, 720);

  // Load background, sprites, fonts, and music from file path on computer
  loadGameFiles();
}

void draw() {

  // If the player hits the play button, start the game
  if (playButtonHit == true) {

    // continue game as long as player health is greater than 0
    if (playerHealth > 0) {

      // if all the enemies are hit, go to the next stage
      if (enemyHit == enemyNum) {
        nextStage();
      }

      // clear screen (to allow animation)
      image(background, 0, 0);

      // play BGM
      if (gameMusicPlaying == false) {
        menuMusic.stop();
        menuMusicPlaying = false;
        gameMusic.loop(0.9, 0.03);
        gameMusicPlaying = true;
      }

      // update entities (ball, player, enemies)
      updatePlayer();
      updateBalls();
      updateBunnies();

      // display GUI
      displayScore("topLeft");
      displayHealth();
      displayBallStock();

      // check for collisions between player, ball, and enemies
      checkCollision();

      // If player health is 0, then we end the game
    } else if (playerHealth <= 0) {
      endGame();
    }
  } else if (playButtonHit == false) {
    displayMenu();
  }
}
