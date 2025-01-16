int answer = -1;
float swordMultiplier = 1.0;
int nowCoolDown_1[] = {0, 0, 0};
int nowCoolDown_2[] = {0, 0, 0};
int CoolDown_1[] = {15, 25, 15};
int CoolDown_2[] = {20, 10, 20};


void checkSkill(){
  if(answer==-1){
      return;
  }
  if(chrAbilityStatus[0] == 1 && nowCoolDown_1[0] == 0){
    nowCoolDown_1[0] = CoolDown_1[0];
    grassSkill_1();
    chrAbilityStatus[0] = 0;
  }
  if(chrAbilityStatus[1] == 1 && nowCoolDown_2[0] == 0){
    nowCoolDown_2[0] = CoolDown_2[0];
    grassSkill_2();
    chrAbilityStatus[1] = 0;
  }
  if(chrAbilityStatus[2] == 1 && nowCoolDown_1[1] == 0){
    nowCoolDown_1[1] = CoolDown_1[1];
    fireSkill_1();
    chrAbilityStatus[2] = 0;
  }
  if(chrAbilityStatus[3] == 1 && nowCoolDown_2[1] == 0){
    nowCoolDown_2[1] = CoolDown_2[1];
    fireSkill_2();
    chrAbilityStatus[3] = 0;
  }
  if(chrAbilityStatus[4] == 1 && nowCoolDown_1[2] == 0){
    nowCoolDown_1[2] = CoolDown_1[2];
    waterSkill_1();
    delay = true;
    chrAbilityStatus[4] = 0;
  }
  if(chrAbilityStatus[5] == 1 && nowCoolDown_2[2] == 0){
    nowCoolDown_2[2] = CoolDown_2[2];
    waterSkill_2();
    chrAbilityStatus[5] = 0;
  }
  answer = -1;
}

void grassSkill_1() {
  if(answer == 0) {
    hp += 2000;
    if(hp > full_hp) {
      hp = full_hp;
    }
  }
  else if(answer == 1) {
    hp += 5000;
    if(hp > full_hp) {
      hp = full_hp;
    }
  }
}

void grassSkill_2() {
  if(answer == 0) {
    gameRound += 1;
  }
  else if(answer == 1) {
    gameRound += 3;
  }
}

void fireSkill_1() {
  if(answer == 0) {
    for(int i = 0; i < circleMatrix[2].length; i++) {
      if(circleMatrix[2][i] == 1) {
        count_water++;
      }
      else if(circleMatrix[2][i] == 2) {
        count_fire++;
      }
      else if(circleMatrix[2][i] == 3) {
        count_grass++;
      }
      circleMatrix[2][i] = 0;
    }
  }
  else if(answer == 1) {
    for(int i = 1; i < 4; i++) {
      for(int j = 0; j < circleMatrix[2].length; j++) {
        if(circleMatrix[i][j] == 1) {
          count_water++;
        }
        else if(circleMatrix[i][j] == 2) {
          count_fire++;
        }
        else if(circleMatrix[i][j] == 3) {
          count_grass++;
        }
        circleMatrix[i][j] = 0;
      }
    }
  }
}

void fireSkill_2() {
  if(answer == 0) {
    swordMultiplier = 1.25;
  }
  else if(answer == 1) {
    swordMultiplier = 1.5;
  }
}

void waterSkill_1()
{
  if(answer == 1)
  {
    for(int i=0; i<5; i++) for(int j=0; j<6; j++) if(circleMatrix[i][j] == 4) circleMatrix[i][j] = 1;
  }
  else
  {
    int temp = 0;
    for(int i=0; i<5; i++) for(int j=0; j<6; j++) if(circleMatrix[i][j] == 4) temp++;
    temp /= 2;
    for(int i=0; i<5 && temp != 0; i++)
    {
      for(int j=0; j<6; j++)
      {
        if(circleMatrix[i][j] == 4)
        {
          circleMatrix[i][j] = 1;
          temp--;
          break;
        }
      }
    }
  }
}

void waterSkill_2()
{
  if(answer == 1)
  {
    for(int i=0; i<5; i++)
    {
      for(int j=0; j<6; j++)
      {
        if(circleMatrix[i][j] == 1)
        {
          circleMatrix[i][j] = 0;
          count_water++;
        }
      }
    }
  }
  else
  {
    int temp = 0;
    for(int i=0; i<5; i++) for(int j=0; j<6; j++) if(circleMatrix[i][j] == 1) temp++;
    temp /= 2;
    for(int i=0; i<5 && temp != 0; i++)
    {
      for(int j=0; j<6; j++)
      {
        if(circleMatrix[i][j] == 1)
        {
          circleMatrix[i][j] = 0;
          count_water++;
          temp--;
          break;
        }
      }
    }
  }
}
