/* @pjs preload="mona.jpg"; */

int WIDTH = screen.width;
int HEIGHT = screen.height;
float SMOOTH = 0.3;
int RAND = 3;
int DTHRESH = 100;
int TTHRESH = 500;
int WAIT = 0;
int MAXV = 5;
int OVER = 10;
int centerX = WIDTH / 2;
int centerY = HEIGHT / 2;
color back = 255;
color base = (255, 255, 255, 255);
PImage img;
int count = 0;
int visits[][];
int dark[][];
Seeker particle;

void setup() {
	size(WIDTH, HEIGHT);
	frameRate(60);
  img = loadImage("mona.jpg");
  noStroke();
  fill(base);
  background(255,255,255);
  //image(img, 0, 0);
  visits = new int[WIDTH][HEIGHT];
  dark = new int[WIDTH][HEIGHT];
  particle = new Seeker((int)random(WIDTH), (int)random(HEIGHT), 10, 10000);
  for (int x = 0; x < WIDTH; x++) {
    for (int y = 0; y < HEIGHT; y++) {
      visits[x][y] = 0;
      dark[x][y] = (int)(brightness(img.get(x, y)) / 25);
    }
  }
}

void draw() {
  if (particle.isAlive()) {
    particle.update();
    particle.display();
  }
  else
    println("died");
}

class Seeker {
	PVector pos, ppos, target, vel, acc;
  float life, r;

  Seeker(int X, int Y, int _r_, float l) {
    pos = new PVector(X, Y);
    ppos = new PVector(X, Y);
    target = new PVector(random(WIDTH / 4, WIDTH / 4 * 3), random(HEIGHT / 4, HEIGHT / 4 * 3));
    vel = new PVector(0, 0);
    acc = new PVector(0, 0);
    r = _r_;
    life = l;
  }
  
  float getRadius() {
    boolean found = true;
    float mX = (pos.x > WIDTH - pos.x) ? WIDTH - pos.x : pos.x;
    float mY = (pos.y > HEIGHT - pos.y) ? HEIGHT - pos.y : pos.y;
    float m = (mX > mY) ? mY : mX;
    int count, pX, pY;
    for (int a = 1; a < m; a++) {
      count = 0;
      for (int i = 0; i < 360; i++) {
        float angle = i / 360 * PI;
        int x = (int)(cos(angle) * a + pos.x);
        int y = (int)(sin(angle) * a + pos.y);
        if (x != pX && y != pY && visits[x][y] >= dark[x][y])
          count++;
      }
      if (count > OVER)
        return (a - 1);
    }
    return (0);
  }

  void findTarget() {
    int m = getRadius();
    for (int a = (int)m / 2; a < m; a++) {
      for (int i = 0; i < 360; i++) {
        float angle = i / 360 * PI;
        int x = (int)(cos(angle) * a + pos.x);
        int y = (int)(sin(angle) * a + pos.y);
        if (random(1) > 0.5 && visits[x][y] < dark[x][y]) {
          target.set(x, y);
          return ;
        }
      }
    }
  }

  void update() {
    acc.set(PVector.sub(target, pos));
    acc.normalize();
    acc.mult(SMOOTH);
    vel.add(acc);
    vel.limit(MAXV);
    if (pos.x > WIDTH || pos.x < 0)
      vel.x *= -1;
    if (pos.y > HEIGHT || pos.y < 0)
      vel.y *= -1;
    pos.add(vel);
    if (pos.x != ppos.x && pos.y != ppos.y)
      visits[(int)pos.x][(int)pos.y]++;
    else
      ppos.set(pos.x, pos.y);
    if (dist(pos.x, pos.y, target.x, target.y) < DTHRESH)
      findTarget();
    life -= 0.1;
  } 

  void display() {
    fill(0);
    noStroke();
    ellipse(pos.x, pos.y, r, r);
  }

  boolean isAlive() { return (life > 0); }
}
