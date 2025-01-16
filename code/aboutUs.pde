void drawAboutUs(){
  background(255);
  tint(255,128);
  image(backgroundPicture,0,0,width,height);  //background
  noTint();
  fill(buttonColor);
  rect(aboutus_X, aboutus_Y, buttonWidth, buttonHeight); //button
  fill(0);
  textFont(TCfont, 32);
  textAlign(CENTER, TOP);
  text("神魔crush\n這是一個結合candy crush \n& 神魔之塔的遊戲\n\n魔王降臨這片大地。他為了統\n治世界，開始肆意破壞自然和\n摧毀村莊。為了停止大自然的\n悲泣三位勇士義無反顧的衝進\n了魔王的無盡軍勢。\n\n組長:陳柏諺\n組員:\n   李韋達 陳冠宏\n呂凱崴 伍駿宇 郝東彥",width/2,height/10);//the credit
  textAlign(CENTER, CENTER);
  text("Back", aboutus_X + buttonWidth/2, aboutus_Y + buttonHeight/2); //return text
}

void MousePressedInAboutUs(){
   if(mouseX > aboutus_X && mouseX < aboutus_X + buttonWidth &&
      mouseY > aboutus_Y && mouseY < aboutus_Y + buttonHeight) {
     curScreen = 0;
   }
}
