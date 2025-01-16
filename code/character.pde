StringList chrName, chrAbility, chrCorrect, chrWrong;

PImage greenchr_head, firechr_head, icechr_head; //三位角色頭像
float chrpicture_width = 90; //角色圖片邊長
float chrpicture_y = 960/2 - 110; //角色圖片y座標
int isWindowOpen = 0; //0:沒有 1:技能選擇框 2:setting框 3:問題框
int[] chrstatus = {0,0,0};
int[] chrAbilityStatus = {0,0,0,0,0,0}; //角色技能啟用狀態 0:關閉 1:啟用
int nowchr = -1;

int time = 0;

void chrSetUp(){ //角色初始設定
  //頭像設定
  greenchr_head = loadImage("麒麟(頭部).jpg");
  firechr_head = loadImage("火劍士(頭部).jpg");
  icechr_head = loadImage("冰or水女巫(頭部).jpg");
  //名字設定
  chrName = new StringList();
  chrName.append("麒麟");
  chrName.append("火劍士");
  chrName.append("水女巫");
  //技能設定
  chrAbility = new StringList();
  chrAbility.append("回血");
  chrAbility.append("增加回合");
  chrAbility.append("消一排");
  chrAbility.append("攻擊次數增加");
  chrAbility.append("轉特定顏色的珠");
  chrAbility.append("消特定顏色的珠");
  //正確結果
  chrCorrect = new StringList();
  chrCorrect.append("+5000hp");
  chrCorrect.append("增加3回合");
  chrCorrect.append("消除中間三個橫排");
  chrCorrect.append("火劍士攻擊力*1.5倍");
  chrCorrect.append("將所有心符石轉為水符石");
  chrCorrect.append("消除全部的水符石");
  //錯誤結果
  chrWrong = new StringList();
  chrWrong.append("+2000hp");
  chrWrong.append("增加1回合");
  chrWrong.append("消除中間一個橫排");
  chrWrong.append("火劍士攻擊力*1.25倍");
  chrWrong.append("將一半心符石轉為水符石");
  chrWrong.append("消除一半的水符石");
}

//判斷滑鼠是否在特定位置
void MouseOnChrbox(){
  //初始化
  for(int i = 0;i < 3; i++){
    chrstatus[i] = 0;
    windowstatus[i] = 0;
  }
  
  //判斷數標位置
  if(isWindowOpen == 0){
    if((mouseX >= 0 && mouseX <= chrpicture_width) && (mouseY >= chrpicture_y && mouseY <= chrpicture_y + chrpicture_width)){
      chrstatus[0] = 1;
    }else if((mouseX >= chrpicture_width*2 && mouseX <= chrpicture_width*3) && (mouseY >= chrpicture_y && mouseY <= chrpicture_y + chrpicture_width)){
      chrstatus[1] = 1;
    }else if((mouseX >= chrpicture_width*4 && mouseX <= chrpicture_width*5) && (mouseY >= chrpicture_y && mouseY <= chrpicture_y + chrpicture_width)){
      chrstatus[2] = 1;
    }
  }else{
    if((mouseX >= windowBotton_x && mouseX <= windowBotton_x + windowBotton_width) && (mouseY >= windowBotton_y && mouseY <= windowBotton_y + windowBotton_height)){
      windowstatus[0] = 1;
    }else if((mouseX >= windowBotton_x && mouseX <= windowBotton_x + windowBotton_width) && (mouseY >= windowBotton_y + windowBotton_height + 20 && mouseY <= windowBotton_y + windowBotton_height + 20 + windowBotton_height)){
      windowstatus[1] = 1;
    }else if((mouseX >= exitBotton_x && mouseX <= exitBotton_x + exitBotton_width) && (mouseY >= exitBotton_y && mouseY <= exitBotton_y + exitBotton_height)){
      windowstatus[2] = 1;
    }
  }
}

