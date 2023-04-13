// Test program for the PEmbroider library for Processing:
// Different methods for filling (hatching) shapes with PEmbroider: 
// * PEmbroiderGraphics.PERLIN
// * PEmbroiderGraphics.CROSS
// * PEmbroiderGraphics.DRUNK
// * PEmbroiderGraphics.VECFIELD

import processing.embroider.*;
PEmbroiderGraphics E;

int[] hatchModes = {
    PEmbroiderGraphics.PERLIN,
    PEmbroiderGraphics.CROSS,
    PEmbroiderGraphics.PARALLEL,
    PEmbroiderGraphics.CONCENTRIC,
    PEmbroiderGraphics.SPIRAL,
  };
  
// int skip = 10;


void setup() {
  noLoop(); 
  size (1000, 1000);
  E = new PEmbroiderGraphics(this, width, height);
  
  String fileName = "hatching" + str(int(random(10000)));

  // SVG
  String outputFilePath = sketchPath(String.format(fileName + ".svg"));
  // PLOTTER-SPECIFIC COMMANDS: 
  // Set this to false so that there aren't superfluous waypoints on straight lines:
  E.toggleResample(false);
  // Set this to false so that there aren't connecting lines between shapes. 
  // Note that you'll still be able to pre-visualize the connecting lines 
  // (the plotter path) if you set E.visualize(true, true, true);
  E.toggleConnectingLines(false);
  // This affects the visual quality of inset/offset curves for CONCENTRIC fills:
  E.CONCENTRIC_ANTIALIGN = 0.0;
  
  // PES //*
  //String outputFilePath = sketchPath("hatching1.pes");

  E.setPath(outputFilePath); 
  E.beginDraw(); 
  E.clear();
  E.strokeWeight(1); 
  E.fill(0, 0, 0); 
  E.noStroke(); 


  //-----------------------

  int firstCoordinate = 25;
    
  int rowCount = 3;
  int colCount = rowCount;
  
  int size = width/rowCount - rowCount * firstCoordinate;
    
  for (int i = 0; i < rowCount; i++) {
    for (int j = 0; j < colCount; j++) {
      /* randomly skipping was cool, this didn't work
      if (int(random(0,100))%skip == 0) {
        println("skipping");
        return;
      } */ 
      E.HATCH_MODE = randomArrayItem(hatchModes);
      E.HATCH_SPACING = int(random(10,20));
      E.HATCH_SCALE = int(random(1,10));
      
      int xPad = firstCoordinate * (i + 1);
      int x = i * size + xPad;
      
      int yPad = firstCoordinate * (j + 1);
      int y = j * size + yPad;
     
      // rect(upper left x, y, width, height, radius)
      E.rect( x, y, size, size);
      //println(i,j,E.HATCH_MODE);
    }
  }
  
  //-----------------------
  // E.optimize(); // slow, but good and important
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


//------------
public int randomArrayItem(int[] array) {
  int index = (int)random(array.length);
  int item = array[index];
  // println(item, index);
  return item;
}


//--------------------------------------------
void draw() {
  ;
}
