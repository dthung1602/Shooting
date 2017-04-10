void keyPressed () {
  if (pause) 
    loop();
  else
    noLoop();
  pause = ! pause;
}