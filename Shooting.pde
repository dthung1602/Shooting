//----------------------------- constant-----------------------------------//
float GROUND_HEIGHT  = 50;
float GRAVITY        = 0.5;
int DEFAULT_HEALTH   = 10;
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
int objCount;                            // number of obj in current round

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
Obj objList []         = new Obj [STUFF_LIST_SIZE];

// screens
PlayScreen playScreen;
Screen menuScreen;
Screen pauseScreen;
Screen winScreen;
Screen loseScreen;
Screen upgradeScreen;
Screen highScoreScreen;
Screen choosingRoundScreen;

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
  
  //effect images
  explosionPic = loadImage("./Pic/explosion.png");
  snowflakePic = loadImage("./Pic/dart.png");
  
  //-----------------------load fonts------------------------//
  fontSmall  = loadFont("./Font/font_small.vlw");
  fontMedium = loadFont("./Font/font_medium.vlw");
  fontLarge  = loadFont("./Font/font_large.vlw");

  //-----------------------create screens----------------------//
  PImage bg;
  Button buttonList [];
  
  //---------create play screen-----------
  bg = loadImage("./Pic/map0.jpg");
  buttonList = new Button [] {
    new NewWallButton(0,0,200,200)
  };
  playScreen = new PlayScreen(bg, buttonList);
  /*

Screen upgradeScreen;
Screen choosingRoundScreen;*/
  //---------create menu screen-----------
  bg = loadImage("./Pic/menu.jpg");
  buttonList = new Button[] { 
    new QuitButton(730, 10, 790, 70),
    new HighScoreButton(555, 440, 785, 480),
  };
  menuScreen = new Screen(bg, buttonList);
  
  //---------create pause screen-----------
  bg = loadImage("./Pic/menu.jpg");
  buttonList = new Button[] {
    new ResumeButton(15, 440, 250, 480),
    new MenuButton(15, 440, 250, 480),
  };
  menuScreen = new Screen(bg, buttonList);
  
  //---------create win screen-------------
  bg = loadImage("./Pic/win.jpg");
  buttonList = new Button[] {
    new MenuButton(415, 310, 495, 370)
  };
  winScreen = new Screen(bg, buttonList);
  
  //-----------create lose screen-------------
  bg = loadImage("./Pic/lose.jpg");
  buttonList = new Button[] {
    new MenuButton(580, 215, 655, 280),
  };
  loseScreen = new Screen(bg, buttonList);
  
  //-----------create high score screen-------------  
  bg = loadImage("./Pic/highscore.jpg");
  buttonList = new Button[] {
    new MenuButton(750, 475, 790, 512)
  };
  highScoreScreen = new Screen(bg, buttonList);
  
  //---------create upgrade screen-----------
  bg = loadImage("./Pic/menu.jpg");
  buttonList = new Button[] {
    // .>>>> lot of buttons
  };
  menuScreen = new Screen(bg, buttonList);
  
  //-----------create choosing round screen-------------  
  bg = loadImage("./Pic/highscore.jpg");
  buttonList = new Button[] {
    new ChooseRoundButton(0,0,200,200),
  };
  highScoreScreen = new Screen(bg, buttonList);
  
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