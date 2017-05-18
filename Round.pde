class Round {
  int currentRound = 0;
  int currentWorld = 0;

  int totalEnemyInRound;                     // how many enemy will be created in this round 
  int killCount;                             // how many enemy kiled
  int enemyCount;                            // how many enemy in current round
  int bulletCount;                           // how many weapon in current round 
  int effectCount;                           // number of effect in current round
  int objCount;                              // number of obj in current round
  int oldFrame        = 0;                   // save frame since the last time an enemy was created
  int newEnemyDelay = 25;                    // delay time between creation of two enemies; will receive random values in game

  Round () {
  }

  Round (int crrRound, int crrWorld) {
    this.currentRound = crrRound;
    this.currentWorld = crrWorld;
  }

  void reset() {
    killCount      = 0;
    enemyCount     = 0;
    bulletCount    = 0;
    effectCount    = 0;
    objCount       = 0;
    shooter.health = (int) shooter.upgradeList[1].value;
    oldFrame       = frameCount;
    newEnemyDelay  = (int) random(MIN_ENEMY_DELAY, MAX_ENEMY_DELAY);
    totalEnemyInRound = (int) (DEFAULT_ENEMY_NUM * pow(DIFICULTLY, currentRound));
    //>> reset special abilities
  }
}