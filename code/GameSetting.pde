PImage InGameSetting;
float gamesetting_width = 75; // 設定按鈕邊長
//GameSetting座標
float gamesetting_x = 540 - 75;
float gamesetting_y = 0;
int isWindowOpenTemp = 0;

void InGameSetting_SetUp(){
  InGameSetting = loadImage("InGameSetting.png");
}

void drawSettingBox(){
  image(InGameSetting, gamesetting_x, gamesetting_y, gamesetting_width, gamesetting_width);
  MousePressedGameSetting();
  
}

void MousePressedGameSetting(){
  
  if(!mousePressed || isWindowOpen == 2 ){
    return;
  }
  isWindowOpenTemp = isWindowOpen;
  if((mouseX >= gamesetting_x && mouseX <= gamesetting_x + gamesetting_width) && (mouseY >= gamesetting_y && mouseY <= gamesetting_y + gamesetting_width)){
    isWindowOpen = 2;
  }
  time = 0;
}

int GameSettingWindow_x = 50, GameSettingWindow_y = 250;
float GameSettingWindow_width = 450, GameSettingWindow_height = 430;
int GameMusic_button_x = 250;
int GameMusic_button_y = 330;
int ButtonMove = 100;
int GameSound_button_x = 250;
int GameSound_button_y = 400;

int CheatingMode = 0;
int back_status = 0;
int back_to_title_status = 0;


