Ball[] balls = new Ball[40];

void setup(){
  
  size(640,360);
  background(255);
  for (int i = 0; i< balls.length; i++){
    
    balls[i] = new Ball();
    
  }
  
}

void draw(){
 
  background(255);
  
  for (int i = 0; i < balls.length; i++){
    
    balls[i].update();
    balls[i].checkEdges();
    balls[i].display();
    
  }
  
}

class Ball {
  
  PVector location;
  PVector velocity;
  PVector acceleration;
  float topspeed;
  
  Ball(){
    location = new PVector(random(width), random(height));
    velocity = new PVector(0,0);
    topspeed = 10;
  }
  
  void update(){
    
    PVector mouse = new PVector(mouseX, mouseY);
    PVector dir = PVector.sub(mouse, location);
    
    dir.normalize();
    
    dir.mult(0.5);
    
    acceleration = dir;
    
    velocity.add(acceleration);
    velocity.limit(topspeed);
    location.add(velocity);
    
  }
  
  void display(){
    stroke(0);
    fill(175);
    ellipse(location.x, location.y, 16, 16);
  }

  void checkEdges(){
    if ( (location.x > width) || (location.x < 0) ){
      velocity.x = velocity.x * -1;
    }
    if ( (location.y > height) || (location.y < 0) ){
      velocity.y = velocity.y * -1;
    }
  }

}