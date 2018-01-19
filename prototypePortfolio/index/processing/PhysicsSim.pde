Ball[] balls = new Ball[50];
Liquid liquid;

void setup(){
  
  size(1000,1000);
  background(255);
  for (int i = 0; i< balls.length; i++){
    balls[i] = new Ball(random(0.1,5), random(0,width), 0);
  }
  
  liquid = new Liquid(0, height/2, width, height/2, 0.01);
  
}

void draw(){
 
  background(255);
  
  PVector wind = new PVector(0.1, 0);
  
  liquid.display();
  
  for (int i = 0; i < balls.length; i++){
    
    if (mousePressed){
      balls[i].applyForce(wind);
    }
    
    if (balls[i].isInside(liquid)){
      balls[i].drag(liquid); 
    }
    
    float m = balls[i].mass;
    PVector gravity = new PVector(0, 0.1*m);
    balls[i].applyForce(gravity);
    
    balls[i].update();
    balls[i].checkEdges();
    balls[i].display();
    
  }
}



class Ball {
 
  PVector location;
  PVector velocity; 
  PVector acceleration;
  
  float mass;
  
  Ball(float m, float x, float y){
    location = new PVector(x, y);
    velocity = new PVector(0,0);
    acceleration = new PVector(0,0);
    mass = m;
  }
  
  void applyForce(PVector force) {
    PVector f = PVector.div(force,mass);
    acceleration.add(f);
  }
  
  void update(){
    velocity.add(acceleration);
    location.add(velocity);
    acceleration.mult(0);
  }
  
  void display(){
    stroke(0);
    fill(175);
    ellipse(location.x, location.y, mass*16, mass*16);
  }
  
  void checkEdges(){
    if (location.x > width) {
      location.x = width;
      velocity.x *= -1;
    } else if (location.x < 0) {
      velocity.x *= -1;
      location.x = 0;
    }

    if (location.y > height) {
      velocity.y *= -1;
      location.y = height;
    }
  }
  
  boolean isInside(Liquid l){
    if (location.x>l.x && location.x<l.x+l.w && location.y>l.y && location.y<l.y+l.h){
      return true;
    }
    else{
      return false;
    }
  }
  
  void drag(Liquid l){
   
    float speed = velocity.mag();
    float dragMagnitude = l.c * speed * speed;
    
    PVector drag = velocity.get();
    drag.mult(-1);
    drag.normalize();
    
    drag.mult(dragMagnitude);
    
    applyForce(drag);
    
  }
  
}

class Liquid{
 
  float x, y, w, h;
  float c;
  
  Liquid(float x_, float y_, float w_, float h_, float c_){
    x = x_;
    y = y_;
    w = w_;
    h = h_;
    c = c_;
  }
  
  void display(){
   noStroke();
   fill(175);
   rect(x, y, w, h);
  }
  
}