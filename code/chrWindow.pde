int[] windowstatus = {0,0,0};
int window_x = 50, window_y = 240;
float window_width = 450, window_height = 460;
int windowBotton_x = window_x + 30;
int windowBotton_y = window_y + 60;
float windowBotton_width = window_width - 60;
float windowBotton_height = 130;
float exitBotton_x = windowBotton_x + windowBotton_width/2 - 60;
float exitBotton_y = windowBotton_y + 2*windowBotton_height + 40;
float exitBotton_width = 120;
float exitBotton_height = 50;
float dialog_x = window_x + window_width / 2;
float dialog_y = window_y + 15;

void chooseWindow(int nowchr){
    MouseOnChrbox();
   //繪製視窗
   fill(63, 41, 22); // 褐色
   stroke(44, 26, 14); // 深褐色a
   strokeWeight(10);
   rect( window_x, window_y, window_width, window_height);
   
   //列印技能選擇按鈕
   fill(#F29A51);
   strokeWeight(5);
   if(windowstatus[0] == 1 && nowCoolDown_1[nowchr] == 0){
      stroke(255);
   }else{
     stroke(#BF8C62);
   }
   rect(windowBotton_x, windowBotton_y, windowBotton_width, windowBotton_height);
   
   if(nowCoolDown_1[nowchr] != 0)
   {
     fill(0, 100);
     noStroke();
     rect(windowBotton_x - 5, windowBotton_y - 5, windowBotton_width + 10, windowBotton_height + 10);
   }
   
   fill(#F29A51);
   strokeWeight(5);
   if(windowstatus[1] == 1 && nowCoolDown_2[nowchr] == 0){
      stroke(255);
   }else{
     stroke(#BF8C62);
   }
   rect(windowBotton_x, windowBotton_y + windowBotton_height + 20, windowBotton_width, windowBotton_height);
   
   if(nowCoolDown_2[nowchr] != 0)
   {
     fill(0, 100);
     noStroke();
     rect(windowBotton_x - 5, windowBotton_y + windowBotton_height + 20 - 5, windowBotton_width + 10, windowBotton_height + 10);
   }

   fill(#45E0ED);
   if(windowstatus[2] == 1){
      stroke(255);
    }else{
      stroke(#37C0CB);
    }
   rect(exitBotton_x, exitBotton_y, exitBotton_width, exitBotton_height);
   noTint();
   
   //列印文字
   fill(255);
   textSize(24);
   textAlign(CENTER, TOP);
   text("請選擇" + chrName.get(nowchr) + "的技能", dialog_x, dialog_y);
   textAlign(CENTER, CENTER);
   text(chrAbility.get(2*nowchr) + "   CD " + nowCoolDown_1[nowchr]+ "/" + CoolDown_1[nowchr] + "\n正確選項: " + chrCorrect.get(2*nowchr) + "\n錯誤選項: " + chrWrong.get(2*nowchr),windowBotton_x + windowBotton_width / 2, windowBotton_y + windowBotton_height/2);
   text(chrAbility.get(2*nowchr + 1) + "   CD " + nowCoolDown_2[nowchr] + "/" + CoolDown_2[nowchr] + "\n正確選項: " + chrCorrect.get(2*nowchr+1) + "\n錯誤選項: " + chrWrong.get(2*nowchr+1),windowBotton_x + windowBotton_width / 2, windowBotton_y + windowBotton_height + 20 + windowBotton_height/2);
   fill(0);
   text("Back", exitBotton_x + exitBotton_width / 2, exitBotton_y + exitBotton_height / 2);
}

void MousePressedInChrWindow(){
  if(!mousePressed || time < 10 || isWindowOpen != 1){
    return;
  }
  if((mouseX >= windowBotton_x && mouseX <= windowBotton_x + windowBotton_width) && (mouseY >= windowBotton_y && mouseY <= windowBotton_y + windowBotton_height)){
    if(nowCoolDown_1[nowchr] == 0) {
      isWindowOpen = 3;
      chrAbilityStatus[nowchr*2] = 1;
      nowchr = -1;
    }
  }else if((mouseX >= windowBotton_x && mouseX <= windowBotton_x + windowBotton_width) && (mouseY >= windowBotton_y + windowBotton_height + 20 && mouseY <= windowBotton_y + windowBotton_height + 20 + windowBotton_height)){
    if(nowCoolDown_2[nowchr] == 0) {
      isWindowOpen = 3;
      chrAbilityStatus[nowchr*2 + 1] = 1;
      nowchr = -1;
    }
  }else if((mouseX >= exitBotton_x && mouseX <= exitBotton_x + exitBotton_width) && (mouseY >= exitBotton_y && mouseY <= exitBotton_y + exitBotton_height)){
    isWindowOpen = 0;
    nowchr = -1;
  }
  time = 0;
}
