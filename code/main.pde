void setup() {
  size(540, 960);  // 設定介面視窗大小
  startScreenSetUp();
  settingSetUp();
  crushSetUp();
  chrSetUp();
  count_grass = 0;
  count_fire = 0;
  count_water = 0;
  count_heart = 0;
  InGameSetting_SetUp();
  settingGameBackground();
}

void draw() {
  switch(curScreen){
    case 0:
      drawStartScreen();
      break;
    case 1:
      if(bgm1.isPlaying()) {
        bgm1.close();
        bgm2.play();
      }
      if(isTransition == true) {
        drawTransition();
      }
      else if(hp <= 0 && enemyAttacking == false) {
        drawDeathScreen();
      }
      else {
        drawGameBackground();
        drawBoxes();
        drawHealthBar();
        drawCharacterBox();
        drawSettingBox();
        drawBullet();
        if(isSwap == 1) {
          swapCircles(selectedCircleX, selectedCircleY, selectedCircleX2, selectedCircleY2);
        }
        else if(checkZero() == false) {
          if(delay)
          {
            delay = false;
            delay(500);
          }
          if(checkMatches() == 0 && gameRound == 0) {// 檢查是否有三個一樣顏色的珠子連在一起
            targetIndex = 1; //reset target index
            setTarget(width/12, 420);
            hp = (hp + recover > 10000) ? 10000 : hp + recover;
            recover = 0;
            gameRound = 5;
          }
        }
        else if(checkZero()) {
          dropCircles();
          drawDropCircle();
          delay = true;
        }
        checkSkill();
        drawCircles();// 繪製圓形
        switch(isWindowOpen){
          case 1:
            chooseWindow(nowchr);
            break;
          case 2:
            GameSettingWindow();
            break;
          case 3:
            questionWinsow();
            break;
          case 4:
            resultWinsow();
            break;
        }
        if(isWindowOpen == 1){
          chooseWindow(nowchr);
        }
        if(isWindowOpen == 2){
          GameSettingWindow();
        }
        enemyAttack();
      }
      break;
    case 2://setting
      drawSetting();
      break;
    case 3://about us
      drawAboutUs();
      break;
  }
  if(!bgm1.isPlaying() && curScreen != 1) {
    bgm1.loop();
  }
  if(!bgm2.isPlaying() && curScreen == 1) {
    bgm2.loop();
  }
}

void mousePressed() {
  switch(curScreen) {
    case 0:
      mousePressedInStartScreen();
      break;
    case 1:
      switch(isWindowOpen){
        case 0:
          if(checkZero() == false) {
            if(gameRound != 0 && shooting == false) {
              MousePressedInCrush();
            }
            MousePressedInChr();
            if(hp <= 0 && enemyAttacking == false) {
              MousePressedInDeath();
            }
          }
          break;
        case 1:
          MousePressedInChrWindow();
          break;
        case 2:
          MousePressedInGameSettingWindow();
          break;
        case 3:
          MousePressedInQAWindow();
          break;
        default:
          MousePressedInDeath();
          break;
      }
      break;
    case 2:
      MousePressedInSetting();
      break;
    case 3:
      MousePressedInAboutUs();
      break;
  }
}
