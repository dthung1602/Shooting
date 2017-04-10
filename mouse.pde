void mousePressed () {
  if (health>0) {
    Bullet b = new Bullet((float) (mouseX-width/2)/20,(float) (mouseY-groundHeight)/20);
    bulletList = (Bullet []) append(bulletList,b);
    bulletCount += 1;
  } else {
    if (width/6<=mouseX && mouseX<width/6+200 && height*3/4<mouseY && mouseY<height*3/4+70)
      setup();
  }
}