int[][] matrix = {
  {1, 0, 1, 0, 1, 0},
  {0, 1, 0, 1, 0, 1},
  {1, 0, 1, 0, 1, 0},
  {0, 1, 0, 1, 0, 1},
  {1, 0, 1, 0, 1, 0}
};

int[][] circleMatrix = new int[matrix.length][matrix[0].length]; // 新增的二維陣列，用來儲存圓形顏色
int[][] hideCircleMatrix = new int[matrix.length][matrix[0].length];
float[][][] circlePos = new float[matrix.length][matrix[0].length][2]; // 新增的三維陣列，用來儲存圓形的位置

int boxSize = 90;
int circleRadius = 32; // 圓形半徑
int selectedCircleX = -1; // 選擇移動的圓形 X 座標
int selectedCircleY = -1; // 選擇移動的圓形 Y 座標
int selectedCircleX2 = -1; // 選擇被交換的圓形 X 座標
int selectedCircleY2 = -1; // 選擇被交換的圓形 Y 座標
int cntTotalSwapTime = 0;

PImage waterImage, fireImage, grassImage, heartImage;

void crushSetUp() {
  waterImage = loadImage("冰.png");
  fireImage = loadImage("火.png");
  grassImage = loadImage("草.png");
  heartImage = loadImage("心.png");
  generateRandomCircleMatrix(); // 生成隨機的圓形顏色陣列
  updateCirclePositions(); // 更新圓形的位置
  while(checkMatches() != 0) {
    initialDropCircles();
  }
  setDropCirclePos();
}

void drawBoxes() {
  //background(255); // 設定背景為白色
  int startX = (width - matrix[0].length * boxSize) / 2;
  int startY = height - matrix.length * boxSize - 20;
  
  noStroke(); // 取消方塊的外框
  for (int i = 0; i < matrix.length; i++) {
    for (int j = 0; j < matrix[i].length; j++) {
      if (matrix[i][j] == 0) {
        fill(63, 41, 22); // 褐色
      } else {
        fill(44, 26, 14); // 深褐色
      }
      rect(startX + j * boxSize, startY + i * boxSize, boxSize, boxSize); // 繪製方塊
    }
  }
}

