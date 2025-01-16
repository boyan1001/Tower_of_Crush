static int ifbgm1 = 1;
static int ifGameMusic = 1;
color green = #74F593;
color red = #FF4350;
int bottonA_X = 250;
int bottonA_Y = 330;
int bottonmove = 100;

int count_grass = 0;
int count_fire = 0;
int count_water = 0;
int count_heart = 0;
int recover = 0;
int gameRound = 5;
boolean delay = false;

static int bgmtime = 0;
float vol = 0.5;
PFont Ufont; //英文字體(only for English)

import ddf.minim.*;
Minim minim;
AudioPlayer bgm1;
AudioPlayer bgm2;
AudioPlayer NocheatingSound;
AudioPlayer cheatingSound;
AudioPlayer crushSound;
AudioPlayer playerAttackSound;
AudioPlayer enemyAttackSound;

void settingSetUp() {
  Ufont = createFont("Ubuntu-Regular.ttf",32);
  minim = new Minim(this);
  bgm1 = minim.loadFile("yourassisweak.wav");
  bgm2 = minim.loadFile("megalovania.wav");
  cheatingSound = minim.loadFile("菜就多練.wav");
  NocheatingSound = minim.loadFile("以前是以前.wav");
  bgm1.loop();
  bgm1.setVolume(vol);
  crushSound = minim.loadFile("data/crush.wav");
  playerAttackSound = minim.loadFile("data/playerattack.wav");
  enemyAttackSound = minim.loadFile("data/enemyattack.wav");
}

void drawSetting(){
  background(255);
  tint(255,128);
  image(backgroundPicture,0,0,width,height);  //background
  noTint();
  fill(buttonColor);
  rect(aboutus_X, aboutus_Y, buttonWidth, buttonHeight); //button
  fill(255);
  noStroke();
  rect(aboutus_X, aboutus_Y-660,buttonWidth, buttonHeight);
  fill(0);
  textFont(TCfont, 32);
  textAlign(CENTER, TOP);
  text("音量控制",width/2,height/10);//the credi
  textAlign(CENTER, CENTER);
  textFont(Ufont, 32);
  text("Back", aboutus_X + buttonWidth/2, aboutus_Y + buttonHeight/2); //return text
  textFont(TCfont, 32);
  
  //音樂背景調整
  //選項文字
  text("背景音樂",150,350);
  text("遊戲音效",150,420);
  text("作弊模式",150,490);
  //BGM Button Draw
  stroke(0);
  strokeWeight(2);
  if(ifbgm1==1){
    fill(green);
  }else{
    fill(red);
  }
  rect(bottonA_X,bottonA_Y,150,40);
  
  //GameMusicButton Draw
  if(ifGameMusic==1){
    fill(green);
  }else{
    fill(red);
  }
  rect(GameSound_button_x, GameSound_button_y, 150, 40);
  
  //BGM Button ON/OFF
  fill(#D1D1D1);
  if(ifbgm1==1){
     rect(bottonA_X,bottonA_Y,50,40);
     fill(255);
     textFont(Ufont, 32);
     text("ON",bottonA_X + 100,bottonA_Y + 18);
  }else{
     rect(bottonA_X + bottonmove,bottonA_Y,50,40);
     fill(255);
     textFont(Ufont, 32);
     text("OFF",bottonA_X+50,bottonA_Y + 18);
  }
  
  //GameMusic Button ON/OFF
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
  
  //cheating button
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
}

//cheating button


void MousePressedInSetting(){
   if(mouseX > aboutus_X && mouseX < aboutus_X + buttonWidth &&
      mouseY > aboutus_Y && mouseY < aboutus_Y + buttonHeight) {
     curScreen = 0;
   }
   
   //bottonA
   if(mouseX > bottonA_X && mouseX < bottonA_X  + 150 &&
      mouseY > bottonA_Y  && mouseY < bottonA_Y  + 40) {
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
   
   //cheat button
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
}
