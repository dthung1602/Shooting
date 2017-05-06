/*            TO DO
 *  play screen -> finish round --> unlock new round
 *  reset upgrade
 *  playscreen --> showShooter
 *  serialization
 *  max 12 player's name
 *  show upgrade name, price, explaination in ug screen
 *  add sound
 *  buttons coordinates
 *  confirm delete player screen
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
Screen mapScreen;
Screen upgradeScreens [];
Screen pauseScreen;
Screen winScreen;
Screen loseScreen;
Screen dataScreen;
Screen changePlayerScreen;
Screen newPlayerScreen;
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


// -----------------------object list-------------------------
Screen screenList [];



void setup () {
  //----------------loading screen---------------//
  size(346, 346);
  image(loadImage("./Pic/loading.gif"), 0, 0);

  //--------------basic--------------------------//
  frameRate(20);
  rectMode(CORNERS);
  imageMode(CENTER);
  ellipseMode(CORNERS);

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
  Info infoList [];

  // -------------menu screen------------------------------
  bg = loadImage("./Pic/menu.png");
  buttonList = new Button[] {
    new ContinueButton(245, 500, 580, 560), 
    new ChangeScreenButton(620, 500, 950, 560, 8), 
    new ChangeScreenButton(245, 590, 580, 650, 5), // data screen
    new ChangeScreenButton(620, 590, 950, 650, 9), 
  /*new HighScoreButton(555, 440, 785, 480),*/
  };
  menuScreen = new Screen(bg, buttonList);

  // ----------------high score screen--------------------------
  //highScoreScreen = new HighScoreScreen();

  // ----------------data screen---------------------------------
  bg = loadImage("./Pic/choosing.png");
  buttonList = new Button [] {
    new ChangeScreenButton(165, 505, 240, 575, 0), // menu screen
    new ChangePlayerButton(250, 575, 580, 635), 
    new NewPlayerButton(630, 575, 960, 635), 
  };
  buttonList[0].circle = true;
  dataScreen = new Screen(bg, buttonList);

  // --------------------------create change user screen--------------------------
  bg = loadImage("./Pic/login.png");
  buttonList = new Button[] {
    new ChangeScreenButton(157, 25, 235, 100, 5), // data screen
    new LoginButton(455, 615, 725, 675), 
    new DeletePlayerButton(0, 0, 100, 100),
    new TextFieldButton(365, 330, 1000, 382, 0), 
    new TextFieldButton(365, 425, 1000, 475, 1), 
  };
  changePlayerScreen = new Screen(bg, buttonList);
  updatePlayerList();

  // ------------------------- create new user screen-----------
  bg = loadImage("./Pic/new_player.png");
  buttonList = new Button [] {
    new ChangeScreenButton(155, 25, 235, 100, 5), // data screen
    new CreateNewUserButton(460, 615, 725, 680), 
    new TextFieldButton(205, 300, 840, 350, 0), 
    new TextFieldButton(205, 455, 840, 505, 1), 
    new TextFieldButton(205, 525, 840, 575, 2), 
  };
  infoList = new Info [] {
    new Info("", 220, 332, BOLD_RED, fontMedium), 
    new Info("", 220, 488, BOLD_RED, fontMedium), 
    new Info("", 220, 558, BOLD_RED, fontMedium), 
  };
  infoList[1].hiden = true;
  infoList[2].hiden = true;
  newPlayerScreen = new Screen(bg, buttonList, infoList);

  // ------------------create map screen------------------------
  bg = loadImage("./Pic/highscore.jpg");
  buttonList = new Button[] {
    new ChangeScreenButton(580, 215, 655, 280, 0), // menu screen
  };
  mapScreen = new Screen(bg, buttonList);
  mapScreen.infoList = new Info [] {
    new Info("", 500, 400, color(200, 255, 0), fontSmall), 
  };

  // --------------------------create setting screen--------------------------
  bg = loadImage("./Pic/option.png");
  buttonList = new Button[] {
    new ChangeScreenButton(460, 615, 730, 675, 0), // menu screen
    new SoundButton(245, 300, 290, 345), 
    new MusicButton(245, 375, 290, 410), 
  };
  settingScreen = new Screen(bg, buttonList);



  //-------------------------- create play screen--------------------------
  playScreen = new PlayScreen();

  //>> --------------------------create upgrade screens--------------------------
  upgradeScreens = new Screen [4];

  //-----------screen 0----------------
  bg = loadImage("./Pic/upgrade0.png");
  buttonList = new Button [] {
    new ChangeScreenButton(168, 619, 432, 678, 0), // menu screen
    new ChangeScreenButton(459, 620, 724, 677, 1), // map screen
    new ContinueButton(751, 623, 1013, 677), 
    // new ResetButton(160, 31, 235, 100),
    new UpgradeScreenButton(955, 29, 1028, 102, 1), 

    new UpgradeButton(503, 242, 556, 290, 0), 
    new UpgradeButton(502, 363, 557, 411, 1), 
    new UpgradeButton(505, 482, 558, 527, 2), 
    new UpgradeButton(960, 242, 1013, 290, 3), 
    new UpgradeButton(960, 365, 1012, 412, 4), 
    new UpgradeButton(961, 482, 1014, 530, 5), 

    new DowngradeButton(184, 242, 241, 292, 0), 
    new DowngradeButton(186, 364, 240, 416, 1), 
    new DowngradeButton(185, 481, 241, 534, 2), 
    new DowngradeButton(640, 243, 697, 293, 3), 
    new DowngradeButton(642, 366, 697, 416, 4), 
    new DowngradeButton(641, 481, 699, 531, 5), 
  };
  upgradeScreens[0] = new Screen (bg, buttonList);

  //-----------screen 1----------------
  bg = loadImage("./Pic/upgrade1.png");
  buttonList = new Button [] {
    new ChangeScreenButton(168, 619, 432, 678, 0), // menu screen
    new ChangeScreenButton(459, 620, 724, 677, 1), // map screen
    new ContinueButton(751, 623, 1013, 677), 
    // new ResetButton(160, 31, 235, 100),
    new UpgradeScreenButton(859, 31, 933, 100, 0), 
    new UpgradeScreenButton(955, 29, 1028, 102, 2), 

    new UpgradeButton(503, 242, 556, 290, 6), 
    new UpgradeButton(502, 363, 557, 411, 7), 
    new UpgradeButton(505, 482, 558, 527, 8), 
    new UpgradeButton(960, 242, 1013, 290, 9), 
    //new UpgradeButton(960, 365, 1012, 412, 10),
    //new UpgradeButton(961, 482, 1014, 530, 11),

    new DowngradeButton(184, 242, 241, 292, 6), 
    new DowngradeButton(186, 364, 240, 416, 7), 
    new DowngradeButton(185, 481, 241, 534, 8), 
    new DowngradeButton(640, 243, 697, 293, 9), 
    //new DowngradeButton(642, 366, 697, 416, 10),
    //new DowngradeButton(641, 481, 699, 531, 11),
  };
  upgradeScreens[1] = new Screen (bg, buttonList);

  //-----------screen 2----------------
  bg = loadImage("./Pic/upgrade2.png");
  buttonList = new Button [] {
    new ChangeScreenButton(168, 619, 432, 678, 0), // menu screen
    new ChangeScreenButton(459, 620, 724, 677, 1), // map screen
    new ContinueButton(751, 623, 1013, 677), 
    // new ResetButton(160, 31, 235, 100),
    new UpgradeScreenButton(859, 31, 933, 100, 1), 
    new UpgradeScreenButton(955, 29, 1028, 102, 3), 

    new BuyWeaponButton(214, 263, 258, 300, 0), 
    new BuyWeaponButton(214, 346, 257, 387, 1), 
    new BuyWeaponButton(214, 433, 256, 473, 2), 
    new BuyWeaponButton(214, 517, 256, 558, 3), 

    new BuyBulletButton(955, 269, 989, 297, 0), 
    new BuyBulletButton(956, 354, 988, 383, 1), 
    new BuyBulletButton(955, 442, 987, 470, 2), 
    new BuyBulletButton(954, 525, 987, 553, 3), 
  };
  upgradeScreens[2] = new Screen (bg, buttonList);

  //-----------screen 3----------------
  bg = loadImage("./Pic/upgrade3.png");
  buttonList = new Button [] {
    new ChangeScreenButton(168, 619, 432, 678, 0), // menu screen
    new ChangeScreenButton(459, 620, 724, 677, 1), // map screen
    new ContinueButton(751, 623, 1013, 677), 
    // new ResetButton(160, 31, 235, 100),
    new UpgradeScreenButton(955, 29, 1028, 102, 2), 

    new BuyWeaponButton(214, 263, 258, 300, 4), 
    new BuyWeaponButton(214, 346, 257, 387, 5), 
    //new BuyWeaponButton(214, 433, 256, 473, 6),
    //new BuyWeaponButton(214, 517, 256, 558, 7),

    new BuyBulletButton(955, 269, 989, 297, 4), 
    new BuyBulletButton(956, 354, 988, 383, 5), 
    //new BuyBulletButton(955, 442, 987, 470, 6),
    //new BuyBulletButton(954, 525, 987, 553, 7),  
  };
  upgradeScreens[3] = new Screen (bg, buttonList);  

  // --------------------------create pause screen--------------------------
  bg = loadImage("./Pic/pausing.png");
  buttonList = new Button[] {
    new ContinueButton(250, 575, 580, 635), 
    new ChangeScreenButton(630, 575, 960, 635, 0), // menu screen
  };
  pauseScreen = new Screen(bg, buttonList);

  // --------------------------create win screen--------------------------
  bg = loadImage("./Pic/win.jpg");
  buttonList = new Button[] {
    new ChangeScreenButton(415, 310, 495, 370, 0)  // menu screen
  };
  winScreen = new Screen(bg, buttonList);

  // --------------------------create lose screen--------------------------
  bg = loadImage("./Pic/lose.jpg");
  buttonList = new Button[] {
    new ChangeScreenButton(580, 215, 655, 280, 0), // menu screen
  };
  loseScreen = new Screen(bg, buttonList);

  // ------------------------create quit screen----------------------------
  bg = loadImage("./Pic/quit.png");
  buttonList = new Button[] {
    new QuitButton(250, 590, 580, 660), 
    new ChangeScreenButton(630, 590, 960, 660, 0), // menu screen
  };
  quitScreen = new Screen(bg, buttonList);

  // ------------------------ create object list -------------------------
  screenList = new Screen []{
    menuScreen, //0
    mapScreen, 
    pauseScreen, //2 
    winScreen, 
    loseScreen, //4
    dataScreen, 
    changePlayerScreen, //6
    newPlayerScreen, 
    settingScreen, //8
    quitScreen, 
  };


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