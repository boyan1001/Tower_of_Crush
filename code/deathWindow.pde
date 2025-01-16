void drawDeathScreen(){
  fill(63, 41, 22); // 褐色
  stroke(44, 26, 14); // 深褐色a
  strokeWeight(10);
  rect(0,0,width,height);
  
   fill(#F29A51);
   strokeWeight(5);
   stroke(#BF8C62);
   rectMode(CENTER);
   rect(width/2, height/2, 450, 800);
   fill(#45E0ED);
   stroke(#37C0CB);
    
   
   rect(width/2, height*5/6, 120, 50);
   imageMode(CENTER);
   if(cntEnemy == 0) image(failure, width/2, height/2+50, 450, 400);
   else if(cntEnemy <= 5) image(endPicture1, width/2, height/2+50, 450, 300);
   else if(cntEnemy <= 10) image(endPicture2, width/2, height/2+50, 450, 300);
   else if(cntEnemy <= 15) image(endPicture3, width/2, height/2+50, 450, 300);
   else if(cntEnemy <= 20) image(endPicture4, width/2, height/2+50, 450, 300);
   rectMode(CORNER);
   imageMode(CORNER);
   noTint();
   
   //列印文字
   fill(255);
   textSize(48);
   textAlign(CENTER, TOP);
   text("YOU DIED\nYou survived " + cntEnemy + " round\n", width/2, height/5);
   textAlign(CENTER, CENTER);
   textSize(24);
   fill(0);
   text("Back",width/2, height*5/6);
}

void MousePressedInDeath() {
  if(mouseX >= (width/2-60) && mouseX <= (width/2+60) && mouseY >= (height*5/6-25) && mouseY <= (height*5/6+25)) {
    bgm2.close();
    bgm1 = minim.loadFile("yourassisweak.wav");
    bgm1.play();
    bgm2 = minim.loadFile("megalovania.wav");
    full_hp = 10000;
    hp = full_hp;
    enemyFull_hp = 1000;
    enemyHp = enemyFull_hp;
    cntLevel = 1;
    cntEnemy = 0;
    cntBackground = 0;
    curScreen = 0;
  }
}
