PImage enemy1, enemy2, enemy3, enemy4;
PImage gameBackground1, gameBackground2;
PImage bloodPicture;
PImage deathPicture;
PImage failure, endPicture1, endPicture2, endPicture3, endPicture4;
int enemyHp = 1000, enemyFull_hp = 1000;
int cntEnemy = 0, cntBackground = 0;

void settingGameBackground() {
  gameBackground1 = loadImage("背景1.png");
  gameBackground2 = loadImage("背景2.png");
  enemy1 = loadImage("小怪_天使.png");
  enemy2 = loadImage("小怪_花怪.png");
  enemy3 = loadImage("怪_骷髏.png");
  enemy4 = loadImage("小怪_唐老鴨.png");
  deathPicture = loadImage("死神.png");
  enemyAttackPicture = loadImage("爪痕.png");
  bloodPicture = loadImage("血框.png");
  failure = loadImage("failure.png");
  endPicture1 = loadImage("bad.jpg");
  endPicture2 = loadImage("thirdbad.jpg");
  endPicture3 = loadImage("normal.jpg");
  endPicture4 = loadImage("happy.png");
}

void drawGameBackground() {
  background(255);
  switch(cntBackground%2) {
    case 0:
      image(gameBackground1,0,0,width,370);
      break;
    case 1:
      image(gameBackground2,0,0,width,370);
      break;
  }
  switch(cntEnemy%4) {
    case 0:
      image(enemy1, 135, 70, 270, 300);
      break;
    case 1:
      image(enemy2, 135, 70, 270, 300);
      break;
    case 2:
      image(enemy3, 135, 70, 270, 300);
      break;
    case 3:
      image(enemy4, 135, 70, 270, 300);
      break;
  }
  fill(255);
  noStroke();
  rect(400, 300, 140, 70);
  textSize(20);
  fill(0);
  textAlign(LEFT);
  text("剩餘回合:", 400, 320);
  textSize(40);
  text(gameRound, 460, 360);
  drawEnemyHealthBar();
  drawEnemyKillCount();
}

void drawEnemyHealthBar() {
  noStroke();
  fill(150, 137, 134);
  rect(120,  height/15 - 20, 300,  30);
  fill(0, 0, 0);
  rect(125,  height/15 - 17.5, 290,  25);
  fill(255, 0, 0);
  rect(125, height/15 - 17.5, 290 * ((float)enemyHp / enemyFull_hp),  25);
  
  textAlign(RIGHT, CENTER);
  textSize(24);
  fill(255, 255, 255);
  String show_hp = Integer.toString((int)enemyHp) + "/" + Integer.toString((int)enemyFull_hp);
  text(show_hp, 330, height/15 - 6);
  textAlign(CENTER, CENTER);
}

void drawEnemyKillCount(){
  fill(255);
  stroke(0);
  strokeWeight(5);
  rect(3, 3, 90, 90);
  noStroke();
  
  fill(0);
  textSize(48);
  text(cntEnemy, 49,47);
}
