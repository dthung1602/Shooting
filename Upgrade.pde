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

  Upgrade (String name, String explaination, float value, float increase, int maxLevel, float price, float priceIncrease, int method) {
    this.name = name;
    this.explaination = explaination;
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
      screen.info.time = MESSAGE_TIME_SHORT;
      return;
    }
    
    // check if player has enough money
    if (shooter.money < price) {
      screen.info.message = "Not enough money!";
      screen.info.time = MESSAGE_TIME_SHORT;
      return;
    }  

    // upgrade
    shooter.money -= price;
    price *= priceIncrease;
    value = (method == 1) ? value * increase : value + increase;
    level++;
    
    // change screen info
    updateInfo(num);
  }

  void downgrade (int num) {
    // check if player reach min level
    if (level == 0) {
      screen.info.message = "Min downgrade!!";
      screen.info.time = MESSAGE_TIME_SHORT;
      return;
    }

    // downgrade
    price /= priceIncrease;
    shooter.money += price * SELL_PERCENT;
    value = (method == 1) ? value / increase : value - increase;
    level--;
    
    // change screen info
    updateInfo(num);
  }
  
  private void updateInfo (int num) {
    screen.info.time = 0;
    screen.infoList[num%6 + 6].message = level + "/" + maxLevel;
    upgradeScreens[0].infoList[12].message = str(shooter.money);
    upgradeScreens[1].infoList[12].message = str(shooter.money);
    upgradeScreens[2].infoList[8].message = str(shooter.money);
    upgradeScreens[3].infoList[8].message = str(shooter.money);
  }
}