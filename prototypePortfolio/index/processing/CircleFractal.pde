int stime;
int etime;
int lastPrinted;

void setup(){
  size(1000,1000);
  background(255);
}

void draw(){ 
  background(255);
  drawCircle(500,500,500);
}

void drawCircle(float x, float y, float radius) {
  stroke(0);
  noFill();
  ellipse(x, y, radius, radius);
  
  if(radius > 2) {
    drawCircle(x + radius/2, y, radius/2);
    drawCircle(x - radius/2, y, radius/2);
    drawCircle(x, y + radius/2, radius/2);
    drawCircle(x, y - radius/2, radius/2);
  }
}