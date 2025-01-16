int optionBotton_x = 50 + 30 + 30;
int optionBotton_y = 250 + 50 + 80;
int optionBotton_width = 390 - 50;
int optionBotton_height = 60;
int qi_decide = 0;
int question_index;
int[] optionStatus = {0,0,0,0};
StringList options;
int question_length = 0;
float question_x = 50 + 450 / 2;
float question_y = 240 + 15;
int player_choose = 0;
int question_answer = 0;

void questionWinsow(){
  MouseOnQAWindow();
  //setup
   if(qi_decide == 0){
      question_index = int(random(284.1));
      qi_decide = 1;
   }
   String question = questions[question_index][0];
   question_answer = Answers[question_index];
   options = new StringList();
   for(int i = 1;i < 5;i++){
       options.append(questions[question_index][i]);
   }
   
   //繪製視窗
   fill(63, 41, 22); // 褐色
   stroke(44, 26, 14); // 深褐色a
   strokeWeight(10);
   rect( window_x, window_y, window_width, window_height);
   
   //列印題目
   question_length = question.length();
   println(question_length);
   fill(255);
   textSize(24);
   textAlign(CENTER, TOP);
   String[] question_list = split(question, " ");
   
   for(int i = 0;i < question_list.length;i++){
     text(question_list[i], question_x, question_y + 30*i);
   }
   
   //列印技能選擇按鈕
   for(int i = 0;i < 4;i++){
     //繪製按鈕
     fill(#F29A51);
     strokeWeight(5);
     if(optionStatus[i] == 1){
       stroke(255);
     }else{
       stroke(#BF8C62);
     }
     rect(optionBotton_x, optionBotton_y + (optionBotton_height + 20)*i, optionBotton_width, optionBotton_height);
     //列印字體
     textAlign(CENTER, CENTER);
     fill(255);
     textSize(24);
     text(options.get(i),optionBotton_x + optionBotton_width / 2, optionBotton_y + (optionBotton_height + 20)*i + optionBotton_height/2);
   }
 }
 
void MouseOnQAWindow(){
  //初始化
  for(int i = 0;i < 4; i++){
    optionStatus[i] = 0;
  }
  
  //判斷數標位置
  if(isWindowOpen != 3){
    return;
  }
  
  for(int i = 0;i < 4;i++){
    if((mouseX >= optionBotton_x && mouseX <= optionBotton_x + optionBotton_width) && (mouseY >= optionBotton_y + (optionBotton_height + 20)*i && mouseY <= optionBotton_y + (optionBotton_height + 20)*i + optionBotton_height)){
      optionStatus[i] = 1;
      break;
    } 
  }
}

void MousePressedInQAWindow(){
  if(!mousePressed || time < 10 || isWindowOpen != 3){
    return;
  }
  for(int i = 0;i < 4;i++){
    if((mouseX >= optionBotton_x && mouseX <= optionBotton_x + optionBotton_width) && (mouseY >= optionBotton_y + (optionBotton_height + 20)*i && mouseY <= optionBotton_y + (optionBotton_height + 20)*i + optionBotton_height)){
      optionStatus[i] = 1;
      player_choose = i+1;
      isWindowOpen = 4;
      break;
    } 
  }
  time = 0;
}
