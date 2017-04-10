String toString (int x) {
  String s = "";
  int digit [] = new int [0];
  while (x>0) {
    digit = append(digit,x%10);
    x /= 10;
  }
  for (int i=digit.length-1; i>=0; i--){
    String tmp = "";
    switch (digit[i]) {
      case 0: tmp = "0"; break;
      case 1: tmp = "1"; break;
      case 2: tmp = "2"; break;
      case 3: tmp = "3"; break;
      case 4: tmp = "4"; break;
      case 5: tmp = "5"; break;
      case 6: tmp = "6"; break;
      case 7: tmp = "7"; break;
      case 8: tmp = "8"; break;
      case 9: tmp = "9"; break;
    }
    s = s + tmp;
  }
  if (s.length()==0) return "0";
  return s;
}