int hp = 10000;
int full_hp = 10000;
int circleOffset = 10;
int cntDropTime = 0;
int cntSwapTime = 0;
int[] dropCircleMatrix = new int[matrix[0].length];
float[][] dropCirclePos = new float[matrix[0].length][2]; // 新增的二維陣列，用來儲存圓形的位置
int isSwap = 0;
float tmpSwapCirclePosX1 = 0;
float tmpSwapCirclePosY1 = 0;
float tmpSwapCirclePosX2 = 0;
float tmpSwapCirclePosY2 = 0;

boolean checkZero() {
  boolean isZero = false;
  for(int i = 0; i < matrix.length; i++) {
    for(int j = 0; j < matrix[i].length; j++) {
      if(circleMatrix[i][j] == 0) {
        isZero = true;
        return isZero;
      }
    }
  }
  return isZero;
}

//掉落
void initialDropCircles() {
  generateHideRandomCircleMatrix();
  for (int j = 0; j < circleMatrix[0].length; j++) {
    int emptyCount = 0;
    for (int i = circleMatrix.length - 1; i >= 0; i--) {
      if (circleMatrix[i][j] == 0) {
        emptyCount++;
      }
      else if (emptyCount > 0) {
        circleMatrix[i + emptyCount][j] = circleMatrix[i][j];
        circleMatrix[i][j] = 0;
      }
    }
  }
  for (int i = 0; i < circleMatrix.length; i++) {
    for (int j = 0; j < circleMatrix[i].length; j++) {
      if (circleMatrix[i][j] == 0) {
        circleMatrix[i][j] = hideCircleMatrix[i][j];
      }
    }
  }
}

void dropCircles() {
  boolean isDropping = false;
  for(int j = 0; j < circleMatrix[0].length; j++) {
    for(int i = circleMatrix.length - 1; i >= 0; i--) {
      if(circleMatrix[i][j] == 0) {
        if(cntDropTime == 0) {
          dropCircleMatrix[j] = int(random(1, 5));
        }
        for(int cnt = i - 1; cnt >= 0; cnt--) {
          circlePos[cnt][j][1] += circleOffset;
        }
        dropCirclePos[j][1] += circleOffset;
        isDropping = true;
        break;
      }
    }
  }
  if(isDropping) {
    cntDropTime++;
  }
  if(cntDropTime == boxSize/circleOffset) {
    for(int j = 0; j < circleMatrix[0].length; j++) {
      for(int i = circleMatrix.length - 1; i >= 0; i--) {
        if(circleMatrix[i][j] == 0) {
          for(int cnt = i; cnt > 0; cnt--) {
            circleMatrix[cnt][j] = circleMatrix[cnt-1][j];
          }
          circleMatrix[0][j] = dropCircleMatrix[j];
          dropCircleMatrix[j] = 0;
          for(int cnt = i - 1; cnt >= 0; cnt--) {
            circlePos[cnt][j][1] -= boxSize;
          }
          dropCirclePos[j][1] -= boxSize;
          break;
        }
      }
    }
    cntDropTime = 0;
  }
}

void setDropCirclePos() {
  int startX = (width - matrix[0].length * boxSize) / 2;
  int startY = height - (matrix.length + 1) * boxSize - 20; // 20 是留白的距離
  
  for(int i = 0; i < matrix[0].length; i++) {
    dropCircleMatrix[i] = 0;
  }
  for(int i = 0; i < matrix[0].length; i++) {
    dropCirclePos[i][0] = startX + i * boxSize + boxSize / 2;
    dropCirclePos[i][1] = startY + boxSize / 2;
  }
}

