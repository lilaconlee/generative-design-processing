// Test program for the PEmbroider library for Processing:
// Different methods for filling (hatching) shapes with PEmbroider: 
// * PEmbroiderGraphics.PERLIN
// * PEmbroiderGraphics.CROSS
// * PEmbroiderGraphics.DRUNK
// * PEmbroiderGraphics.VECFIELD

import processing.embroider.*;
PEmbroiderGraphics E;


void setup() {
  noLoop(); 
  size (1000, 1000);
  E = new PEmbroiderGraphics(this, width, height);

  // SVG
  //String outputFilePath = sketchPath(String.format("hatching", str(int(random(10000))), ".svg"));
  //String outputFilePath = sketchPath("hatching.svg");
  // PLOTTER-SPECIFIC COMMANDS: 
  // Set this to false so that there aren't superfluous waypoints on straight lines:
  //E.toggleResample(false);
  // Set this to false so that there aren't connecting lines between shapes. 
  // Note that you'll still be able to pre-visualize the connecting lines 
  // (the plotter path) if you set E.visualize(true, true, true);
  //E.toggleConnectingLines(false);
  // This affects the visual quality of inset/offset curves for CONCENTRIC fills:
  //E.CONCENTRIC_ANTIALIGN = 0.0;
  
  // PES //*
  String outputFilePath = sketchPath("hatching1.pes");

  E.setPath(outputFilePath); 
  E.beginDraw(); 
  E.clear();
  E.strokeWeight(1); 
  E.fill(0, 0, 0); 
  E.noStroke(); 


  //-----------------------
  int size = 400;
  int hatchMode = PEmbroiderGraphics.PERLIN;
  int firstCoordinate = 25;
  
  
  int rowCount = 2;
  int colCount = rowCount;
  
  for (int i = 0; i < rowCount; i++) {
    for (int j = 0; j < colCount; j++) {
      E.HATCH_MODE = hatchMode;
      E.HATCH_SPACING = int(random(10,20));
      E.HATCH_SCALE = int(random(1,10));
      
      int xPad = firstCoordinate * (i + 1);
      int x = i * size + xPad;
      
      int yPad = firstCoordinate * (j + 1);
      int y = j * size + yPad;
     
      // rect(upper left x, y, width, height, radius)
      E.rect( x, y, size, size);
    }
  }
  
  //-----------------------
  E.optimize(); // slow, but good and important
  E.visualize();
  E.endDraw(); // write out the file
  //save("PEmbroider_shape_hatching_2.png");
}


//--------------------------------------------
class MyVecField implements PEmbroiderGraphics.VectorField {
  public PVector get(float x, float y) {
    x*=0.1;
    return new PVector(1, 2*sin(x));
  }
}


//--------------------------------------------
void draw() {
  ;
}
