int timeRW = 0;
void resultWinsow(){
  //setup
   if(qi_decide == 0){
      question_index = int(random(281.1));
      qi_decide = 1;
   }
   String question = questions[question_index][0];
   question_answer = Answers[question_index];
   println(question_answer);
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
     if((i+1) == player_choose){
       if(player_choose == question_answer){
         fill(#31FF40); //綠色實心
         stroke(#2DCB49); //綠色框框
       }else{
         fill(#FF315A); //紅色實心
         stroke(#C1292E); //紅色框框
       }
     }else{
       if((i+1) == question_answer){
         fill(#31FF40); //綠色實心
         stroke(#2DCB49); //綠色框框
       }else{
         stroke(#BF8C62);
       }
     }
     rect(optionBotton_x, optionBotton_y + (optionBotton_height + 20)*i, optionBotton_width, optionBotton_height);
     //列印字體
     textAlign(CENTER, CENTER);
     if((i+1) == player_choose){
       if(player_choose == question_answer){
         fill(0);
       }else{
         fill(255);
       }
     }else{
       if((i+1) == question_answer){
         fill(0);
       }else{
         fill(255);
       }
     }
     textSize(24);
     text(options.get(i),optionBotton_x + optionBotton_width / 2, optionBotton_y + (optionBotton_height + 20)*i + optionBotton_height/2);
   }
   if(timeRW < 100){
     timeRW++;
   }else{
     if(player_choose == question_answer){
       answer = 1;
     }else{
       answer = 0;
     }
     isWindowOpen = 0;
     timeRW = 0;
     qi_decide = 0;
   }
}
