float bulletX, bulletY;
float explodeX, explodeY;
float targetX, targetY;
boolean shooting = false;
boolean exploding = false;
float speed = 10.0;
float bulletSize = 20;
float explode = 20;
int targetIndex = 0;
PImage enemyAttackPicture;
boolean enemyAttacking = false;
int cntAttack = 0;

float alphaValue = 0;       // 透明度初始值
float alphaIncrement = 1.5;   // 每次更新的透明度增量
boolean fadingIn = true;  // 確定是淡入還是淡出
boolean isTransition = true;
int cntLevel = 1;
int cntTransition = 0;

float playerDamageMultiplier = 2.0;
float enemyDamageMultiplier = 1.0;

void drawBullet() {
  if (shooting) {
    moveBullet();
    if(targetIndex==1){fill(#6DE073);}
    if(targetIndex==2){fill(#FF9B76);}
    if(targetIndex==3){fill(#64E6FF);}
    //fill(0);
    ellipse(bulletX, bulletY, 20, 20);//draw bullet
  }
  if (exploding) {
      explodeX = bulletX; explodeY = bulletY; 
      drawExplode(explodeX,explodeY);
  }
}

void moveBullet() {
  float dx = targetX - bulletX;
  float dy = targetY - bulletY;
  float distance = sqrt(dx*dx + dy*dy);
  
  if (distance > speed) {
    float ratio = speed / distance;
    bulletX += dx * ratio;
    bulletY += dy * ratio;
  } else {
    shooting = false;
    exploding = true;
  }
}

void drawExplode(float x, float y) {
  if(explode<120){
    explode+=10;
    int damageNum1 = (int)(count_grass * playerDamageMultiplier);
    int damageNum2 = (int)(count_fire * playerDamageMultiplier * swordMultiplier);
    int damageNum3 = (int)(count_water * playerDamageMultiplier);
    textSize(72);
    if(targetIndex==1){fill(#6DE073); enemyHp-=damageNum1;
      text("-"+damageNum1*10, 400, height/12);
      if(enemyHp <= 0) enemyHp = 0;
    }
    if(targetIndex==2){fill(#FF9B76); enemyHp-=damageNum2;
      text("-"+damageNum2*10, 400, height/12);
      if(enemyHp <= 0) enemyHp = 0;
    }
    if(targetIndex==3){fill(#64E6FF); enemyHp-=damageNum3;
      text("-"+damageNum3*10, 400, height/12);
      if(enemyHp <= 0) enemyHp = 0;
    }
    
    ellipse(x, y, explode, explode);
  }else{
    explode=20;
    exploding = false;
    targetIndex++;
    if (targetIndex == 1) {
      setTarget(width/12, 420);
    } else if (targetIndex == 2) {
      setTarget(width*5/12, 420);
    }else if (targetIndex == 3) {
      setTarget(width*9/12, 420);
    }else if(targetIndex == 4){
      targetIndex++;
      swordMultiplier = 1.0;
      count_water = 0;
      count_fire = 0;
      count_grass = 0;
      count_heart = 0;
    }
    if(targetIndex == 5) {
      enemyAttacking = true;
      if(enemyHp > 0) {
        enemyAttackSound.rewind();
        enemyAttackSound.play();
      }
    }
  }
}


void setTarget(int x, int y) {
  bulletX = x;
  bulletY = y;//start pos (x,y)
  
  targetX = width/2;
  targetY = height/5;//end pos on (width/2, height/4)
  
  playerAttackSound.rewind();
  playerAttackSound.play();
  
  shooting = true;
}

void enemyAttack() {
  if(enemyAttacking == true && enemyHp <= 0) {
    enemyDamageMultiplier += 0.5;
    if(enemyDamageMultiplier >= 10) {
      enemyDamageMultiplier = 9.9;
    }
    cntEnemy++;
    if(cntEnemy%4 == 0) {
      cntBackground++;
    }
    enemyAttacking = false;
    isTransition = true;
    fadingIn = true;
    cntLevel++;
    enemyFull_hp += 500;
    enemyHp = enemyFull_hp;
  }
  else if(enemyAttacking == true) {
    image(bloodPicture,0,height/2-120,width,height/2+120);
    image(enemyAttackPicture,0,height/2-120,width,height/2+120);
    hp -= enemyDamageMultiplier * 100;
    fill(255);
    text("-"+(enemyDamageMultiplier * 100)*10, 300, height/2 - 6);
    cntAttack++;
  }
  if(cntAttack == 10) {
    enemyAttacking = false;
    cntAttack = 0;
  }
}

void drawTransition() {
  noStroke();
  // 設定填充顏色為黑色，但透明度為 alphaValue
  fill(0, alphaValue);
  
  // 繪製矩形
  rect(0, 0, width, height);
  fill(255, alphaValue);
  textSize(72);
  textAlign(CENTER);
  text("第"+ cntLevel +"波", width/2, height/2);
  
  // 更新透明度值
  if (fadingIn) {
     alphaValue += alphaIncrement;
     if (alphaValue >= 255) {
       alphaValue = 255;
       fadingIn = false; // 開始淡出
     }
  } else {
    alphaValue -= alphaIncrement;
    if (alphaValue <= 0) {
      alphaValue = 0;
      isTransition = false;
    }
  }
}
