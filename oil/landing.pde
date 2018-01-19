/* @pjs preload="wave.jpg"; */

ArrayList<Seeker> seekers = new ArrayList<Seeker>();
int WIDTH = screen.width;
int HEIGHT = screen.height;
int SRCHO = 15;
int SRCHI = 5;
int SMOOTH = 0.1;
int RAND = 0;
int BTHRESH = 5;
int DTHRESH = 1;
int LIFE = 3;
int centerX = WIDTH / 2;
int centerY = HEIGHT / 2;
int count = 0;
color back = 255;
color base = (255, 255, 255, 0);
PImage img;

void setup() {
	size(WIDTH, HEIGHT);
	frameRate(60);
  img = loadImage("wave.jpg");
  noStroke();
  fill(base);
  //image(img, 0, 0);
}

void draw() {
  if (count < 800) {
    LIFE = 0.01;
    seekers.add(new Seeker((int)random(WIDTH), (int)random(HEIGHT), 100, 300));
  }
  else if (count < 1400) {
    LIFE = 3;
    seekers.add(new Seeker((int)random(WIDTH), (int)random(HEIGHT), 300, 200));
  }
  else if (count < 3400) {
    LIFE = 0.01;
    seekers.add(new Seeker((int)random(WIDTH), (int)random(HEIGHT), 150, 100));
  }
  else if (count < 4600) {
    LIFE = 3;
    seekers.add(new Seeker((int)random(WIDTH), (int)random(HEIGHT), 100, 80));
  }
  else if (count < 6600) {
    LIFE = 3;
    seekers.add(new Seeker((int)random(WIDTH), (int)random(HEIGHT), 80, 30));
  }
  else if (count < 14000) {
    LIFE = 3;
    seekers.add(new Seeker((int)random(WIDTH), (int)random(HEIGHT), 60, 20));
  }
  else if (count < 25800) {
    LIFE = 4;
    BTHRESH = 5;
    seekers.add(new Seeker((int)random(WIDTH), (int)random(HEIGHT), 40, 10));
  }


  for (int i = 0; i < seekers.size(); i++) {
    Seeker s = seekers.get(i);
    if (s.isAlive()) {
      s.update();
      s.display();
    }
    else 
      seekers.remove(i);
  }
  count++;
}

class Seeker {
	PVector pos, vel, target, rand;
  int bright, thresh;
  float life, r;
  color og;

  Seeker(int X, int Y, int t, int mR) {
    pos = new PVector(X, Y);
    vel = new PVector(0, 0);
    rand = new PVector(0, 0);
    target = new PVector(0, 0);
    bright = brightness(img.get(X, Y));
    og = (color)img.get(X, Y);
    //life = (int)(230 / bright);
    //life = (life > 6) ? 6 : life;
    life = LIFE;
    if (life != 0)
      life = findTarget();
    thresh = t;
    r = getRadius();
    r = (mR > r) ? mR : r;
  }
  
  float findTarget() {
    for (int x = ((pos.x - SRCHO > 0) ? pos.x - SRCHO : 0); x < ((pos.x + SRCHO < WIDTH) ? pos.x + SRCHO : WIDTH); x++) {
      for (int y = ((pos.y - SRCHO > 0) ? pos.y - SRCHO : 0); y < ((pos.y + SRCHO < HEIGHT) ? pos.y + SRCHO : HEIGHT); y++) {
        if (dist(red(og), green(og), blue(og), red(img.get((int)x, (int)y)), green(img.get((int)x, (int)y)), blue(img.get((int)x, (int)y))) < BTHRESH) {
          if (random(0, 1) > 0.9 && dist(x, y, pos.x, pos.y) > SRCHI) {
            target.set(x, y);
            return (life);
          }
        }
      }
    }
    return (0);
  }

  float getRadius() {
    boolean found = true;
    float mX = (pos.x > WIDTH - pos.x) ? WIDTH - pos.x : pos.x;
    float mY = (pos.y > HEIGHT - pos.y) ? HEIGHT - pos.y: pos.y;
    float m = (mX > mY) ? mY : mX;

    for (int a = 1; a < m; a++) {
      for (int i = 0; i <= 360; i++) {
       float angle = i / 360 * PI;
       float x = cos(angle) * a + pos.x;
       float y = sin(angle) * a + pos.y;
        if (!(dist(red(og), green(og), blue(og), red(img.get((int)x, (int)y)), green(img.get((int)x, (int)y)), blue(img.get((int)x, (int)y))) < thresh))
          found = false;
      }
      if (!found) {
        return (a - 1);
      }
    }
  }

  void update() {
    vel.set(PVector.mult(PVector.sub(target, pos), SMOOTH));
    rand.set(random(-RAND, RAND), random(-RAND, RAND));
    pos.add(vel);
    pos.add(rand);
    if (dist(pos.x, pos.y, target.x, target.y) < DTHRESH)
      life = findTarget();
    life -= 0.01;
    r -= r/300;
  }

  void display() { 
    fill(og);
    ellipse(pos.x, pos.y, r, r);
  }

  boolean isAlive() { return (life > 0); }
}
