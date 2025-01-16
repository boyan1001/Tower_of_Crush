// 介面背景顏色
color bgColor = color(255, 255, 255);
// 背景圖片(new) 
PImage backgroundPicture;
// 按鈕資訊
int start_X, start_Y, setting_X, setting_Y, aboutus_X, aboutus_Y;     // 按鈕的位置
int buttonWidth = 200;    // 按鈕的寬度
int buttonHeight = 80;    // 按鈕的高度
color buttonColor = color(255, 255, 0);   // 按鈕的顏色
//int isButtonPressed = 0;  // 記錄按鈕是否被按下
int curScreen = 0;
PFont TCfont;

void startScreenSetUp() {
  TCfont = createFont("Cubic_11_1.100_R.ttf", 24);
  backgroundPicture = loadImage("background.jpg");  //background img(new)
  start_X = width/2 - buttonWidth/2;  // 計算按鈕的 x 座標
  start_Y = height/5*2 - buttonHeight/2;  // 計算按鈕的 y 座標
  setting_X = width/2 - buttonWidth/2;
  setting_Y = height/5*3 - buttonHeight/2;
  aboutus_X = width/2 - buttonWidth/2;
  aboutus_Y = height/5*4 - buttonHeight/2;
}

void drawStartScreen() {
  background(bgColor);  // 繪製背景
  tint(255,128);
  image(backgroundPicture,0,0,width,height);
  noTint();
  drawButton();  // 繪製按鈕
}

void drawButton() {
  noStroke();
  stroke(0);
  strokeWeight(2);
  fill(buttonColor);
  rect(start_X, start_Y, buttonWidth, buttonHeight);
  rect(setting_X, setting_Y, buttonWidth, buttonHeight);
  rect(aboutus_X, aboutus_Y, buttonWidth, buttonHeight);
  fill(0);
  textAlign(CENTER, CENTER);
  textFont(TCfont, 80);
  text("神魔 CRUSH", start_X + buttonWidth/2, 200);
  fill(255);
  text("神魔 CRUSH", start_X + buttonWidth/2 - 5, 200 - 5);
  fill(0);
  textFont(TCfont, 32);
  text("Start", start_X + buttonWidth/2, start_Y + buttonHeight/2);
  text("Setting", setting_X + buttonWidth/2, setting_Y + buttonHeight/2);
  text("About us", aboutus_X + buttonWidth/2, aboutus_Y + buttonHeight/2);
  textFont(TCfont, 32);
}

void mousePressedInStartScreen() {
  // 檢查滑鼠是否點擊在按鈕上
  if (mouseX > start_X && mouseX < start_X + buttonWidth &&
    mouseY > start_Y && mouseY < start_Y + buttonHeight) {
    curScreen = 1;
  }
  else if(mouseX > setting_X && mouseX < setting_X + buttonWidth &&
    mouseY > setting_Y && mouseY < setting_Y + buttonHeight) {
    curScreen = 2;
  }
  else if(mouseX > aboutus_X && mouseX < aboutus_X + buttonWidth &&
    mouseY > aboutus_Y && mouseY < aboutus_Y + buttonHeight) {
    curScreen = 3;
  }
}
