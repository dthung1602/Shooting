void loadInfo() {
  String data [];
  String tmp [];

  //>>> load weapon info
  data = loadStrings("./Config/weapon.txt");
  for (int i=0; i<data.length; i++) {
    tmp = split(data[i], '_');
    shooter.weaponList[i].name = tmp[0];
    shooter.weaponList[i].explaination = tmp[1].replace("\\n", "\n");
  }

  //>>> load upgrade info
  data = loadStrings("./Config/upgrade.txt");
  for (int i=0; i<data.length; i++) {
    tmp = split(data[i], '_');
    shooter.upgradeList[i].name = tmp[0];
    shooter.upgradeList[i].explaination = tmp[1].replace("\\n", "\n");
    ;
  }

  //>>> load upgrade info to upgrade screens
  upgradeScreens[0].infoList = new Info [14];
  upgradeScreens[1].infoList = new Info [14];
  for (int i=0; i<shooter.upgradeList.length; i++)
    upgradeScreens[i/6].infoList[i%6] = new Info(shooter.upgradeList[i].name, 250 + 470 * (i%6 / 3), 275 + (i%6 % 3) * 120, YELLOW_BOLD, fontMedium);
  upgradeScreens[0].infoList[12] = upgradeScreens[1].infoList[12] = new Info("", 340, 178, BROWN, fontMedium);
  upgradeScreens[0].infoList[13] = upgradeScreens[1].infoList[13] = new Info("Hoover mouse over buttons\nfor more infomation", 600, 145, BROWN, fontMedium);

  //>>> load weapon info to upgrade screens
  upgradeScreens[2].infoList = new Info [10];
  upgradeScreens[3].infoList = new Info [10];
  for (int i=0; i<shooter.weaponList.length; i++) 
    upgradeScreens[i/4 + 2].infoList[i%4] = new Info(shooter.weaponList[i].name, 290, 290 + (i % 4) * 87, BROWN, fontMedium);
  upgradeScreens[2].infoList[8] = upgradeScreens[3].infoList[8] = new Info("", 340, 178, BROWN, fontMedium);
  upgradeScreens[2].infoList[9] = upgradeScreens[3].infoList[9] = new Info("Hoover mouse over buttons\nfor more infomation", 600, 145, BROWN, fontMedium);
}