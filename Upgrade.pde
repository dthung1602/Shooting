class Upgrade {
  float value;              // hold value of upgrade
  float increase;           // how much value can increase
  float max = 5;
  float min = 0;
  float price;
  float priceIncrease;
  int method;               // 0 = +;  1 = *
  
  String name;              // name of upgrade
  String explain;           // explaination of upgrade
  int x, y;                 // x, y pos of name to display

  Upgrade (float value, float increase, float max, float min, float price, float priceIncrease, int method) {
    this.value = value;
    this.increase = increase;
    this.max = max;
    this.min = min;
    this.price = price;
    this.priceIncrease = priceIncrease;
    this.method = method;
  }

  void upgrade() {
    // check if player has enough money
    if (shooter.money < price) {
      screen.info.message = "Not enough money!";
      screen.info.time = 75;
      return;
    }

    // check if player reach max value
    float tmp = (method == 1) ? value * increase : value + increase;
    if (tmp > max) {
      screen.info.message = "Max upgrade!";
      screen.info.time = 75;
      return;
    }

    // upgrade
    shooter.money -= price;
    price *= priceIncrease;
    value = tmp;
  }

  void downgrade () {
    // check if player reach min value
    float tmp = (method == 1) ? value / increase : value - increase;
    if (tmp < min) {
      screen.info.message = "Min downgrade!!";
      screen.info.time = 75;
      return;
    }

    // downgrade
    shooter.money += price / priceIncrease * SELL_PERCENT;
    price /= priceIncrease;
    value = tmp;
  }
  
  void show() {
    textFont(fontSmall);
    fill(color(255, 0, 0));  // name
    text(name, x, y);
    fill(color(0, 0, 255));
    text(price / priceIncrease * SELL_PERCENT, x - 50, y + 50);  // downgrade price
    text(price, x + 250, y + 50);                                // upgrade price
  }
}