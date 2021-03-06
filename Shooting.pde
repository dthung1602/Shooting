/*            TO DO
 *  reset upgrade
 *  max 12 player's name
 *  add sound 
 *  optimize import
 *  pos of init bullet, shooter.x, shooter.y
 * change all img to right size
 * disguid enemy
 */

//---------------------------- import libraries -----------------------------//
import java.io.*;
import java.security.*;
import ddf.minim.*;

//----------------------------- constants -----------------------------------//
float SELL_PERCENT    = 0.8;
float GROUND_HEIGHT   = 50;
float GRAVITY         = 0.5;
int DEFAULT_HEALTH    = 50;
int DEFAULT_MONEY     = 100;
int DEFAULT_ENEMY_NUM = 5;        // how many enemy for 1st round
int MAX_ROUND         = 9;
int ENEMY_LIST_SIZE   = 500;
int BULLET_LIST_SIZE  = 2000;
int ENEMY_BULLET_SIZE = 200;
int EFFECT_LIST_SIZE  = 500;
int STUFF_LIST_SIZE   = 100;
float DIFICULTLY      = 1.2;
int MIN_ENEMY_DELAY   = 10;
int MAX_ENEMY_DELAY   = 30;

int MESSAGE_TIME_SHORT   = 30;
int MESSAGE_TIME_LONG    = 60;
int MESSAGE_TIME_FOREVER = -1;

color WHITE        = color(255);
color RED          = color(255, 0, 0);
color PINK         = color(255, 127, 127);
color BROWN        = color(178, 111, 0);
color YELLOW_BOLD  = color(242, 207, 92);
color CLEAR_BLUE   = color(50, 180, 250, 40);
color DARK_BLUE    = color(0, 20, 128);
color BLUE         = color(20, 110, 160);
color DARK_GREEN   = color(20, 100, 0);
color GREEN        = color(100, 160, 40);

//----------------------------basic objects------------------------------//
Screen screen;
Round round;
Player player;
Shooter shooter;

//----------------------------- lists------------------------------------//
Enemy enemyList []         = new Enemy [ENEMY_LIST_SIZE];
Bullet bulletList []       = new Bullet [BULLET_LIST_SIZE];
EnemyBullet enemyBulletList[]   = new EnemyBullet [ENEMY_BULLET_SIZE];
VisualEffect effectList [] = new VisualEffect [EFFECT_LIST_SIZE];
Obj objList []             = new Obj [STUFF_LIST_SIZE];
Screen screenList [];

// ---------------------------- screens --------------------------------//
Screen menuScreen;
PlayScreen playScreen;
Screen mapScreens [];
Screen upgradeScreens [];
Screen pauseScreen;
Screen winScreen;
Screen loseScreen;
Screen dataScreen;
Screen changePlayerScreen;
Screen newPlayerScreen;
Screen confirmScreen;
Screen settingScreen;
Screen quitScreen;
Screen chooseRoundScreen;
Screen leaveGameScreen;

//------------------------------ images -------------------------------//
// images of bullets
PImage stonePic;
PImage shurikenPic;
PImage arrowPic;
PImage icePic;
PImage grenadePic;
PImage laserPic;

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
PImage fastEnemyPic;
PImage flyEnemyPic;
PImage strongEnemyPic;

// image of obj
PImage wallPic;
PImage bigWallPic;
PImage barrelPic;
PImage toxicBarrelPic;

// other images
PImage playPic;
PImage tickPic;
PImage lockRoundPic;
PImage lockWorldPic;

// enemy bullet
PImage bombPic;

//------------------------------ fonts -------------------------------//
PFont fontSmall;
PFont fontMedium;
PFont fontLarge;

//------------------------------ sound ------------------------------//
Minim minim;
AudioPlayer bgSound;
AudioPlayer dartSound;
AudioPlayer iceSound;
AudioPlayer bombSound;
AudioPlayer laserSound;

boolean musicEnable = true;
boolean soundEnable = true;


void setup () {
  //----------------loading screen---------------//
  size(1200, 700);
  background(loadImage("./Pic/screen/loading.png"));


  //-------------------basic---------------------//
  frameRate(20);
  rectMode(CORNERS);
  imageMode(CENTER);
  ellipseMode(CORNERS);

  //-------------------load data-----------------//
  loadImages();
  loadFonts();
  loadSounds();
  createScreens();

  // --------create important objects------------//
  player  = new Player();
  shooter = new Shooter();
  round = new Round();

  //--------------ready to start----------------//
  loadInfoToScreens();
  round.reset();
  shooter.currentWeapon = shooter.weaponList[0];

  screen = menuScreen;
  surface.setResizable(true);
  surface.setSize(screen.bg.width, screen.bg.height);
  surface.setResizable(false);
}


