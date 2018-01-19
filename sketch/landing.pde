/* @pjs preload=stars.jpg"; */

ArrayList<Seeker> seekers = new ArrayList<Seeker>();
int WIDTH = screen.width;
int HEIGHT = screen.height;
float SMOOTH = 0.0008;
int RAND = 1;
int DTHRESH = 5;
int WAIT = 1;
int centerX = WIDTH / 2;
int centerY = HEIGHT / 2;
int stage = 0;
color back = 255;
color base = (255, 255, 255, 255);
PImage img;
int count = -100;
int INC = 4;

void setup() {
	size(WIDTH, HEIGHT);
	frameRate(60);
  img = loadImage("stars.jpg");
  noStroke();
  fill(base);
  background(base);
  //image(img, 0, 0);
}

void draw() {
  if (count == 0) {
   for (int i = INC / 2; i < WIDTH * 1.5; i+= INC)
    seekers.add((random(1) > 0.5) ? new Seeker(i, 0, i - HEIGHT, HEIGHT, 5, 2, random(WAIT)) : new Seeker(i - HEIGHT, HEIGHT, i, 0, 3, 2, random(WAIT)));
   for (int i = INC / 2; i < WIDTH * 1.5; i+= INC)
    seekers.add((random(1) > 0.5) ? new Seeker(i, 0, i - HEIGHT, HEIGHT, 4, 2, random(WAIT)) : new Seeker(i - HEIGHT, HEIGHT, i, 0, 3, 2, random(WAIT)));
   for (int i = INC / 2; i < HEIGHT; i += INC)
    seekers.add((random(1) > 0.5) ? new Seeker(0, i, WIDTH, i, 1, 2, random(WAIT)) : new Seeker(WIDTH, i, 0, i, 1, 2, random(WAIT)));
   for (int i = INC / 2; i < HEIGHT; i += INC)
    seekers.add((random(1) > 0.5) ? new Seeker(0, i, WIDTH, i, 2, 2, random(WAIT)) : new Seeker(WIDTH, i, 0, i, 1, 2, random(WAIT)));
  }
  if (count == 1500) {
   for (int i = WIDTH + INC / 2; i > WIDTH / -2; i -= INC)
      seekers.add((random(1) > 0.5) ? new Seeker(i, 0, i  + HEIGHT, HEIGHT, 7, 2, random(WAIT)) : new Seeker(i + HEIGHT, HEIGHT, i, 0, 4, 2, random(WAIT)));
   for (int i = WIDTH + INC / 2; i > WIDTH / -2; i -= INC)
      seekers.add((random(1) > 0.5) ? new Seeker(i, 0, i  + HEIGHT, HEIGHT, 6, 2, random(WAIT)) : new Seeker(i + HEIGHT, HEIGHT, i, 0, 4, 2, random(WAIT)));
   for (int i = INC / 2; i < WIDTH; i += INC)
    seekers.add((random(1) > 0.5) ? new Seeker(i, 0, i, HEIGHT, 3, 2, random(WAIT)) : new Seeker(i, HEIGHT, i, 0, 2, 2, random(WAIT)));
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
  float life, r, start;
  int bright;

  Seeker(int X, int Y, int tX, int tY, int b, int _r_, float s) {
    pos = new PVector(X, Y);
    vel = new PVector(0, 0);
    rand = new PVector(0, 0);
    target = new PVector(tX, tY);
    vel.set(PVector.mult(PVector.sub(target, pos), SMOOTH));
    r = _r_;
    bright = b;
    start = s;
    life = 1;
  }
  
  void update() {
    if (start < 0) {
      rand.set(random(-RAND, RAND), random(-RAND, RAND));
      pos.add(vel);
      pos.add(rand);
    }
    else
      start -= 0.01;
    if (dist(pos.x, pos.y, target.x, target.y) < DTHRESH)
      life = 0;
    if (brightness(img.get((int)pos.x, (int)pos.y)) > (255 / 8)  * bright + (int)random(30))
      fill (255,255,255, 0);
    else
      fill(0, 0, 0, 180);
  }

  void display() { 
    ellipse(pos.x, pos.y, r, r);
  }

  boolean isAlive() { return (life == 1); }
}