void drawCharacterBox(){
  
  MouseOnChrbox();
  
  //草系角色
  if(chrstatus[0] == 1){
    tint(#FFFFFF,128);
  }else{
    noTint();
  }
  fill(#6DE073);
  rect(0,chrpicture_y,90,90);
  if(nowCoolDown_1[0] != 0 && nowCoolDown_2[0] != 0)
  {
    fill(0, 100);
    rect(0,chrpicture_y,90,90);
  }
  image(greenchr_head, 5, chrpicture_y + 5, chrpicture_width - 10, chrpicture_width - 10);
  
  noFill();
  stroke(0);
  strokeWeight(5);
  rect(chrpicture_width + 2.5, chrpicture_y + 2.5, 85, 85);
  noStroke();
  
  fill(0);
  textSize(48);
  text(count_grass, chrpicture_width + 45, chrpicture_y + 45);
  
  //火系角色
  if(chrstatus[1] == 1){
    tint(#FFFFFF,128);
  }else{
    noTint();
  }
  fill(#FF9B76);
  rect(chrpicture_width*2,chrpicture_y,90,90);
  if(nowCoolDown_1[1] != 0 && nowCoolDown_2[1] != 0)
  {
    fill(0, 100);
    rect(chrpicture_width*2,chrpicture_y,90,90);
  }
  image(firechr_head, 5 + chrpicture_width*2, chrpicture_y + 5, chrpicture_width - 10, chrpicture_width - 10);
  
  noFill();
  stroke(0);
  strokeWeight(5);
  rect(chrpicture_width * 3 + 2.5, chrpicture_y + 2.5, 85, 85);
  noStroke();
  
  fill(0);
  textSize(48);
  text(count_fire, chrpicture_width * 3 + 45, chrpicture_y + 45);
  
  //冰(水)系角色
  if(chrstatus[2] == 1){
    tint(#FFFFFF,128);
  }else{
    noTint();
  }
  fill(#64E6FF);
  rect(chrpicture_width*4,chrpicture_y,90,90);
  if(nowCoolDown_1[2] != 0 && nowCoolDown_2[2] != 0)
  {
    fill(0, 100);
    rect(chrpicture_width*4,chrpicture_y,90,90);
  }
  image(icechr_head, 5 + chrpicture_width*4, chrpicture_y + 5, chrpicture_width - 10, chrpicture_width - 10);
  noTint();
  
  noFill();
  stroke(0);
  strokeWeight(5);
  rect(chrpicture_width * 5 + 2.5, chrpicture_y + 2.5, 85, 85);
  noStroke();
  
  fill(0);
  textSize(48);
  text(count_water, chrpicture_width * 5 + 45, chrpicture_y + 45);
  
  if(count_heart != 0)
  {
    fill(255, 255, 255);
    textSize(24);
    recover = 250 * count_heart;
    String recover_s = "+" + Integer.toString((int)recover);
    text(recover_s, chrpicture_width + 10, height / 2 - 6);
  }
  
  if(time < 10){
    time = time + 1;
  }
}

//判斷滑鼠是否有按按鈕
void MousePressedInChr(){
  if(!mousePressed || time < 10 || isWindowOpen != 0){
    return;
  }
  if((mouseX >= 0 && mouseX <= chrpicture_width) && (mouseY >= chrpicture_y && mouseY <= chrpicture_y + chrpicture_width)){
    isWindowOpen = 1;
    nowchr = 0;
  }else if((mouseX >= chrpicture_width*2 && mouseX <= chrpicture_width*3) && (mouseY >= chrpicture_y && mouseY <= chrpicture_y + chrpicture_width)){
    isWindowOpen = 1;
    nowchr = 1;
  }else if((mouseX >= chrpicture_width*4 && mouseX <= chrpicture_width*5) && (mouseY >= chrpicture_y && mouseY <= chrpicture_y + chrpicture_width)){
    isWindowOpen = 1;
    nowchr = 2;
  }
  time = 0;
}