void draw () {
  screen.show();
}


void loadImages() {
  // bullet images
  stonePic   = loadImage("./Pic/bullet/stone.png");
  shurikenPic= loadImage("./Pic/bullet/dart.png");
  arrowPic   = loadImage("./Pic/bullet/arrow.png");
  icePic     = loadImage("./Pic/bullet/ice.png");
  grenadePic = loadImage("./Pic/bullet/grenade.png");
  laserPic   = loadImage("./Pic/bullet/laser.gif");

  //effect images
  explosionPic = loadImage("./Pic/effect/explosion.png");
  snowflakePic = loadImage("./Pic/effect/explosion.png"); //>>>>

  //weapon image
  handPic      = loadImage("./Pic/weapon/laser_gun.png");
  bowPic       = loadImage("./Pic/weapon/bow.png");
  laserGunPic  = loadImage("./Pic/weapon/laser_gun.png");
  freezeGunPic = loadImage("./Pic/weapon/laser_gun.png");

  // obj image
  wallPic        = loadImage("./Pic/obj/wall.png");
  bigWallPic     = loadImage("./Pic/obj/big_wall.png");
  barrelPic      = loadImage("./Pic/obj/barrel.png");
  toxicBarrelPic = loadImage("./Pic/obj/toxic_barrel.png");

  // other image
  playPic = loadImage("./Pic/screen/play.png");
  tickPic = loadImage("./Pic/other/tick.png");
  lockRoundPic = loadImage("./Pic/other/lock_round.png");
  lockWorldPic = loadImage("./Pic/other/lock_world.png");
  
  // enemy bullet 
  bombPic = loadImage("./Pic/other/bomb.png");
}


void loadFonts() {
  fontSmall  = loadFont("./Font/font_small.vlw");
  fontMedium = loadFont("./Font/font_medium.vlw");
  fontLarge  = loadFont("./Font/font_large.vlw");
}


void loadSounds() {
  //>>>
}


