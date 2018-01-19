PImage img;
int rectHeight, rectWidth;
int rectX, rectY;
float angle;
float circleNumber;
float circleSize;
int increment;
int currentCircle;
int stage;
int shapesCount;

void setup() {
  size(900,900);
  background(0,0,0);
  
  //img = loadImage( "thing.png" );
  
  angle = 3*PI/2;
  circleSize = 100;
  circleNumber = 15;
  increment = 0;
  stage = 0;
  shapesCount = 0;
  
  drawText();
  
  PFont bold;
  bold = createFont("Arial Bold", 30);
  textFont(bold);
  
  drawCircles(0);
  drawBackground();
}

void drawCircles(int inc){
  ellipseMode(CENTER);
  angle = 3*PI/2 + inc*(PI/360);
  for (int i=1; i < circleNumber+1; i++){
    fill(255,255,255);
     ellipse(200*cos(angle)+height/2,
             200*sin(angle)+width/2,
             circleSize, circleSize);
             
     textAlign(CENTER,CENTER);
     textSize(30);
     fill(0,0,0);
     text(i,200*cos(angle)+height/2,
          200*sin(angle)+width/2);
     angle += TWO_PI / circleNumber;
  }
}

void drawBackground(){
  ellipseMode(CENTER);
  fill(255,255,255);
  ellipse(height/2, width/2, 700, 700);
  fill(0,0,0);
  ellipse(height/2, width/2, 500, 500);
  fill(255,255,255);
  ellipse(height/2, width/2, 300, 300);
}

void drawText(){
  textAlign(CENTER, CENTER);
  textSize(25);
  fill(255,255,255);
  text("", 450, 50);
}

void update(float X, float Y){
  
  background(0,0,0);
  drawBackground();
  drawText();
  drawCircles(increment);
  
  if (!checkCircle(X, Y))
    increment++;

}

boolean checkCircle(float X, float Y)
{
 angle = 3*PI/2 + increment*(PI/360);
  
 for (int i=1; i < circleNumber+1; i++){
    float currentX = 200*cos(angle)+height/2;
    float currentY = 200*sin(angle)+width/2;
    
    
    if ((sqrt(sq(currentX-X) + sq(currentY-Y)) < circleSize/2 )) {
      currentCircle = i;
      
      fill(255,255,255);
      ellipse(200*cos(angle)+height/2,
             200*sin(angle)+width/2,
             circleSize*2, circleSize*2);
      textAlign(CENTER,CENTER);
      textSize(60);
      fill(0,0,0);
      text(i,200*cos(angle)+height/2,
          200*sin(angle)+width/2);
      return true;
    }
    angle += TWO_PI / circleNumber;
  } 
  return false;
}

void mousePressed(){
  if (stage == 0){
    angle = 3*PI/2 + increment*(PI/360);
    if (checkCircle(mouseX, mouseY)){
        stage += currentCircle;
    } 
  }
  else if (stage == 1){
    stage = 0; 
  }
  else if (stage == 2){
    stage = 0; 
  }
  else if (stage == 3){
    stage = 0; 
  }
  else if (stage == 4){
    stage = 0; 
  }
  else if (stage == 5){
    stage = 0; 
  }
  else if (stage == 6){
    stage = 0; 
  }
  else if (stage == 7){
    stage = 0; 
  }
  else if (stage == 8){
    stage = 0; 
  }
  else if (stage == 9){
    stage = 0; 
  }
  else if (stage == 10){
    stage = 0; 
  }
  else if (stage == 11){
    stage = 0; 
  }
  else if (stage == 12){
    stage = 0; 
  }
  else if (stage == 13){
    stage = 0; 
  }
  else if (stage == 14){
    stage = 0; 
  }
  else if (stage == 15){
    stage = 0; 
  }
}

void shapes(){
  //if (shapesCount == 1)
    background(0,0,0);
  
    fill(255,255,255); 
    
    ellipse(450,225,250,250);
    ellipse(450,500,200,500); 
    rectMode(CENTER);
    rect(450,450,375,125);
    triangle(450,625,300,750,600,750);
    
    textAlign(CENTER, CENTER);
    textSize(25);
    fill(255,255,255);
    text("Shapes", 450, 50);
}

void draw() {
  if (stage == 0)
    update(mouseX, mouseY);
  else if (stage == 1){
    shapesCount++;
    shapes();
  }
  else if (stage == 2){
    background(0,0,0);
    textAlign(CENTER, CENTER);
    textSize(25);
    fill(255,255,255);
    text(stage, 450, 50);
  }
  else if (stage == 3){
    background(0,0,0);
    textAlign(CENTER, CENTER);
    textSize(25);
    fill(255,255,255);
    text(stage, 450, 50);
  }
  else if (stage == 4){
    background(0,0,0);
    textAlign(CENTER, CENTER);
    textSize(25);
    fill(255,255,255);
    text(stage, 450, 50);
  }
  else if (stage == 5){
    background(0,0,0);
    textAlign(CENTER, CENTER);
    textSize(25);
    fill(255,255,255);
    text(stage, 450, 50);
  }
  else if (stage == 6){
    background(0,0,0);
    textAlign(CENTER, CENTER);
    textSize(25);
    fill(255,255,255);
    text(stage, 450, 50);
  }
  else if (stage == 7){
    background(0,0,0); 
    textAlign(CENTER, CENTER);
    textSize(25);
    fill(255,255,255);
    text(stage, 450, 50);
  }
  else if (stage == 8){
    background(0,0,0);
    textAlign(CENTER, CENTER);
    textSize(25);
    fill(255,255,255);
    text(stage, 450, 50);
  }
  else if (stage == 9){
    background(0,0,0);
    textAlign(CENTER, CENTER);
    textSize(25);
    fill(255,255,255);
    text(stage, 450, 50);
  }
  else if (stage == 10){
    background(0,0,0); 
    textAlign(CENTER, CENTER);
    textSize(25);
    fill(255,255,255);
    text(stage, 450, 50);
  }
  else if (stage == 11){
    background(0,0,0);
    textAlign(CENTER, CENTER);
    textSize(25);
    fill(255,255,255);
    text(stage, 450, 50);
  }
  else if (stage == 12){
    background(0,0,0);
    textAlign(CENTER, CENTER);
    textSize(25);
    fill(255,255,255);
    text(stage, 450, 50);
  }
  else if (stage == 13){
    background(0,0,0);
    textAlign(CENTER, CENTER);
    textSize(25);
    fill(255,255,255);
    text(stage, 450, 50);
  }
  else if (stage == 14){
    background(0,0,0);
    textAlign(CENTER, CENTER);
    textSize(25);
    fill(255,255,255);
    text(stage, 450, 50);
  }
  else if (stage == 15){
    background(0,0,0); 
    textAlign(CENTER, CENTER);
    textSize(25);
    fill(255,255,255);
    text(stage, 450, 50);
  }
  
}