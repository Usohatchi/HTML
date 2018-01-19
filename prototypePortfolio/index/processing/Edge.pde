PImage img;

void setup() 
{
  size(400,349);
  background(0,0,0);
  img = loadImage( "frog-1.jpg" );
}

float colorDist(color pOne,  color pTwo)
{
  float r = red(pOne) - red(pTwo);
  float g = green(pOne) - green(pTwo);
  float b = blue(pOne) - green(pTwo);
  float distance = sqrt( sq(r) + sq(g) + sq(b) );
  
  return distance;
}

float hsbDist(float bright1, float hue1, float bright2, float hue2)
{
  float b = bright1 - bright2;
  float h = hue1 = hue2;
  float distance = sqrt( sq(b) + sq(h) );
  
  return distance;
}

void draw() 
{
  loadPixels();

  img.loadPixels(); 
  for (int y = 1; y < height-1; y++ ) 
  {
    for (int x = 1; x < width-1; x++ ) 
    {
      int loc = x + y*width;
      
      color colorCurrent = color(img.pixels [loc]);
      color colorLeft = color(img.pixels [loc-1]);
      color colorRight =  color(img.pixels [loc+1]);
      color colorUp =  color(img.pixels [loc-width]);
      color colorDown = color(img.pixels [loc+width]);
      
      float brightCurrent = brightness(img.pixels [loc]);
      float hueCurrent = hue(img.pixels [loc]);
      float brightLeft = brightness(img.pixels [loc-1]);
      float hueLeft = hue(img.pixels [loc-1]);
      float brightRight = brightness(img.pixels [loc+1]);
      float hueRight = hue(img.pixels [loc+1]);
      float brightUp = brightness(img.pixels [loc-width]);
      float hueUp = hue(img.pixels [loc-width]);
      float brightDown = brightness(img.pixels [loc+width]);
      float hueDown = hue(img.pixels [loc+width]);
      
      pixels [loc] = color(colorCurrent);
      
      float valueLeft = colorDist(colorCurrent,colorLeft) + abs(brightCurrent - brightLeft) + abs(hueCurrent-hueLeft);// + hsbDist(brightCurrent, hueCurrent, brightLeft, hueLeft);
      float valueRight = colorDist(colorCurrent,colorRight) + abs(brightCurrent - brightRight) + abs(hueCurrent-hueRight);// + hsbDist(brightCurrent, hueCurrent, brightRight, hueRight);
      float valueUp = colorDist(colorCurrent,colorUp) + abs(brightCurrent - brightUp) + abs(hueCurrent-hueUp);// + hsbDist(brightCurrent, hueCurrent, brightUp, hueUp);
      float valueDown = colorDist(colorCurrent,colorDown) + abs(brightCurrent - brightDown) + abs(hueCurrent-hueDown);// + hsbDist(brightCurrent, hueCurrent, brightDown, hueDown);
      
      /*println("Left: " + valueLeft);
      println("Right " + valueRight);
      println("Up " + valueUp);
      println("Down " + valueDown);*/
      
      if ( (valueLeft > 90) || (valueRight > 90) || (valueUp > 90) || (valueDown > 90))
      {
        pixels[loc] = color(0);  
      }
      
    }
  }
  updatePixels();
}