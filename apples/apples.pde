int DISPLAY_WIDTH = 500;
int DISPLAY_HEIGHT = 500;

float pos_x = 10;
float POS_Y = 460;
int B_WIDTH = 80;
int B_HEIGHT = 50;
float B_SPEED = 10.0;
float B_THICKNESS = 2.0;

int MARGIN = 10;

int SPAWN_COOLDOWN = 40;

int score = 0;

int APPLES_NUM = 5;
int A_RADIUS = 30;
float a_speed = 2.0;
float A_ACCELERATION = 0.001;
float apples_x[] = new float[APPLES_NUM];
float apples_y[] = new float[APPLES_NUM];

void setup() {
  size(500, 500);
  background(0);
  for (int i = 0; i < APPLES_NUM; i++) {
    setApple(i);
  }
  stroke(255);
}

void keyPressed() {
  if (key == 'a' || key == 'A') {
    if (pos_x - MARGIN >= 0) {
      pos_x -= B_SPEED;
    }
  }
  if (key == 'd' || key == 'D') {
    if (pos_x + B_WIDTH + MARGIN <= DISPLAY_WIDTH) {
      pos_x += B_SPEED;
    }
  }
}

void setApple(int index) {
  apples_x[index] = random(MARGIN, DISPLAY_WIDTH - MARGIN);
  apples_y[index] = random(DISPLAY_HEIGHT * -1, 0);
}

void renderBasket() {
  float highPoint = POS_Y - B_HEIGHT;
  float leftPoint = pos_x + B_WIDTH - B_THICKNESS;
  
  rect(pos_x, POS_Y, B_WIDTH, B_THICKNESS);
  rect(pos_x, highPoint, B_THICKNESS, B_HEIGHT);
  rect(leftPoint, highPoint, B_THICKNESS, B_HEIGHT);
  
  rect(pos_x, highPoint + 20, B_WIDTH, 0.5);
  rect(pos_x, highPoint + 25, B_WIDTH, 0.5);
  rect(pos_x, highPoint + 30, B_WIDTH, 0.5);
  rect(pos_x, highPoint + 35, B_WIDTH, 0.5);
  rect(pos_x, highPoint + 40, B_WIDTH, 0.5);
  rect(pos_x, highPoint + 45, B_WIDTH, 0.5);
  rect(pos_x, highPoint + 50, B_WIDTH, 0.5);
}

void checkApple(int i) {
  ellipse(apples_x[i], apples_y[i], A_RADIUS, A_RADIUS);
  float leftPoint = apples_x[i] - A_RADIUS;
  float rightPoint = apples_x[i] + A_RADIUS;
  float downPoint = apples_y[i] + A_RADIUS;
  float scoreAreaHeight = 10;
  float scoreAreaWidth = 20;
  if (downPoint > POS_Y && downPoint < POS_Y + scoreAreaHeight) {
    if (leftPoint > (pos_x - scoreAreaWidth) && rightPoint < (pos_x + B_WIDTH + scoreAreaWidth)) {
      setApple(i);
      score += 1;
      println("Score: " + score);
    }
  }
  if (downPoint > 700) {
    setApple(i);
  }
  apples_y[i] += a_speed;
}

void draw() {
  background(0);
  for (int i = 0; i < APPLES_NUM; i++) {
    checkApple(i);
  }
  a_speed += A_ACCELERATION;
  
  renderBasket();
}