void createScreens() {
  PImage bg;
  Button buttonList [];
  Info infoList [];

  //---------------menu screen---------------
  bg = loadImage("./Pic/screen/menu.png");
  buttonList = new Button[] {
    new MapScreenButton(245, 525, 580, 590, 0), // map screen
    new ChangeScreenButton(615, 525, 950, 590, 8), // setting screen
    new ChangeScreenButton(245, 615, 580, 680, 5), // data screen
    new ChangeScreenButton(615, 615, 950, 680, 9), // quit screen
  };
  menuScreen = new Screen(bg, buttonList);

  //---------------data screen---------------
  bg = loadImage("./Pic/screen/choosing.png");
  buttonList = new Button [] {
    new ChangeScreenButton(165, 525, 240, 603, 0), // menu screen
    new ChangePlayerButton(245, 600, 580, 668), 
    new NewPlayerButton(625, 600, 960, 668), 
  };
  buttonList[0].circle = true;
  dataScreen = new Screen(bg, buttonList);

  // ---------------create change user screen---------------
  bg = loadImage("./Pic/screen/login.png");
  buttonList = new Button[] {
    new ChangeScreenButton(158, 30, 232, 102, 5), // data screen
    new LoginButton(678, 617, 944, 678), 
    new ChangeScreenButton(281, 620, 547, 679, 10), 
    new TextFieldButton(365, 330, 1000, 384, 0), 
    new TextFieldButton(365, 420, 1000, 477, 1), 
  };
  changePlayerScreen = new Screen(bg, buttonList);

  // --------------- create new user screen---------------
  bg = loadImage("./Pic/screen/new_player.png");
  buttonList = new Button [] {
    new ChangeScreenButton(155, 27, 235, 102, 5), // data screen
    new CreateNewUserButton(457, 615, 725, 680), 
    new TextFieldButton(205, 298, 840, 350, 0), 
    new TextFieldButton(205, 455, 840, 508, 1), 
    new TextFieldButton(205, 522, 840, 577, 2), 
  };
  infoList = new Info [] {
    new Info("", 220, 332, RED, fontMedium), 
    new Info("", 220, 488, RED, fontMedium), 
    new Info("", 220, 558, RED, fontMedium), 
  };
  infoList[1].hidden = true;
  infoList[2].hidden = true;
  newPlayerScreen = new Screen(bg, buttonList, infoList);

  // ---------------create map screens---------------
  mapScreens = new Screen [2];

  // -------map screen 0---------
  bg = loadImage("./Pic/screen/map0.png");
  buttonList = new Button  [] {
    new ChangeScreenButton (67, 28, 140, 100, 0), // menu screen
    new MapScreenButton (1064, 30, 1138, 100, 1), 
    new UpgradeScreenButton(167, 28, 240, 100, 0), 

    new ChooseWorldButton (102, 138, 404, 338, 0), 
    new ChooseWorldButton (456, 138, 757, 338, 1), 
    new ChooseWorldButton (807, 138, 1106, 338, 2), 
    new ChooseWorldButton (102, 420, 404, 620, 3), 
    new ChooseWorldButton (456, 420, 757, 620, 4), 
    new ChooseWorldButton (807, 420, 1106, 620, 5), 
  };
  mapScreens[0] = new Screen(bg, buttonList);

  // -------map screen 1---------
  bg = loadImage("./Pic/screen/map1.png");
  buttonList = new Button  [] {
    new ChangeScreenButton (67, 28, 141, 100, 0), // menu screen
    new MapScreenButton (969, 30, 1043, 100, 0), 
    new UpgradeScreenButton(167, 28, 240, 100, 0), 

    new ChooseWorldButton (102, 138, 404, 338, 6), 
    new ChooseWorldButton (456, 138, 757, 338, 7), 
    new ChooseWorldButton (807, 138, 1106, 338, 8), 
    new ChooseWorldButton (102, 420, 404, 620, 9), 
    new ChooseWorldButton (456, 420, 757, 620, 10), 
    new ChooseWorldButton (807, 420, 1106, 620, 11), 
  };
  mapScreens[1] = new Screen(bg, buttonList);

  //---------------create choose round screen---------------
  bg = loadImage("./Pic/screen/choose_round.png");
  buttonList = new Button  [] {
    new MapScreenButton (59, 31, 134, 103, 0), // map screen
    new ChooseRoundButton (246, 168, 342, 249, 0), 
    new ChooseRoundButton (451, 171, 546, 250, 1), 
    new ChooseRoundButton (660, 170, 756, 252, 2), 
    new ChooseRoundButton (860, 174, 956, 253, 3), 
    new ChooseRoundButton (247, 332, 343, 412, 4), 
    new ChooseRoundButton (451, 334, 547, 414, 5), 
    new ChooseRoundButton (660, 333, 757, 413, 6), 
    new ChooseRoundButton (862, 334, 956, 416, 7), 
    new ChooseRoundButton (482, 487, 722, 629, 8), // boss
  };
  chooseRoundScreen = new Screen(bg, buttonList);

  // ---------------create setting screen---------------
  bg = loadImage("./Pic/screen/option.png");
  buttonList = new Button[] {
    new ChangeScreenButton(457, 615, 720, 680, 0), // menu screen
    new SoundButton(245, 300, 290, 345), 
    new MusicButton(245, 372, 290, 413), 
  };
  settingScreen = new Screen(bg, buttonList);

  //--------------- create play screen---------------
  playScreen = new PlayScreen();

  // ---------------create upgrade screens---------------
  upgradeScreens = new Screen [4];

  //-----------screen 0----------------
  bg = loadImage("./Pic/screen/upgrade0.png");
  buttonList = new Button [] {
    new ChangeScreenButton(168, 619, 432, 678, 0), // menu screen
    new MapScreenButton(459, 620, 724, 677, 0), // map screen
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
  upgradeScreens[0].status = 0;


  //-----------screen 1----------------
  bg = loadImage("./Pic/screen/upgrade1.png");
  buttonList = new Button [] {
    new ChangeScreenButton(168, 619, 432, 678, 0), // menu screen
    new MapScreenButton(459, 620, 724, 677, 0), // map screen
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
  upgradeScreens[1].status = 1;

  //-----------screen 2----------------
  bg = loadImage("./Pic/screen/upgrade2.png");
  buttonList = new Button [] {
    new ChangeScreenButton(168, 619, 432, 678, 0), // menu screen
    new MapScreenButton(459, 620, 724, 677, 0), // map screen
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
  upgradeScreens[2].status = 2;

  //-----------screen 3----------------
  bg = loadImage("./Pic/screen/upgrade3.png");
  buttonList = new Button [] {
    new ChangeScreenButton(168, 619, 432, 678, 0), // menu screen
    new MapScreenButton(459, 620, 724, 677, 0), // map screen
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
  upgradeScreens[3].status = 3;

  // --------------------------create pause screen--------------------------
  bg = loadImage("./Pic/screen/pausing.png");
  buttonList = new Button[] {
    new ContinueButton(250, 575, 580, 635), 
    new ChangeScreenButton(630, 575, 960, 635, 0), // menu screen
  };
  pauseScreen = new Screen(bg, buttonList);

  // --------------------------create win screen--------------------------
  bg = loadImage("./Pic/screen/win.png");
  buttonList = new Button[] {
    new MapScreenButton(315, 620, 578, 680, 0), 
    new ChangeScreenButton(605, 620, 867, 680, 0)  // menu scree
  };
  winScreen = new Screen(bg, buttonList);

  // --------------------------create lose screen--------------------------
  bg = loadImage("./Pic/screen/lose.png");
  buttonList = new Button[] {
    new ContinueButton(257, 317, 354, 397), // play again
    new UpgradeScreenButton(257, 435, 354, 517, 0), // upgrade
    new MapScreenButton(315, 620, 578, 680, 0), 
    new ChangeScreenButton(605, 620, 867, 680, 0)  // menu scree
  };
  loseScreen = new Screen(bg, buttonList);

  // ------------------------create quit screen----------------------------
  bg = loadImage("./Pic/screen/quit.png");
  buttonList = new Button[] {
    new QuitButton(245, 618, 580, 683), 
    new ChangeScreenButton(622, 618, 960, 683, 0), // menu screen
  };
  quitScreen = new Screen(bg, buttonList);

  // ------------------------------confirm screen------------------------
  bg = loadImage("./Pic/screen/confirm.png");
  buttonList = new Button[] { 
    new ChangeScreenButton(315, 620, 579, 678, 6), // change player screen
    new DeletePlayerButton(603, 624, 870, 677), 
  };
  confirmScreen = new Screen(bg, buttonList);

  // --------------------------create leave game screen-------------------
  bg = loadImage("./Pic/screen/leave_game.png");
  buttonList = new Button[] {
    new ChangeScreenButton(315, 620, 579, 678, 11), // change player screen
    new ChangeScreenButton(603, 624, 870, 677, 0), 
  };
  leaveGameScreen = new Screen(bg, buttonList);

  //-----------------------screen list-------------------------------
  screenList = new Screen []{
    menuScreen, //0
    chooseRoundScreen, 
    pauseScreen, //2 
    winScreen, 
    loseScreen, //4
    dataScreen, 
    changePlayerScreen, //6
    newPlayerScreen, 
    settingScreen, //8
    quitScreen, 
    confirmScreen, // 10
    playScreen, 
    leaveGameScreen, // 12
  };
}


void loadInfoToScreens() {
  // load upgrade info to upgrade screens
  upgradeScreens[0].infoList = new Info [14];
  upgradeScreens[1].infoList = new Info [14];
  for (int i=0; i<shooter.upgradeList.length; i++)
    upgradeScreens[i/6].infoList[i%6] = new Info(shooter.upgradeList[i].name, 250 + 470 * (i%6 / 3), 275 + (i%6 % 3) * 120, YELLOW_BOLD, fontMedium);
  upgradeScreens[0].infoList[12] = upgradeScreens[1].infoList[12] = new Info("", 340, 178, BROWN, fontMedium);
  upgradeScreens[0].infoList[13] = upgradeScreens[1].infoList[13] = new Info("Hoover mouse over buttons\nfor more infomation", 600, 145, BROWN, fontMedium);

  // load weapon info to buy weapon screens
  upgradeScreens[2].infoList = new Info [10];
  upgradeScreens[3].infoList = new Info [10];
  for (int i=0; i<shooter.weaponList.length; i++) 
    upgradeScreens[i/4 + 2].infoList[i%4] = new Info("[" + (i+1) + "]  " + shooter.weaponList[i].name + "Bullet li", 290, 290 + (i % 4) * 87, BROWN, fontMedium);
  upgradeScreens[2].infoList[8] = upgradeScreens[3].infoList[8] = new Info("", 340, 178, BROWN, fontMedium);
  upgradeScreens[2].infoList[9] = upgradeScreens[3].infoList[9] = new Info("Hoover mouse over buttons\nfor more infomation", 600, 145, BROWN, fontMedium);

  // update info in change player screen
  player.updatePlayerList();
}