void drawDropCircle() {
  imageMode(CENTER);
  for (int i = 0; i < matrix[0].length; i++) {
    int circleColor = dropCircleMatrix[i];
    switch (circleColor) {
      case 1:
        noFill();
        ellipse(dropCirclePos[i][0], dropCirclePos[i][1], circleRadius * 2, circleRadius * 2); // 繪製圓形
        image(waterImage, dropCirclePos[i][0], dropCirclePos[i][1], circleRadius*2, circleRadius*2);
        break;
      case 2:
        noFill();
        ellipse(dropCirclePos[i][0], dropCirclePos[i][1], circleRadius * 2, circleRadius * 2); // 繪製圓形
        image(fireImage, dropCirclePos[i][0], dropCirclePos[i][1], circleRadius*2, circleRadius*2);
        break;
      case 3:
        noFill();
        ellipse(dropCirclePos[i][0], dropCirclePos[i][1], circleRadius * 2, circleRadius * 2); // 繪製圓形
        image(grassImage, dropCirclePos[i][0], dropCirclePos[i][1], circleRadius*2.1, circleRadius*2.1);
        break;
      case 4:
        noFill();
        ellipse(dropCirclePos[i][0], dropCirclePos[i][1], circleRadius * 2, circleRadius * 2); // 繪製圓形
        image(heartImage, dropCirclePos[i][0], dropCirclePos[i][1], circleRadius*2.2, circleRadius*2.2);
        break;
      default:
        break;
    }
    noStroke();
  }
  imageMode(CORNER);
}

void drawHealthBar() {
  fill(150, 137, 134);
  rect(0,  height/2 - 20, 540,  30);
  fill(0, 0, 0);
  rect(5,  height/2 - 17.5, 530,  25);
  fill(255, 180, 174);
  rect(5,  height/2 - 17.5, 530 * ((float)hp / full_hp),  25);
  
  textAlign(RIGHT, CENTER);
  textSize(24);
  fill(255, 255, 255);
  String show_hp = Integer.toString((int)hp) + "/" + Integer.toString((int)full_hp);
  text(show_hp, 530, height/2 - 6);
  textAlign(CENTER, CENTER);
}

//交換圓圈位置
void swapCircles(int x1, int y1, int x2, int y2) {
  if(cntSwapTime == 0) {
    for(int i=0; i<3; i++) nowCoolDown_1[i] = (nowCoolDown_1[i] == 0) ? 0 : nowCoolDown_1[i] - 1;
    for(int i=0; i<3; i++) nowCoolDown_2[i] = (nowCoolDown_2[i] == 0) ? 0 : nowCoolDown_2[i] - 1;
    gameRound--;
    tmpSwapCirclePosX1 = circlePos[x1][y1][0];
    tmpSwapCirclePosY1 = circlePos[x1][y1][1];
    tmpSwapCirclePosX2 = circlePos[x2][y2][0];
    tmpSwapCirclePosY2 = circlePos[x2][y2][1];
  }
  swapCirclePos(x1, y1, x2, y2);
  if(cntSwapTime == boxSize/circleOffset) {
    int temp = circleMatrix[x1][y1];
    circleMatrix[x1][y1] = circleMatrix[x2][y2];
    circleMatrix[x2][y2] = temp;
    circlePos[x1][y1][0] = tmpSwapCirclePosX1;
    circlePos[x1][y1][1] = tmpSwapCirclePosY1;
    circlePos[x2][y2][0] = tmpSwapCirclePosX2;
    circlePos[x2][y2][1] = tmpSwapCirclePosY2;
    isSwap = 0;
    cntSwapTime = 0;
    selectedCircleX = -1;
    selectedCircleY = -1;
  }
}

void swapCirclePos(int x1, int y1, int x2, int y2) {
  if(x1 == x2) {
    if(y1 > y2) {
      circlePos[x1][y1][0] -= circleOffset;
      circlePos[x2][y2][0] += circleOffset;
      cntSwapTime++;
    }
    else if(y1 < y2) {
      circlePos[x1][y1][0] += circleOffset;
      circlePos[x2][y2][0] -= circleOffset;
      cntSwapTime++;
    }
  }
  else if(y1 == y2) {
    if(x1 > x2) {
      circlePos[x1][y1][1] -= circleOffset;
      circlePos[x2][y2][1] += circleOffset;
      cntSwapTime++;
    }
    else if(x1 < x2) {
      circlePos[x1][y1][1] += circleOffset;
      circlePos[x2][y2][1] -= circleOffset;
      cntSwapTime++;
    }
  }
}
