int WIDTH = screen.width;
int HEIGHT = screen.height;
float p1, p2, p3;
//Point po1 = new Point();
//Point po2 = new Point();
//Point po3 = new Point();

void setup() {
	size(WIDTH, HEIGHT);
	frameRate(60);
  p1 = random(0, 360);
  while (p1 == 360) { p1 = random(0, 360); }
  p2 = random(0, 360);
  while (p2 == 360) { p2 = random(0, 360); }
  p3 = random(0, 360);
  while (p3 == 360) { p3 = random(0, 360); }
}

void draw() {
  background(255,255,255);
  fill(255);
  ellipse(WIDTH/2, HEIGHT/2, 1000, 1000);
  fill(0);
  /*
  po1.setCoors(p1);
  po2.setCoors(p2);
  po3.setCoors(p3);
  ellipse(po1.getX(), po1.getY(), 5, 5);
  ellipse(po2.getX(), po2.getY(), 5, 5);
  ellipse(po3.getX(), po3.getY(), 5, 5);
  line(po1.getX(), po1.getY(), po2.getX(), po2.getY());
  line(po2.getX(), po2.getY(), po3.getX(), po3.getY());
  line(po3.getX(), po3.getY(), po1.getX(), po1.getY());
  */
}

void mouseClicked() {
  p1 = random(0, 360);
  while (p1 == 360) { p1 = random(0, 360); }
  p2 = random(0, 360);
  while (p2 == 360) { p2 = random(0, 360); }
  p3 = random(0, 360);
  while (p3 == 360) { p3 = random(0, 360); }
}

class Point {
  float x, float y;

  void setCoors(float angle) {
    x = WIDTH / 2 + cos(angle) * 500;
    y = WIDTH / 2 + sin(angle) * 500;
  }

  float getX() { return x; }
  float getY() { return y; }
}


