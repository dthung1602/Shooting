/*            TO DO
 *  play screen -> finish round --> save game, unlock new round & check highscore
 *  reset upgrade
 *  Player class --> create player --> upgrade
 *  playscreen --> showShooter
 *  combine ~ button to 1 changing screen button
 *  serialization
 *  disable resize screen
 *  max 12 player's name, del player
 */

//--------------------------- import libraries-----------------------------//
import java.io.File;


//----------------------------- constant-----------------------------------//
float SELL_PERCENT   = 0.8;
float GROUND_HEIGHT  = 50;
float GRAVITY        = 0.5;
int DEFAULT_HEALTH   = 50;
int DEFAULT_MONEY    = 100;
int DEFAULT_ENEMY_NUM= 5;        // how many enemy for 1st round
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
  PlayScreen playScreen;
    Screen choosingRoundScreen;
    Screen upgradeScreen;
    Screen pauseScreen;
    Screen winScreen;
    Screen loseScreen;
  Screen dataScreen;
    ChangePlayerScreen changePlayerScreen;
    NewPlayerScreen newPlayerScreen;
  Screen settingScreen;
  Screen quitScreen;

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
//>>>>>

// other image
PImage tickPic;

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
  //----------------loading screen---------------//
  size(346, 346);
  image(loadImage("./Pic/loading.gif"), 0, 0);
  
  
  //--------------basic--------------------------//
  frameRate(20);
  rectMode(CORNERS);
  imageMode(CENTER);
  surface.setResizable(true);
  
  
  
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
  handPic      = loadImage("./Pic/laser_gun.png");
  bowPic       = loadImage("./Pic/bow.png");
  laserGunPic  = loadImage("./Pic/laser_gun.png");
  freezeGunPic = loadImage("./Pic/laser_gun.png");
  
  // enemy image
  basicEnemyPic = loadImage("./Pic/dart_monkey.png");
  //>>>
  
  // other image
  tickPic = loadImage("./Pic/tick.png");
  
  // -----------------load important objects-------------------//
  player  = new Player();
  shooter = new Shooter();
  
  //-----------------------load fonts------------------------//
  fontSmall  = loadFont("./Font/font_small.vlw");
  fontMedium = loadFont("./Font/font_medium.vlw");
  fontLarge  = loadFont("./Font/font_large.vlw");

  //------------------------------create screens-----------------------------//
  PImage bg;
  Button buttonList [];

  // -------------menu screen------------------------------
  bg = loadImage("./Pic/menu.png");
  buttonList = new Button[] {
    new ContinueButton(245, 500, 580, 560),
    new SettingButton(620, 500, 950, 560),
    new DataButton(245, 590, 580, 650),
    new QuitScreenButton(620, 590, 950, 650),
    /*new HighScoreButton(555, 440, 785, 480),*/
  };
  menuScreen = new Screen(bg, buttonList);

  // ----------------high score screen--------------------------
  //highScoreScreen = new HighScoreScreen();
  
  // ----------------data screen---------------------------------
  bg = loadImage("./Pic/choosing.png");
  buttonList = new Button [] {
    new MenuButton(165, 505, 240, 575),
    new ChangePlayerButton(250, 575, 580, 635),
    new NewPlayerButton(630, 575, 960, 635),
  };
  dataScreen = new Screen(bg, buttonList);
  
  // --------------------------create change user screen--------------------------
  changePlayerScreen = new ChangePlayerScreen();
  
  // ------------------------- create new user screen-----------
  newPlayerScreen = new NewPlayerScreen();
  
  // ------------------create choosing round screen------------------------
  bg = loadImage("./Pic/highscore.jpg");
  buttonList = new Button[] {
    new MenuButton(580, 215, 655, 280),
  };
  choosingRoundScreen = new Screen(bg, buttonList);
  choosingRoundScreen.infoList = new Info [] {
    new Info("", 500, 400, color(200,255,0), fontSmall),
  };
  
  // --------------------------create setting screen--------------------------
  bg = loadImage("./Pic/option.png");
  buttonList = new Button[] {
    new MenuButton(460, 615, 730, 675),
    new SoundButton(245, 300, 290, 345),
    new MusicButton(245, 375, 290, 410),
  };
  settingScreen = new Screen(bg, buttonList);
  
  
  
  //-------------------------- create play screen--------------------------
  playScreen = new PlayScreen();
  
  // --------------------------create upgrade screen--------------------------
  bg = loadImage("./Pic/highscore.jpg");
  buttonList = new Button [] {
    new ContinueButton(0, 0, 100, 100),
  };
  upgradeScreen = new Screen (bg, buttonList);
  
  // --------------------------create pause screen--------------------------
  bg = loadImage("./Pic/pausing.png");
  buttonList = new Button[] {
    new ResumeButton(250, 575, 580, 635),
    new MenuButton(630, 575, 960, 635),
  };
  pauseScreen = new Screen(bg, buttonList);
  
  // --------------------------create win screen--------------------------
  bg = loadImage("./Pic/win.jpg");
  buttonList = new Button[] {
    new MenuButton(415, 310, 495, 370)
  };
  winScreen = new Screen(bg, buttonList);
  
  // --------------------------create lose screen--------------------------
  bg = loadImage("./Pic/lose.jpg");
  buttonList = new Button[] {
    new MenuButton(580, 215, 655, 280),
  };
  loseScreen = new Screen(bg, buttonList);
  
  // ------------------------create quit screen----------------------------
  bg = loadImage("./Pic/quit.png");
  buttonList = new Button[] {
    new QuitButton(250, 590, 580, 660),
    new MenuButton(630, 590, 960, 660),
  };
  quitScreen = new Screen(bg, buttonList);
  
  //----------------------show menu--------------------------//
  
  
  //--------------------------- tmp----------------------------
  screen = menuScreen;
  surface.setSize(screen.bg.width, screen.bg.height);
  shooter.currentWeapon = shooter.weaponList[0];
  shooter.upgradeList[0].value = 1;
  resetRound();
}


void draw () {
  screen.show();
}