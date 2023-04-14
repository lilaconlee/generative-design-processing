// Test program for the PEmbroider library for Processing:
// Basic shapes

import processing.embroider.*;
PEmbroiderGraphics E;

PImage img;
String imgName = "img1.jpeg";

void setup() {
  noLoop(); 
  size (1200, 1200);
   img = loadImage(imgName);

  E = new PEmbroiderGraphics(this, width, height);
  String outputFilePath = sketchPath("PEmbroider_ruler.pes");
  E.setPath(outputFilePath); 

  E.beginDraw(); 
  E.clear();
  E.noFill();
  E.strokeWeight(1); 
  E.setStitch(10, 25, 0); 
  
  
  E.beginRepeatEnd(2);


  float mm = 10; 
  float cm = 10*mm;
  int nMm = 60;
  float w = nMm*mm; 
  float x0 = 0;
  float x1 = x0 + w;
  float y0 = 2*cm;
  float inch = 25.4*mm;
  float quarterInch = inch/4.0; 

  rect(0,0,inch *4, inch*4);
  image(img, 0, 0, inch*4, inch*4);


  // Inch ruler:

  for (int i=0; i<=18; i++) {
    float px = x0 + i*quarterInch;
    if (i%4 == 0) {
      E.line (px, y0, px, y0-cm*1.0);
    } else if (i%2 == 0) {
      E.line (px, y0, px, y0-cm*0.5);
    } else {
      E.line (px, y0, px, y0-cm*0.25);
    }
  }

  

  E.textSize(2.0); 
  E.text("IN", x0, y0-150);

  E.endRepeatEnd();

  //-----------------------
  //E.optimize(); // slow, but very good and very important);
  E.visualize(); 
  E.endDraw(); // write out the file
  //save("PEmbroider_ruler.png");
}
