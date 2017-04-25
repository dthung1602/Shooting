//----------------------------- constant-----------------------------------//
float SELL_PERCENT   = 0.8;
float GROUND_HEIGHT  = 50;
float GRAVITY        = 0.5;
int DEFAULT_HEALTH   = 10;
int DEFAULT_MONEY    = 100;
int MAX_ROUND        = 50;
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
color BOLD_RED    = color(255, 0, 0);

//------------------------------ variables---------------------------------//
Screen screen;
int currentRound;    
int totalEnemyInRound;                     // how many enemy will be created in this round 
int killCount;                             // how many enemy kiled
int enemyCount;                            // how many enemy in current round
int bulletCount;                           // how many weapon in current round 
int effectCount;                           // number of effect in current round
int objCount;                              // number of obj in current round

int oldFrame        = 0;                   // save frame since the last time an enemy was created
int newEnemyDelay = 25;                    // delay time between creation of two enemies; will receive random values in game


//--------------------------constant objects--------------------------------//
Player player;
Shooter shooter;

Enemy enemyList []         = new Enemy [ENEMY_LIST_SIZE];
Bullet bulletList []       = new Bullet [BULLET_LIST_SIZE];
VisualEffect effectList [] = new VisualEffect [EFFECT_LIST_SIZE];
Obj objList []             = new Obj [STUFF_LIST_SIZE];

// screens
Screen menuScreen;
HighScoreScreen highScoreScreen;
Screen choosingRoundScreen;
Screen settingScreen;
ChangePlayerScreen changePlayerScreen;
PlayScreen playScreen;
Screen upgradeScreen;
Screen pauseScreen;
Screen winScreen;
Screen loseScreen;

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

// image of weapon
PImage handPic;
PImage bowPic;
PImage laserGunPic;
PImage freezeGunPic;

// image of enemy
PImage basicEnemyPic;

// fonts
PFont fontSmall;
PFont fontMedium;
PFont fontLarge;

// sound effects
import ddf.minim.*;
Minim minim;
AudioPlayer bgSound;
AudioPlayer dartSound;
AudioPlayer iceSound;
AudioPlayer bombSound;
AudioPlayer laserSound;

boolean musicEnable = true;
boolean soundEnable = true;


// others



void setup () {
  //--------------basic--------------------------//
  size(800,520);
  frameRate(20);
  rectMode(CORNERS);
  imageMode(CENTER);
  
  //-----------------load images----------------//
  // weapon images
  stonePic   = loadImage("./Pic/stone.png");
  shurikenPic= loadImage("./Pic/dart.png");
  arrowPic   = loadImage("./Pic/arrow.png");
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
  
  //weapon image
  handPic     = loadImage("./Pic/laser_gun.png");
  bowPic      = loadImage("./Pic/bow.png");
  laserGunPic = loadImage("./Pic/laser_gun.png");
  freezeGunPic= loadImage("./Pic/laser_gun.png");
  
  // enemy image
  basicEnemyPic = loadImage("./Pic/dart_monkey.png");
  
  // -----------------load important objects-------------------//
  player  = new Player();
  shooter = new Shooter();
  
  //-----------------------load fonts------------------------//
  fontSmall  = loadFont("./Font/font_small.vlw");
  fontMedium = loadFont("./Font/font_medium.vlw");
  fontLarge  = loadFont("./Font/font_large.vlw");

  //-----------------------create screens----------------------//
  PImage bg;
  Button buttonList [];

  // menu screen
  bg = loadImage("./Pic/menu.jpg");
  buttonList = new Button[] {
    new ResumeButton(15, 440, 250, 480),
    //  new ContinueButton(15, 440, 250, 480),  tmp for above button 
    new UpGradeButton(15, 440, 250, 480),
    new ChoosingRoundMenuButton(280, 440, 515, 480),
    new ChangePlayerButton(730, 10, 790, 70),
    new HighScoreButton(555, 440, 785, 480),
    new SettingButton(730, 10, 790, 70),
    new QuitButton(730, 10, 790, 70),
  };
  menuScreen = new Screen(bg, buttonList);

  // high score screen
  highScoreScreen = new HighScoreScreen();
  
  
  // create choosing round screen
  bg = loadImage("./Pic/highscore.jpg");
  buttonList = new Button[] {
    new MenuButton(580, 215, 655, 280),
  };
  choosingRoundScreen = new Screen(bg, buttonList);
  choosingRoundScreen.infoList = new Info [] {
    new Info("", 500, 400, color(200,255,0), fontSmall),
  };
  
  // create setting screen  
  bg = loadImage("./Pic/highscore.jpg");
  buttonList = new Button[] {
    new MenuButton(580, 215, 655, 280),
    new SoundButton(580, 215, 655, 280),
    new MusicButton(580, 215, 655, 280),
  };
  settingScreen = new Screen(bg, buttonList);
  
  // create change user screen
  changePlayerScreen = new ChangePlayerScreen();
  
  // create play screen
  playScreen = new PlayScreen();
  
  // create upgradeScreen
  bg = loadImage("./Pic/highscore.jpg");
  buttonList = new Button [] {
    new ResumeButton(0, 0, 100, 100),
  };
  upgradeScreen = new Screen (bg, buttonList);
  
  // create pause screen
  bg = loadImage("./Pic/menu.jpg");
  buttonList = new Button[] {
    new ResumeButton(15, 440, 250, 480),
    new MenuButton(15, 440, 250, 480),
  };
  pauseScreen = new Screen(bg, buttonList);
  
  // create win screen
  bg = loadImage("./Pic/win.jpg");
  buttonList = new Button[] {
    new MenuButton(415, 310, 495, 370)
  };
  winScreen = new Screen(bg, buttonList);
  
  // create lose screen
  bg = loadImage("./Pic/lose.jpg");
  buttonList = new Button[] {
    new MenuButton(580, 215, 655, 280),
  };
  loseScreen = new Screen(bg, buttonList);
  
  //----------------------show menu--------------------------//
  
  
  //--------------------------- tmp----------------------------
  screen = changePlayerScreen;
  shooter.currentWeapon = shooter.weaponList[0];
  shooter.aim = true;
  totalEnemyInRound = 5;
  resetRound();
}


void draw () {
  screen.show();
}