void drawCircles() {
  // 繪製圓形
  imageMode(CENTER);
  for (int i = 0; i < matrix.length; i++) {
    for (int j = 0; j < matrix[i].length; j++) {
      int circleColor = circleMatrix[i][j];
      if(selectedCircleX == i && selectedCircleY == j) {
        stroke(#D31ED1);
        strokeWeight(6);
      }
      switch (circleColor) {
        case 1:
          noFill();
          ellipse(circlePos[i][j][0], circlePos[i][j][1], circleRadius * 2, circleRadius * 2); // 繪製圓形
          image(waterImage, circlePos[i][j][0], circlePos[i][j][1], circleRadius*2, circleRadius*2);
          break;
        case 2:
          noFill();
          ellipse(circlePos[i][j][0], circlePos[i][j][1], circleRadius * 2, circleRadius * 2); // 繪製圓形
          image(fireImage, circlePos[i][j][0], circlePos[i][j][1], circleRadius*2, circleRadius*2);
          break;
        case 3:
          noFill();
          ellipse(circlePos[i][j][0], circlePos[i][j][1], circleRadius * 2, circleRadius * 2); // 繪製圓形
          image(grassImage, circlePos[i][j][0], circlePos[i][j][1], circleRadius*2.1, circleRadius*2.1);
          break;
        case 4:
          noFill();
          ellipse(circlePos[i][j][0], circlePos[i][j][1], circleRadius * 2, circleRadius * 2); // 繪製圓形
          image(heartImage, circlePos[i][j][0], circlePos[i][j][1], circleRadius*2.2, circleRadius*2.2);
          break;
        default:
          break;
      }
      noStroke();
    }
  }
  imageMode(CORNER);
}

// 生成隨機的圓形顏色陣列
void generateRandomCircleMatrix() {
  for (int i = 0; i < circleMatrix.length; i++) {
    for (int j = 0; j < circleMatrix[i].length; j++) {
      circleMatrix[i][j] = int(random(1, 5)); // 產生 1 到 4 之間的隨機數
    }
  }
}

void generateHideRandomCircleMatrix() {
  for (int i = 0; i < circleMatrix.length; i++) {
    for(int j = 0; j < circleMatrix[i].length; j++) {
      hideCircleMatrix[i][j] = int(random(1, 5)); // 產生 1 到 4 之間的隨機數
    }
  }
}

// 更新圓形的位置
void updateCirclePositions() {
  int startX = (width - matrix[0].length * boxSize) / 2;
  int startY = height - matrix.length * boxSize - 20; // 20 是留白的距離
  
  for (int i = 0; i < matrix.length; i++) {
    for (int j = 0; j < matrix[i].length; j++) {
      circlePos[i][j][0] = startX + j * boxSize + boxSize / 2; // 計算每個圓形的中心 x 座標
      circlePos[i][j][1] = startY + i * boxSize + boxSize / 2; // 計算每個圓形的中心 y 座標
    }
  }
}

// 檢查是否有三個一樣顏色的珠子連在一起，並將它們消除
int checkMatches() {
  int[][] tempMatrix = new int[circleMatrix.length][circleMatrix[0].length];
  int checkMatch = 0;

  for (int i = 0; i < circleMatrix.length; i++) {
    for (int j = 0; j < circleMatrix[i].length; j++) {
      tempMatrix[i][j] = circleMatrix[i][j];
    }
  }

  for (int i = 0; i < matrix.length; i++) {
    for (int j = 0; j < matrix[i].length; j++) {
      int circleColor = circleMatrix[i][j];
      if (circleColor != 0) {
        // 檢查水平方向
        if (j < matrix[i].length - 2 && circleMatrix[i][j + 1] == circleColor && circleMatrix[i][j + 2] == circleColor) {
          crushSound.rewind();
          crushSound.play();
          checkMatch = 1;//有消除
          tempMatrix[i][j] = 0;
          tempMatrix[i][j + 1] = 0;
          //tempMatrix[i][j + 2] = 0;
          int temp = 0;
          while(circleMatrix[i][j + 2 + temp] == circleColor)
          {
            tempMatrix[i][j + 2 + temp] = 0;
            temp++;
            if(j + 2 + temp > 5) break;
          }
          if(circleColor == 1) count_water += (2 + temp);
          if(circleColor == 2) count_fire += (2 + temp);
          if(circleColor == 3) count_grass += (2 + temp);
          if(circleColor == 4) count_heart += (2 + temp);
        }
        // 檢查垂直方向
        if (i < matrix.length - 2 && circleMatrix[i + 1][j] == circleColor && circleMatrix[i + 2][j] == circleColor) {
          crushSound.rewind();
          crushSound.play();
          checkMatch = 1;//有消除
          tempMatrix[i][j] = 0;
          tempMatrix[i + 1][j] = 0;
          //tempMatrix[i + 2][j] = 0;
          int temp = 0;
          while(circleMatrix[i + 2 + temp][j] == circleColor)
          {
            tempMatrix[i + 2 + temp][j] = 0;
            temp++;
            if(i + 2 + temp > 4) break;
          }
          if(circleColor == 1) count_water += (2 + temp);
          if(circleColor == 2) count_fire += (2 + temp);
          if(circleColor == 3) count_grass += (2 + temp);
          if(circleColor == 4) count_heart += (2 + temp);
        }
      }
    }
  }
  for (int i = 0; i < circleMatrix.length; i++) {
    for (int j = 0; j < circleMatrix[i].length; j++) {
      circleMatrix[i][j] = tempMatrix[i][j];
    }
  }
  return checkMatch;
}

void MousePressedInCrush(){
  for (int i = 0; i < circlePos.length; i++) {
    for (int j = 0; j < circlePos[i].length; j++) {
      if (dist(mouseX, mouseY, circlePos[i][j][0], circlePos[i][j][1]) <= circleRadius && selectedCircleX == -1 && selectedCircleY == -1) {
        selectedCircleX = i;
        selectedCircleY = j;
        break;
      }
      else if (dist(mouseX, mouseY, circlePos[i][j][0], circlePos[i][j][1]) <= circleRadius && selectedCircleX != -1 && selectedCircleY != -1) {
        if(abs(selectedCircleX - i) + abs(selectedCircleY - j) == 1) {
          selectedCircleX2 = i;
          selectedCircleY2 = j;
          isSwap = 1;
          cntTotalSwapTime++;
          break;
        }
        else {
          selectedCircleX = -1;
          selectedCircleY = -1;
          break;
        }
      }
    }
  }
}
