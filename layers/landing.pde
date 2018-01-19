/* @pjs preload="yosemite.jpg"; */

ArrayList<Seeker> seekers = new ArrayList<Seeker>();
ArrayList<Seeker> spawns = new ArrayList<Seeker>();
int WIDTH = screen.width;
int HEIGHT = screen.height;
float SMOOTH = 0.0005;
int RAND = 0.5;
int DTHRESH = 1;
int WAIT = 0;
int OFF = 400;
int centerX = WIDTH / 2;
int centerY = HEIGHT / 2;
int stage = 0;
color back = 255;
color base = (255, 255, 255, 255);
PImage img;
int count = 0;
PVector[][] directions;

void setup() {
	size(WIDTH, HEIGHT);
	frameRate(60);
  img = loadImage("yosemite.jpg");
  noStroke();
  fill(base);
  background(255,255,255);
  //image(img, 0, 0);
  directions = new PVector[WIDTH][HEIGHT];
  for (int y = 0; y < HEIGHT; y++) for (int x = 0; x < WIDTH; x++) directions[x][y] = new PVector(cos((x + y * WIDTH) * 0.5) * 20, sin((x + y * WIDTH) * 0.5) * 20);
}

void draw() {
  if (count < 300)
    seekers.add(new Seeker((int)random(OFF, WIDTH - OFF), (int)random(OFF, HEIGHT - OFF), 200, random(5) + 5));
  else if (count < 500) {}
  else if (count < 1500)
    seekers.add(new Seeker((int)random(OFF, WIDTH - OFF), (int)random(OFF, HEIGHT - OFF), 75, random(5) + 5));
  else if (count < 1700) {}
  else if (count < 3200)
    seekers.add(new Seeker((int)random(OFF, WIDTH - OFF), (int)random(OFF, HEIGHT - OFF), 25, random(5) + 5));
  else if (count < 3500) {}
  else if (count < 5500)
    seekers.add(new Seeker((int)random(OFF, WIDTH - OFF), (int)random(OFF, HEIGHT - OFF), 10, random(5) + 5));
  else if (count < 8500)
    seekers.add(new Seeker((int)random(OFF, WIDTH - OFF), (int)random(OFF, HEIGHT - OFF), 5, random(5) + 5));
    

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
	PVector pos;
  float life, r, grow;

  Seeker(int X, int Y, int _r_, float l) {
    pos = new PVector(X, Y);
    r = _r_;
    grow = r / 100;
    life = l;
  }
  
  void update() {
    r += grow;
    life -= 0.1;
    if (pos.x >= 0 && pos.x <= WIDTH && pos.y >= 0 && pos.y <= HEIGHT)
      pos.add(directions[(int)pos.x][(int)pos.y]);
  } 

  void display() {
    fill((color)img.get((int)pos.x, (int)pos.y));
    ellipse(pos.x, pos.y, r, r);
  }

  boolean isAlive() { return (life > 0); }
}
