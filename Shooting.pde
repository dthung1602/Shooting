//----------------------------- constant-----------------------------------//
float GROUND_HEIGHT  = 50;
float GRAVITY        = 0.5;
int DEFAULT_HEALTH   = 100;
int DEFAULT_MONEY    = 100;
int MAX_ROUND        = 16;
int ENEMY_LIST_SIZE  = 500;
int BULLET_LIST_SIZE = 1000;
int EFFECT_LIST_SIZE = 500;
int STUFF_LIST_SIZE  = 100;
float DIFICULTLY     = 1.2;
int MIN_ENEMY_DELAY  = 10;
int MAX_ENEMY_DELAY  = 30;

color WHITE = color(100, 100, 100, 100);   
color RED   = color(255, 0, 0, 100);
color BLUE  = color(0, 150, 250, 100);
color CLEAR_BLUE  = color(50, 180, 250, 70);

//------------------------------ variables---------------------------------//
Screen screen;
int currentRound;    
int totalEnemyInRound;                     // how many enemy will be created in this round 
int killCount;                             // how many enemy kiled
int enemyCount;                            // how many enemy in current round
int bulletCount;                           // how many weapon in current round 
int effectCount;                           // number of effect in current round
int stuffCount;                            // number of stuff in current round

boolean starting = false;                  // true: player start a round;    false: round if finished
boolean pausing = true;                    // true: menu;                    false: in game

int oldFrame        = 0;                   // save frame since the last time an enemy was created
int newEnemyDelay = 25;                    // delay time between creation of two enemies; will receive random values in game

String message;                            // save a message to display on screen when playing 
int messageTime = 0;                       // how long the message will stay on screenint size;


//--------------------------constant objects--------------------------------//
Shooter shooter            = new Shooter();
Enemy enemyList []         = new Enemy [ENEMY_LIST_SIZE];
Bullet bulletList []       = new Bullet [BULLET_LIST_SIZE];
VisualEffect effectList [] = new VisualEffect [EFFECT_LIST_SIZE];
Stuff stuffList []         = new Stuff [STUFF_LIST_SIZE];

// screens
Screen menuScreen;
PlayScreen playScreen;
Screen pauseScreen;
Screen winScreen;
Screen loseScreen;
Screen upgradeScreen;

// images of bullets
PImage stonePic;
PImage shurikenPic;
PImage arrowPic;
PImage bulletPic;
PImage icePic;
PImage firePic;
PImage bombPic;
PImage grenadePic;
PImage laserPic;
PImage nukePic;

// image of visual effects
PImage snowflakePic;
PImage explosionPic;

// fonts
PFont fontSmall;
PFont fontMedium;
PFont fontLarge;

// tmp
Bullet laserBullet = new Laser(0, 0, 0, 0);


//specialAction var
float size;                                // how much the weapon is enlarged
boolean saClear = false; 
float saMaxSpeed;
boolean saAntiGRAVITY = false;
boolean saGRAVITY = false;
int laserOn = 0;
int saFreeze = 0;
int saGiantBullet = 0;
int saFireBullet = 0;
int saFireWorkBullet = 0;
float saFastBullet = 1;
float minSize, midSize, maxSize;
int saBigBall = 0;
boolean hShoot = false;
int hshootRate = 150;
boolean vShoot = false;
int vshootRate = 150;



void setup () {
  //--------------basic--------------------------//
  size(800,520);
  frameRate(25);
  rectMode(CENTER);
  imageMode(CENTER);
  
  //-----------------load images----------------//
  // weapon images
  stonePic   = loadImage("./Pic/stone.png");
  shurikenPic= loadImage("./Pic/dart.png");
  bulletPic  = loadImage("./Pic/bullet.png");
  icePic     = loadImage("./Pic/ice.png");
  firePic    = loadImage("./Pic/fire.png");
  bombPic    = loadImage("./Pic/bomb.png");
  grenadePic = loadImage("./Pic/grenade.png");
  laserPic   = loadImage("./Pic/laser.gif");
  nukePic    = loadImage("./Pic/nuke.png");
  
  //-----------------------load fonts------------------------//
  fontSmall  = loadFont("./Font/font_small.vlw");
  fontMedium = loadFont("./Font/font_medium.vlw");
  fontLarge  = loadFont("./Font/font_large.vlw");

  //-----------------------create screens----------------------//
  PImage bg;
  Button buttonList [];
  
  playScreen = new PlayScreen();
  
  //----------------------show menu--------------------------//
  screen = playScreen;
  pausing = true;
  
  //--------------------------- tmp-----------------------------
  shooter.currentWeapon = new Hand();
  shooter.aim = true;
  totalEnemyInRound = 5;
  resetRound();
}

void draw () {
  screen.show();
}