void GameSettingWindow(){
    MouseOnInGameSettingWindow();
   //繪製視窗
   fill(63, 41, 22); // 褐色
   stroke(44, 26, 14); // 深褐色
   strokeWeight(10);
   rect( GameSettingWindow_x, GameSettingWindow_y, GameSettingWindow_width, GameSettingWindow_height); 
   
   
   
   
   //繪製返回按鈕
   fill(#45E0ED);
   
   if(back_status == 1){
      stroke(255);
    }else{
      stroke(#37C0CB);
    }
    strokeWeight(5);
   rect(exitBotton_x, exitBotton_y, exitBotton_width, exitBotton_height);
   noTint();
   
   fill(#45E0ED);
   
   if(back_to_title_status == 1){
      stroke(255);
    }else{
      stroke(#37C0CB);
    }
    strokeWeight(5);
   rect(exitBotton_x-25, exitBotton_y-70, exitBotton_width+50, exitBotton_height);
   noTint();
   
   //返回文字
   fill(0);
   textSize(24);
   textAlign(CENTER, CENTER);
   text("返回", exitBotton_x + exitBotton_width / 2, exitBotton_y + exitBotton_height / 2);
   text("返回標題", exitBotton_x + exitBotton_width / 2, exitBotton_y + exitBotton_height / 2 - 70);
   
   //設定視窗內選項文字
   fill(255);
   textSize(32);
   text("遊戲設定",exitBotton_x + exitBotton_width / 2,290);
   textSize(24);
   text("背景音樂",150,350);
   text("遊戲音效",150,420);
   text("作弊模式",150,490);
   
   //背景音樂按鈕繪製
   stroke(0);
   strokeWeight(2);
   if(ifbgm1==1){
    fill(green);
  }else{
    fill(red);
  }
  rect(GameMusic_button_x,GameMusic_button_y,150,40);
  fill(#D1D1D1);
  if(ifbgm1==1){
     rect(GameMusic_button_x,GameMusic_button_y,50,40);
     fill(255);
     textFont(Ufont, 32);
     text("ON",GameMusic_button_x + 100,GameMusic_button_y + 18);
  }else{
     rect(GameMusic_button_x + ButtonMove,GameMusic_button_y,50,40);
     fill(255);
     textFont(Ufont, 32);
     text("OFF",GameMusic_button_x + 50, GameMusic_button_y + 18);
  }
  //triangle(250,370,400,330,400,370);
  
  //遊戲音效按鈕繪製  
  stroke(0);
  strokeWeight(2);
  if(ifGameMusic==1){
    fill(green);
  }else{
    fill(red);
  }
  rect(GameSound_button_x, GameSound_button_y, 150, 40);
  fill(#D1D1D1);
  if(ifGameMusic == 1){
     rect(GameSound_button_x, GameSound_button_y, 50, 40);
     fill(255);
     textFont(Ufont, 32);
     text("ON", GameSound_button_x + 100, GameSound_button_y + 18);
  }else{
     rect(GameSound_button_x + bottonmove,GameSound_button_y,50,40);
     fill(255);
     textFont(Ufont, 32);
     text("OFF", GameSound_button_x + 50, GameSound_button_y + 18);
  }
  
  //作弊按鈕繪製
  stroke(0);
  strokeWeight(2);
  if(CheatingMode == 1){
    fill(green);
  }else{
    fill(red);
  }
  rect(GameSound_button_x, GameSound_button_y + 70, 150, 40);
  fill(#D1D1D1);
  if(CheatingMode == 1){
     rect(GameSound_button_x, GameSound_button_y + 70, 50, 40);
     fill(255);
     textFont(Ufont, 32);
     text("ON", GameSound_button_x + 100, GameSound_button_y + 70 + 18);
  }else{
     rect(GameSound_button_x + bottonmove,GameSound_button_y + 70,50,40);
     fill(255);
     textFont(Ufont, 32);
     text("OFF", GameSound_button_x + 50, GameSound_button_y + 70 + 18);
  }
  
  textFont(TCfont, 32);
  if(time < 10){
    time = time + 1;
  }
}

//在遊戲內設定視窗點擊
void MousePressedInGameSettingWindow(){
  
    if((mouseX >= exitBotton_x && mouseX <= exitBotton_x + exitBotton_width) && (mouseY >= exitBotton_y && mouseY <= exitBotton_y + exitBotton_height)){
       isWindowOpen = isWindowOpenTemp;
     }
  
    //遊戲內音樂設定
    if(mouseX > GameMusic_button_x && mouseX < GameMusic_button_x  + 150 &&
       mouseY > GameMusic_button_y  && mouseY < GameMusic_button_y  + 40) {
      if(ifbgm1 == 1){
      if((bgm1.isPlaying() && !bgm1.isMuted()) || (bgm2.isPlaying() && !bgm2.isMuted())){
         bgm1.mute();
         bgm2.mute();
       }
      ifbgm1 = 0;
       }else{
         if((bgm1.isPlaying() && bgm1.isMuted()) || (bgm2.isPlaying() && bgm2.isMuted())){
           bgm1.unmute();
           bgm2.unmute();
         }
         ifbgm1 = 1;
       }
     }
     
  //GameMusic button
   if(mouseX > GameSound_button_x && mouseX < GameSound_button_x + 150 &&
      mouseY > GameSound_button_y  && mouseY < GameSound_button_y  + 40) {
     if(ifGameMusic == 1){
       if(!crushSound.isMuted()){
         crushSound.mute();
         playerAttackSound.mute();
         enemyAttackSound.mute();
       }
       ifGameMusic = 0;
     }else{
       if(crushSound.isMuted()){
         crushSound.unmute();
         playerAttackSound.unmute();
         enemyAttackSound.unmute();
       }
       ifGameMusic = 1;
     }
   }
   
   //cheating button
   if(mouseX > GameSound_button_x && mouseX < GameSound_button_x + 150 &&
      mouseY > GameSound_button_y + 70  && mouseY < GameSound_button_y + 70 + 40) {
     if(CheatingMode == 1){
       NocheatingSound.rewind();
       NocheatingSound.play();
       crushSound = minim.loadFile("data/crush.wav");
       
       playerDamageMultiplier = 2.0;
       CoolDown_1[0] = 15;
       CoolDown_1[1] = 25;
       CoolDown_1[2] = 15;
       CoolDown_2[0] = 20;
       CoolDown_2[1] = 10;
       CoolDown_2[2] = 20;
       CheatingMode = 0;
     }else{
       cheatingSound.rewind();
       cheatingSound.play();
       crushSound = minim.loadFile("雞.wav");
       
       playerDamageMultiplier = 999999.0;
       CoolDown_1[0] = 0;
       CoolDown_1[1] = 0;
       CoolDown_1[2] = 0;
       CoolDown_2[0] = 0;
       CoolDown_2[1] = 0;
       CoolDown_2[2] = 0;
       CheatingMode = 1;
       }       
     }
   
   
   //back to title
   if((mouseX >= exitBotton_x-25 && mouseX <= exitBotton_x-25 + exitBotton_width+50) && (mouseY >= exitBotton_y-70 && mouseY <= exitBotton_y-70 + exitBotton_height)){
     curScreen = 0;
     isWindowOpen = 0;
     bgm2.pause();
     bgm1 = minim.loadFile("yourassisweak.wav");
     bgm1.mute();
     if(ifbgm1 == 1){
     bgm1.unmute();
     }
     
     //把start改成continue
     /*
     //start button
     noStroke();
     fill(buttonColor);
     rect(start_X, start_Y, buttonWidth, buttonHeight);
     //start 文字
     fill(0);
     textFont(TCfont, 32);
     textAlign(CENTER, CENTER);
     text("Continue", start_X + buttonWidth/2, start_Y + buttonHeight/2);
     */
   }
}

void MouseOnInGameSettingWindow(){
  if((mouseX >= exitBotton_x && mouseX <= exitBotton_x + exitBotton_width) && (mouseY >= exitBotton_y && mouseY <= exitBotton_y + exitBotton_height)){
       back_status = 1;
  }else{
      back_status = 0;
  }
  
  if((mouseX >= exitBotton_x-25 && mouseX <= exitBotton_x-25 + exitBotton_width+50) && (mouseY >= exitBotton_y-70 && mouseY <= exitBotton_y-70 + exitBotton_height)){
       back_to_title_status = 1;
  }else{
      back_to_title_status = 0;
  }
}
