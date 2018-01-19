ArrayList<Point> points = new ArrayList<Point>();
int WIDTH = screen.width;
int HEIGHT = screen.height;
int centerX = WIDTH / 2;
int centerY = HEIGHT / 2;
int BALLS = 300;
int DRAW = 125;
int REPEL = 150;
int STOP = 0;
int thing = 0;
float TOWARDS = 0.01;
float BACK = 0.002;
int count = 0;
float velocity = 0;
color base = color(255,255,255, 10);
color back = color(0,0,0);

void setup() {
  size(WIDTH, HEIGHT);
  frameRate(30);
  for (int i; i < BALLS; i++) {
    int angle = random(TWO_PI);
    int mini = (WIDTH > HEIGHT) ? HEIGHT : WIDTH;
    mini = random(mini / 10 * 1, mini / 10 * 4);
    points.add(new Point(cos(angle) * mini + WIDTH / 2, sin(angle) * mini + HEIGHT / 2,
          10, centerX, centerY));
    /*
    points.add(new Point(random(WIDTH / 100 * 49, WIDTH / 100 * 51),
          random(HEIGHT / 100 * 49, HEIGHT / 100 * 51),
          10, centerX, centerY));
          */
  }
}

void draw() {
  background(back);
  if (count < 50)
    REPEL -= 1.5;
  if (count < 1000) {
    for (int i = 0; i < points.size(); i++) {
      Point cur = points.get(i);
      if (count > STOP || thing == 0)
        cur.move(TOWARDS);
      //else
      //  cur.away(0.01);
      stroke(255,255,255);
      for (int j = i + 1; j < points.size(); j++) {
        Point check = points.get(j);
        int distance = dist(cur.X, cur.Y, check.X, check.Y);
        if (distance < DRAW)
          line(cur.X, cur.Y, check.X, check.Y);
        if (distance < REPEL && (count > STOP || thing == 0)) {
          cur.move(-TOWARDS);
          check.move(BACK);
        }
      }
      cur.display();
    }
    if (count < 500)
      velocity += 0.01/500;
    if (TOWARDS < 1)
      TOWARDS += velocity;
    else if (TOWARDS >= 1) {
      reset();
      thing++;
    }
  }
  count++;
}

void reset() {
  //points = new ArrayList<Point>();
  //velocity = 0;
  count = 0;
  TOWARDS = 0.01;
  int mini = (WIDTH > HEIGHT) ? HEIGHT : WIDTH;
  velocity = 0;
  REPEL = 150;
  /*
  for (int i; i < BALLS; i++) {
    int angle = random(TWO_PI);
    int mini = (WIDTH > HEIGHT) ? HEIGHT : WIDTH;
    mini = random(mini/4, mini/3 * 2);
    points.add(new Point(cos(angle) * mini + WIDTH / 2, sin(angle) * mini + HEIGHT / 2,
          10, centerX, centerY));
  }
  velocity = -0.1;
  */
}

/*
void mouseClicked() {
  reset();
}
*/

class Point {
  float X, Y;
  float cX, cY;
  int r;
  int mini = (WIDTH > HEIGHT) ? HEIGHT : WIDTH;

  Point(float X, float Y, float r, float cX, float cY) {
    this.X = X;
    this.Y = Y;
    this.cX = cX;
    this.cY = cY;
    this.r = r;
  }

  void move(float scl) {
    X += (cX - X) * scl;
    Y += (cY - Y) * scl;
  }

  void away(float scl) {
   // alert(mini / 2 - (cX - X) * scl);
    X += (mini / (abs(cX - X) + 0.0001)) * scl;
    Y += (mini / (abs(cY - Y) + 0.0001)) * scl;
  }

  void display() {
    fill(base);
    noStroke();
    ellipse(X, Y, r, r);
  }
}
