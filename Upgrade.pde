class Upgrade {
  float value;              // hold value of upgrade
  float increase;           // how much value can increase
  float max = 5;
  float min = 0;
  float price;
  float priceIncrease;
  int method;               // 0 = +;  1 = *

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
}