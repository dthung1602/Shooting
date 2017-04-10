float groundHeight; 
float gravity = 0.5;
color GROUND = color(50,255,5);
Canon c = new Canon();
int ballRate;
int defaultHealth = 100;
int health;
int popCount;
Ball ballList [];
Bullet bulletList [];
HBullet hbulletList [];
VBullet vbulletListL [];
VBullet vbulletListR [];
PFont font;
PFont bigfont;
float maxSpeed;
String info;
int infoTime;
int bulletCount;
boolean pause = false;
int size;
color bulletColor;


//specialAction var
boolean saClear = false; 
float saMaxSpeed;
boolean saAntiGravity = false;
boolean saGravity = false;
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
  //size(1200,700);
  fullScreen();
  frameRate(50);
  rectMode(CENTER);
  
  font = loadFont("ComicSansMS-Bold-25.vlw");
  bigfont = loadFont("ComicSansMS-Bold-48.vlw");
  groundHeight = height*3/4;

  size = 10;
  bulletColor = color(0);
  bulletCount = 0;
  ballRate = 125;
  health = defaultHealth;
  popCount = 0;
  maxSpeed = 3;
  ballList = new Ball [0];
  bulletList = new Bullet [0];
  hbulletList = new HBullet [0];
  vbulletListL = new VBullet [0];
  vbulletListR = new VBullet [0];
  
  saClear = false; 
  saMaxSpeed = 0;
  saAntiGravity = false;
  saGravity = false;
  laserOn = 0;
  saFreeze = 0;
  saGiantBullet = 0;
  saFireBullet = 0;
  saFireWorkBullet = 0;
  saFastBullet = 1;
  minSize = 20;
  midSize = 30;
  maxSize = 40;
  saBigBall = 0;
  hShoot = false;
  hshootRate = 150;
  vShoot = false;
  vshootRate = 150;
}