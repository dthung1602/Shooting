void resetRound() {
  size          = 1;
  killCount     = 0;
  enemyCount    = 0;
  bulletCount   = 0;
  effectCount   = 0;
  stuffCount    = 0;
  oldFrame      = frameCount;
  newEnemyDelay = (int) random(MIN_ENEMY_DELAY, MAX_ENEMY_DELAY);
}

void resetUpgrade() {
}

void resetAll() {
  resetRound();
  resetUpgrade();
  shooter.money  = DEFAULT_MONEY;
  shooter.health = DEFAULT_HEALTH;
  currentRound = 1;  
}