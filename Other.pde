int hash (String string) {
  int h = 7;
  for (int i = 0; i < string.length(); i++) {
    h = h*31 + string.charAt(i);
  }
  return h;
}

void resetRound() {
  killCount      = 0;
  enemyCount     = 0;
  bulletCount    = 0;
  effectCount    = 0;
  objCount     = 0;
  shooter.health = shooter.maxHealth;
  oldFrame       = frameCount;
  newEnemyDelay  = (int) random(MIN_ENEMY_DELAY, MAX_ENEMY_DELAY);
}

void resetUpgrade() {
}

void resetAll() {
  resetRound();
  resetUpgrade();
  shooter.money  = DEFAULT_MONEY;
  shooter.health = DEFAULT_HEALTH;
  shooter.maxHealth = DEFAULT_HEALTH;
  currentRound = 1;  
}