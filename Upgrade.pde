class Upgrade {
  float value;              // hold value of upgrade
  float increase;           // how much value can increase
  int maxLevel;
  int level = 0;
  float price;
  float priceIncrease;
  int method;               // 0 = +;  1 = *
  
  String name;              // name of upgrade
  String explaination;           // explaination of upgrade

  Upgrade (float value, float increase, int maxLevel, float price, float priceIncrease, int method) {
    this.value = value;
    this.increase = increase;
    this.maxLevel = maxLevel;
    this.price = price;
    this.priceIncrease = priceIncrease;
    this.method = method;
  }

  void upgrade(int num) {
    // check if player reach max level
    if (level == maxLevel) {
      screen.info.message = "Max upgrade!";
      screen.info.time = 75;
      return;
    }
    
    // check if player has enough money
    if (shooter.money < price) {
      screen.info.message = "Not enough money!";
      screen.info.time = 75;
      return;
    }  

    // upgrade
    shooter.money -= price;
    price *= priceIncrease;
    value = (method == 1) ? value * increase : value + increase;
    level++;
    
    // change screen info
    screen.info.time = 0;
    screen.infoList[12].message = str(shooter.money);
    screen.infoList[num%6 + 6].message = level + "/" + maxLevel;
  }

  void downgrade (int num) {
    // check if player reach min level
    if (level == 0) {
      screen.info.message = "Min downgrade!!";
      screen.info.time = 75;
      return;
    }

    // downgrade
    price /= priceIncrease;
    shooter.money += price * SELL_PERCENT;
    value = (method == 1) ? value / increase : value - increase;
    level--;
    
    // change screen info
    screen.info.time = 0;
    screen.infoList[12].message = str(shooter.money);
    screen.infoList[num%6 + 6].message = level + "/" + maxLevel;
  }
}